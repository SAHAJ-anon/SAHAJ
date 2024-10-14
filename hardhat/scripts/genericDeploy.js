/* global describe it before ethers */

const {
    getSelectors,
    FacetCutAction,
} = require("./libraries/diamond.js");

const { logtime } = require("./libraries/timelogger");
const { deployDiamond } = require("./deploy.js");
const { assert } = require('chai');
const { ethers } = require("hardhat");
const fs = require("fs");
const path = require("path");

async function deployFacetsFromFolder(folderPath, diamondCutFacet, totalGasUsed, contractOwner) {
    const facets = fs.readdirSync(folderPath);
    console.log("\nDeploying Facets from folder\n");
    
    for (const file of facets) {
        if (path.extname(file) === '.sol' && file !== 'TestLib.sol') {
            const filePath = path.join(folderPath, file);
            const contractName = file.split(".")[0];
            // Constructing the fully qualified name
            const fullyQualifiedName = `contracts/${path.basename(folderPath)}/${file}:${contractName}`;
            console.log(`Deploying ${fullyQualifiedName} from ${filePath}...`);
            
            try {
                const facetFactory = await ethers.getContractFactory(fullyQualifiedName);
                const facetInstance = await facetFactory.deploy();
                await facetInstance.deployed();
                const receipt = await facetInstance.deployTransaction.wait();
                totalGasUsed = totalGasUsed.add(receipt.gasUsed);
                console.log(`${contractName} deployed: ${facetInstance.address}`);
                
                const selectors = getSelectors(facetInstance);
                const tx = await diamondCutFacet.connect(contractOwner).diamondCut(
                    [{
                        facetAddress: facetInstance.address,
                        action: FacetCutAction.Add,
                        functionSelectors: selectors,
                    }],
                    ethers.constants.AddressZero,
                    "0x",
                    { gasLimit: 8000000 }
                );
                const receiptCut = await tx.wait();
                totalGasUsed = totalGasUsed.add(receiptCut.gasUsed);
                console.log(`${contractName} added to diamond. Transaction hash: ${tx.hash}`);
            } catch (error) {
                console.error(`Failed to deploy ${fullyQualifiedName}:`, error);
            }
        }
    }
    
    return totalGasUsed;
}

module.exports = { deployFacetsFromFolder };

async function deployDiamondWithFacets(facetsFolderPath) {
    let totalGasUsed = ethers.BigNumber.from(0);
    const accounts = await ethers.getSigners();
    const contractOwner = accounts[0];

    logtime();

    const addresses = []
    let diamondAddress;
    let diamondCutFacet;
    let diamondLoupeFacet;
    let ownershipFacet;
    const diamond = await deployDiamond();
    diamondAddress = diamond.address;

    const diamondDeploymentReceipt = await diamond.deployTransaction.wait();
    totalGasUsed = totalGasUsed.add(diamondDeploymentReceipt.gasUsed);
    console.log("Diamond contract deployed at:", diamondAddress);
    console.log("Gas used for deploying Diamond:", diamondDeploymentReceipt.gasUsed.toString());


    diamondCutFacet = await ethers.getContractAt(
        "DiamondCutFacet",
        diamondAddress
    );
    diamondLoupeFacet = await ethers.getContractAt(
        "DiamondLoupeFacet",
        diamondAddress
    );
    ownershipFacet = await ethers.getContractAt("OwnershipFacet", diamondAddress);

    for (const address of await diamondLoupeFacet.facetAddresses()) {
        addresses.push(address)
    }

    // Deploy additional facets from the folder
    totalGasUsed = await deployFacetsFromFolder(facetsFolderPath, diamondCutFacet, totalGasUsed, contractOwner);

    console.log("Total gas used during deployment:", totalGasUsed.toString());

    logtime();
    return { diamondAddress, totalGasUsed };
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
if (require.main === module) {
    const facetsFolder = "./contracts/ABRAfacets";
    if (!facetsFolder) {
        console.error("Please provide the path to the folder containing the facets.");
        process.exit(1);
    }

    deployDiamondWithFacets(facetsFolder)
        .then(({ diamondAddress, totalGasUsed }) => {
            console.log("Diamond contract deployed at:", diamondAddress);
            console.log("Total gas used:", totalGasUsed.toString());
            process.exit(0);
        })
        .catch((error) => {
            console.error(error);
            process.exit(1);
        });
}

exports.deployDiamondWithFacets = deployDiamondWithFacets;