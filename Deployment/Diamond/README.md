# Diamond Pattern Documentation

## Introduction:

The Diamond is package of different contract representing the original Grain Supply Chain Contract created by Lorikeet but developed using Diamond pattern. It is designed based on the provided BPMN and upon deployment, orchestrates the complete supply chain process.

## Deployment Steps:

### 1. Prerequisites:

-   Ensure you have executed `npm install` in the root of your project directory.
-   Verify that Hardhat is set up and configured correctly.
-   Update the ProcessVariablesFacet.sol file by adding the appropriate Registry contract address.

### 2. Network Configuration:

If you intend to deploy on a network other than the default, ensure you've set the configuration in the `hardhat.config.js`.

### 3. Deployment Instructions:

#### - Local Deployment:

```shell
npx hardhat run scripts/deploy.js

```

#### - Deployment on a Specific Network:

```shell
npx hardhat --network "YOUR_NETWORK_NAME" run scripts/deploy.js
```

Replace YOUR_NETWORK_NAME with your intended network (e.g., "seplioa").
