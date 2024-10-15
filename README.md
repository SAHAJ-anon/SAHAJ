# README

## Auto Convert

- The `auto-convert` directory contains the `auto-convert.js` script which is used to convert a regular contract to its diamond version
- The script can be run as `node auto-convert.js <path-to-contract> <path-to-output-dir>`
- Example usage
```bash
# Run from within the auto_convert directory
node auto-convert.js ./auto_convert_tests/Example.sol ./auto_convert_tests/
```

## Hardhat

- Contains the hardhat project setup used for testing and deploying the various contracts
- Contains `test/genericDeployTest.js` which is used to test if a diamond converted contract successfully deploys
- Contains `scripts/genericDeploy.js` which is used to deploy a diamond converted contract and get its gas usage statistics
- Set the `facetsFolderPath` variable in `test/genericDeployTest.js` or `scripts/genericDeploy.js` to the path of the folder containing the diamond facets to be tested
- Example usage
```bash
# Checks deployment of Aierify.sol
# Run from within the test directory
npx hardhat test genericDeployTest.js
# Run from within the scripts directory
npx hardhat run genericDeploy.js
```

## Experiments

- `compiling_contract_store` contains all the contracts from the etherscan dataset that successfully compile
- `compiling_diamond_store` contains the diamond version of the contracts in `compiling_contract_store`. Note that not all of these diamond contracts successfully compile and deploy
- `experiment_output/gas_comparison_results.csv` contains the deployment details of all the diamond contracts in `compiling_diamond_store`
- `hardhat/scripts/automation.js` is used to automate the deployment and calculation of the diamond contracts in `compiling_diamond_store`. It creates the `gas_comparison_results.csv` file in the `experiment_output` directory