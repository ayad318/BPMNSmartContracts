# GrainTitle Registry Contract Documentation

## Introduction:

The GrainTitle Registry Contract is a digital asset registry. After deployment, save the contract address as it will be crucial for referencing by other contracts.

## Deployment Steps:

1. <strong>Prerequisites</strong>:

Ensure you've run npm install in your project directory.
Ensure Hardhat is configured correctly.

2. <strong>Network Configuration</strong>:

For deploying on networks other than default, configure the network in hardhat.config.js.

3. <strong>Deployment</strong>:
   <strong>Local</strong>:

```shell
npx hardhat run scripts/deploy.js
```

<strong>Specific Network</strong>:

```shell
npx hardhat --network "YOUR_NETWORK_NAME" run scripts/deploy.js
```

(Replace YOUR_NETWORK_NAME with the desired network, e.g., "seplioa")

4. <strong>Contract Address</strong>:

Post-deployment, the address will display on the terminal. Save this address for future interactions.
