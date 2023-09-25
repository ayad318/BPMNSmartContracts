# GrainTitle Registry Contract Documentation

## Introduction:

The GrainTitle Registry Contract is a digital asset registry. After deployment, save the contract address as it will be crucial for referencing by other contracts.

## Deployment Steps:

### 1. Prerequisites:

-   Ensure you have executed `npm install` in the root of your project directory.
-   Verify that Hardhat is set up and configured correctly.

### 2. Network Configuration:

For deploying on networks other than default, configure the network in hardhat.config.js.

### 3. Deployment:

#### - Local Deployment:

```shell
npx hardhat run scripts/deploy.js
```

#### - Deployment on a Specific Network:

```shell
npx hardhat --network "YOUR_NETWORK_NAME" run scripts/deploy.js
```

(Replace YOUR_NETWORK_NAME with the desired network, e.g., "seplioa")

### 4. Contract Address:

Post-deployment, the address will display on the terminal. Save this address for future interactions.
