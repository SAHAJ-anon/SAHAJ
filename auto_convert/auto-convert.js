const fs = require("fs");
const path = require('path');
const prettier = require("prettier");
const parser = require("@solidity-parser/parser");
const { handleArguments } = require('./argsHandler');
const filepath = handleArguments()
const LIB_NAME = "Test";

var CONTRACT_NAME, START;
var STRUCT_VARIABLES = "";
var struct_checker = [];
let function_names = [];
var declare_checker = [];
var eventMap = new Map();
var INIT_VALUES = new Map();

let V;
let adjList = new Map();
let visited_array_functions = new Map();
let functions_information = new Map();

// Adds an edge to an undirected graph
function addEdge(src, dest) {
	// Add an edge from src to dest.
	if (!adjList.has(src)) {
		adjList.set(src, []);
	}
	
	if (!adjList.has(dest)) {
		adjList.set(dest, []);
	}
	
	// Add the caller function to the adjacency list of the called function
	adjList.get(src).push(dest);
	adjList.get(dest).push(src);
}

function DFSUtil(key,reached_functions) {
	// Mark the current node as visited and print it
	visited_array_functions.set(key,true);
	reached_functions.push(key)
	// Recur for all the vertices
	// adjacent to this vertex
	for (let x = 0; x < adjList.get(key).length; x++) {
		if (!visited_array_functions.get(adjList.get(key)[x]))
			DFSUtil(adjList.get(key)[x], reached_functions);
	}
}

function connectedComponents() {	
	for (let [key, value] of visited_array_functions) {
		if (value == false) {
			var reached_functions = []
			DFSUtil(key, reached_functions);
			generateFacetFiles(reached_functions)
		}
	}
}

function generateFacetFiles(function_array) {

	var srcCode = fs.readFileSync(filepath, "utf8");
	srcCode = prettier.format(srcCode, {
		parser: "solidity-parse",
	});

	//collect all function code from entire connected component
	let allEvents = '', allFunctionCode= '';
	for (let index = 0; index < function_array.length; index++) {
		allEvents += functions_information.get(function_array[index]).events
		allFunctionCode += functions_information.get(function_array[index]).rePlacedCode

	}


	const fileCode = `
	${srcCode
			.split("\n")
			.slice(0, START - 1)
			.join("\n")}
	import "./${LIB_NAME}Lib.sol";
    contract ${function_array[0]}Facet {
      ${allEvents}
      ${allFunctionCode}
    }
  `;
	const fileName = `${CONTRACT_NAME}facets/${function_array[0]}Facet.sol`;
	const formattedCode = prettier.format(fileCode, {
		parser: "solidity-parse",
	});
	fs.writeFileSync(fileName, formattedCode);
}


function distributeFunctions() {
	var sourceCode = fs.readFileSync(filepath, "utf8");
	sourceCode = prettier.format(sourceCode, {
		parser: "solidity-parse",
	});
	// Parse Solidity code into an AST
	var ast = parser.parse(sourceCode, { loc: true });
	for (let i = 0; i < ast.children.length; i++) {
		const node = ast.children[i];
		if (node.type === "ContractDefinition") {
			CONTRACT_NAME = node.name;
			START = node.loc.start.line;
			break;
		}
	}
	//make directory for contract folders	
	fs.mkdir(`./${CONTRACT_NAME}facets`, { recursive: true },err=>{
		if (err) throw err;
	});
	
	// Traverse AST to identify function declarations

	//find all state variables
	ast.children.forEach((node) => {
		node.subNodes?.forEach((subNode) => {
			if (subNode.type == "StateVariableDeclaration") {
				var varType;
				const typeName = subNode.variables[0].typeName;
				if (typeName.type == "ArrayTypeName") {
					varType =
						typeName.baseTypeName.name +
						`[${
							typeName.length != null
								? typeName.length.number
								: ""
						}]`;
				} else if (typeName.type == "Mapping") {
					varType =
						"mapping(" +
						typeName.keyType.name +
						"=>" +
						typeName.valueType.name +
						")";
				} else if (typeName.type == "UserDefinedTypeName") {
					varType = typeName.namePath;
				} else {
					varType = typeName.name;
				}
				const varName = subNode.variables[0].name;

				struct_checker.push(varName);
				if (subNode.variables[0].expression) {
					const start = subNode.loc.start.line;
					const end = subNode.loc.end.line;
					const lineOfCode = sourceCode
						.split("\n")
						.slice(start - 1, end)
						.join("\n");
					var index = 0;
					let currentChar = lineOfCode[index];
					while (currentChar !== ";") {
						if (currentChar === "=") {
							INIT_VALUES.set(varName, [
								lineOfCode.substring(index, lineOfCode.length),
								0,
							]);
							break;
						}
						index++;
						currentChar = lineOfCode[index];
					}
				}
				if (typeName.stateMutability == "payable") {
					STRUCT_VARIABLES += `${varType} payable ${varName};\n`;
				} else {
					STRUCT_VARIABLES += `${varType} ${varName};\n`;
				}
			} else if (subNode.type == "EventDefinition") {
				if (!eventMap.has(subNode.name)) {
					eventMap.set(subNode.name, []);
				}
				eventMap.get(subNode.name).push(subNode);
			}
		});
	});

	if (STRUCT_VARIABLES == "") {
		console.log(
			"As there are no state variables you can directly use the contract, state is not vulnerable"
		);
		return;
	}

	//Struct declarations (currently)
	var declrations = "";
	ast.children.forEach((node) => {
		node.subNodes?.forEach((subNode) => {
			if (
				subNode.type == "StructDefinition" ||
				subNode.type == "EnumDefinition"
			) {
				// struct_checker.push(subNode.name);
				const start = subNode.loc.start.line;
				const end = subNode.loc.end.line;
				var splitArray = sourceCode.split("\n");
				const vassr = splitArray.slice(start - 1, end).join("\n");
				declrations += `${vassr}`;
				declare_checker.push(subNode.name);
			}
		});
	});

	//generate library file
	generateLibraryFile(sourceCode,declrations)
	
	//functions
	//first find the name of all defined functions such that they can be imported in a facet properly

	ast.children.forEach((node) => {
		if (node.type === "ContractDefinition") {
			node.subNodes.forEach((subNode) => {
				if (
					subNode.type === "FunctionDefinition" &&
					subNode.isConstructor == false
				) {
					function_names.push(subNode.name);
				}
			});
		}
	});

	
	ast.children.forEach((node) => {
		if (node.type === "ContractDefinition") {
			node.subNodes.forEach((subNode) => {
				if (
					subNode.type === "FunctionDefinition" &&
					subNode.isConstructor == false
				) {
					const fileName = `${CONTRACT_NAME}facets/${subNode.name}Facet.sol`;
					const fileContents = generateFileContents(
						subNode,
						sourceCode
					);
					functions_information.set(subNode.name,fileContents);
					//make this function visited = false in visited map
					visited_array_functions.set(subNode.name,false) ;					
				}
			});
		}
	});

	//resolve the graph of functions to generate facet files
	connectedComponents()

	// constructor file;
	// ast.children.forEach((node) => {
	// 	if (node.type === "ContractDefinition") {
	// 		node.subNodes.forEach((subNode) => {
	// 			if (
	// 				subNode.type === "FunctionDefinition" &&
	// 				subNode.isConstructor == true
	// 			) {
	// 				const fileContents = generateFileContents(
	// 					subNode,
	// 					sourceCode
	// 				);
	// 				// console.log(subNode)
	// 				const formattedCode = prettier.format(fileContents, {
	// 					parser: "solidity-parse",
	// 				});
	// 				fs.writeFileSync(
	// 					`${CONTRACT_NAME}facets/${CONTRACT_NAME}Facet.sol`,
	// 					formattedCode
	// 				);
	// 				// var sourceCodeDiamond = fs.readFileSync("Diamond.sol", "utf8");
	// 				// sourceCodeDiamond = prettier.format(sourceCodeDiamond, {
	// 				// 	parser: "solidity-parse",
	// 				// });
	// 				// // Parse Solidity code into an AST
	// 				// var astDiamond = parser.parse(sourceCodeDiamond, { loc: true });
					

	// 			}
	// 		});
	// 	}
	// });
}





function generateFileContents(node, sourceCode) {
	// Generate contents of new file based on function declaration node
	const start = node.loc.start.line;
	const end = node.loc.end.line;
	var splitArray = sourceCode.split("\n");
	const functionCode = splitArray.slice(start - 1, end).join("\n");
	var diamondStorageImportStatement = `${LIB_NAME}Lib.${LIB_NAME}Storage storage ds = ${LIB_NAME}Lib.diamondStorage();`;
	var isImportRequiredFlag = 0;

	const structRegExp = new RegExp(
		"\\b(" + struct_checker.join("|") + ")\\b",
		"g"
	);
	const structRegExpDeclarations = new RegExp(
		"\\b(" + declare_checker.join("|") + ")\\b",
		"g"
	);
	var rePlacedCode = "";

	// avoid matching empty regex
	if (declare_checker.length > 0) {
		rePlacedCode += functionCode
			.replace(structRegExp, (match) => {
				isImportRequiredFlag = 1;
				return `ds.${match}`;
			})
			.replace(structRegExpDeclarations, (match) => {
				return `${LIB_NAME}Lib.${match}`;
			});
	} else {
		rePlacedCode += functionCode.replace(structRegExp, (match) => {
			isImportRequiredFlag = 1;
			return `ds.${match}`;
		});
	}

	if (node.name == null) {
		var collectedHere = "";

		for (let [key, value] of INIT_VALUES) {
			if (value[1] == 0) {
				collectedHere += `${key} ${value[0]}`;
				value[1] = 1;
			}
		}

		var filtered = "";
		filtered += collectedHere.replace(structRegExp, (match) => {
			isImportRequiredFlag = 1;
			return `ds.${match}`;
		});

		rePlacedCode =
			rePlacedCode.slice(0, rePlacedCode.indexOf("{") + 1) +
			"\n" +
			filtered +
			rePlacedCode.slice(rePlacedCode.indexOf("{") + 1);
	}

	if (isImportRequiredFlag == 1) {
		const index = rePlacedCode.indexOf("{");
		rePlacedCode =
			rePlacedCode.slice(0, index + 1) +
			"\n" +
			diamondStorageImportStatement +
			rePlacedCode.slice(index + 1);
	}
	var events = "";
	const emitRegExp = /emit\s+([a-zA-Z0-9_]+)\s*\((.*?)\)\s*;/g;
	var visited = new Map();
	let emitMatch;
	while ((emitMatch = emitRegExp.exec(rePlacedCode)) !== null) {
		const eventName = emitMatch[1];
		if (visited.get(eventName) != true) {
			visited.set(eventName, true);
			const matchingEvents = eventMap.get(eventName) || [];
			// If there are matching events, add them to the events variable
			if (matchingEvents.length > 0) {
				matchingEvents.forEach((event) => {
					const startLine = event.loc.start.line;
					const endLine = event.loc.end.line;
					const eventCode = sourceCode
						.split("\n")
						.slice(startLine - 1, endLine)
						.join("\n");
					events += eventCode;
				});
			}
		}
	}
	// function call regex
	const functionCallPattern = /([a-zA-Z_]\w*)\s*\(/g;

	// Extract all function calls from the source code
	const functionCalls = [];
	let match;
	while ((match = functionCallPattern.exec(functionCode)) !== null) {
		const functionName = match[1];
		functionCalls.push(functionName);
	}

	//remove name of itself
	functionCalls.splice(0,1);
 
	
	functionCalls.forEach((element) => {
		if (function_names.includes(element)) {
			if(node.name!=null){
				addEdge(node.name,element)
			}			
		}
	});
	//if function does not have any dependecies, add it as an empty array

	if(!adjList.has(node.name)){
		adjList.set(node.name,[])
	}
		
	return {
		events,
		rePlacedCode		
	}

    ;
}

function generateLibraryFile(sourceCode,declrations){
	// create library
	const libCode = `
	${sourceCode
			.split("\n")
			.slice(0, START - 1)
			.join("\n")}
	library ${LIB_NAME}Lib {

    bytes32 constant DIAMOND_STORAGE_POSITION = keccak256("diamond.standard.${LIB_NAME}.storage");
    ${declrations}
    struct ${LIB_NAME}Storage {		
          ${STRUCT_VARIABLES}
    }

    function diamondStorage() internal pure returns (${LIB_NAME}Storage storage ds) {
      bytes32 position = DIAMOND_STORAGE_POSITION;
          assembly {
              ds.slot := position
          }
      }
    }`;
	const formattedCode = prettier.format(libCode, {
		parser: "solidity-parse",
	});
	fs.writeFileSync(`${CONTRACT_NAME}facets/${LIB_NAME}Lib.sol`, formattedCode);

}



distributeFunctions();