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
- Set the `facetsFolderPath` variable in `genericDeployTest.js` to the path of the folder containing the diamond facets to be tested
- Example usage
```bash
# Checks deployment of Aierify.sol
# Run from within the test directory
npx hardhat test genericDeployTest.js
```

## Experiments

- `compiling_contract_store` contains all the contracts from the etherscan dataset that successfully compile
- `compiling_diamond_store` contains the diamond version of the contracts in `compiling_contract_store`. Note that not all of these diamond contracts successfully compile and deploy
- `experiment_output/gas_comparison_results.csv` contains the deployment details of all the diamond contracts in `compiling_diamond_store`