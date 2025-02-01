## Tech Used.

- Language -> Solidity
- Framework -> [Foundry](https://book.getfoundry.sh/)
- Cross-Chain Protocol -> [Wormhole](https://wormhole.com/docs/tutorials/by-product/contract-integrations/cross-chain-token-contracts/)

## How to proceed...


## Clone the repo.

```shell
$ git clone https://github.com/Shivamycodee/c2t2
```

### Add private key.

- Create a .env file and add private key in it.

```shell
 PRIVATE_KEY= CREATOR_PRIVATE_KEY
```

### Build

```shell
$ forge build
```

### Deploy CrossChainSender & CrossChainReceiver Contracts to their respective Blockchain.

```shell
$  npx ts-node scripts/deploy.ts
```

- It will ask you to choose the sender and receiver blockchain. you can add more chain options in deploy-config/config.json using [wormhole-contract-addresses](https://wormhole.com/docs/build/reference/contract-addresses/) . 

- I have deployed this contracts on BSC Testnet & Avalanche Fuji. You can view them in deploy-config/contracts.json.

### Transfer Tokens

```shell
$ npx ts-node scripts/transfer.ts
```
