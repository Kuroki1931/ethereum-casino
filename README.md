# ot4-betting

## Markdown flowcharts

install _Markdown Preview Mermaid Support_ extension to vs-code

docs: https://mermaid-js.github.io/mermaid/#/flowchart

## Code format

VS Code Extension: juanblanco.solidity https://marketplace.visualstudio.com/items?itemName=JuanBlanco.solidity

## Truffle
```
npm install -g truffle
```

## Install dependencies
```
npm install
```

## Ganache
https://www.trufflesuite.com/ganache

## Setup
Use truffle to compile contracts by running this in project root
```
truffle compile
```
Then run first four migrations with (running 1st to 4th migration)
```
truffle migrate --f 1 --to 4
```
Now you should be able to see all contracts and their addresses in the terminal. Now update the 5_deploy_bank migration to include the addresses of all games. Then run
```
truffle migrate
```

Now enter the truffle develop console with
```
truffle develop
```
In the develop console, you can access all contracts, accounts and more. More docs here: https://trufflesuite.com/docs/truffle/getting-started/interacting-with-your-contracts
