## Setup
- We used Kurtosis-tech's ethereum-package to simulate a private ethereum proof of stake [testnet](https://docs.nethermind.io/fundamentals/private-networks/)
- Experiments were performed using Node version 20
 
Setting up the Testnet:
 1) Install [kurtosis](https://docs.kurtosis.com/install/)
 2) In the `auto-diamond` directory, run `sudo kurtosis run --enclave my-testnet github.com/kurtosis-tech/ethereum-package --args-file network_params_5nodes.yaml`
 
This will spin up a 5 node proof-of-stake ethereum network. Once the testnet is ready we have to setup hardhat config files
 
Setting up Hardhat:
 1) In the `hardhat` directory, run `npm install` to install nodejs packages
 2) Run `sudo kurtosis enclave inspect my-testnet` and navigate to the el nodes
 3) In hardhat.config.js replace port numbers of network1.url and network2.url with rpc port numbers of any 2 `el` nodes
 
 Now to run any script use the command `npx hardhat run <script_path> --network network1` or `npx hardhat run <script_path> --network network2` in the `hardhat` directory.
 
 Eg:- `npx hardhat run scripts/N-deploySavings.js --network network1`
 
## Running the `auto-convert` Script
 
In the auto-convert directory
- run `npm install`
- run `node auto-convert-store.js <input_contract_path> <output_directory_path>`. This will create a folder containing the facets of the input contract. This will give an error in case the smart contract contains inheritance.
 
