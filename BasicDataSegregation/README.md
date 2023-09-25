# Basic Data Segregatioon Grain Supply chain Data and Logic Contracts Documentation

## Introduction:

The Basic Data Segregatioon Grain Supply chain Data and Logic Contracts are copies of the original Grain Supply Chain Contract created by Lorikeet but developed using Basic Data Segregation pattern. It is designed based on the provided BPMN and upon deployment, orchestrates the complete supply chain process.

## Deployment Steps:

### 1. Prerequisites:

-   Ensure you have executed `npm install` in the root of your project directory.
-   Verify that Hardhat is set up and configured correctly.
-   Update the Data.sol and Logic.sol file by adding the appropriate Registry contract address.

### 2. Network Configuration:

If you intend to deploy on a network other than the default, ensure you've set the configuration in the `hardhat.config.js`.

### 3. Deployment of Data Contract Instructions:

#### - Local Deployment:

```shell
npx hardhat run scripts/deployData.js

```

#### - Deployment on a Specific Network:

```shell
npx hardhat --network "YOUR_NETWORK_NAME" run scripts/deployData.js
```

Replace YOUR_NETWORK_NAME with your intended network (e.g., "seplioa").

### 4. Dave Data Contract Address:

-   Save the address displayed on terminal after deployment.
-   Add the Saved address in the Logic.sol file.

### 5. Deployment of Logic Contract Instructions:

#### - Local Deployment:

```shell
npx hardhat run scripts/deployLogic.js

```

#### - Deployment on a Specific Network:

```shell
npx hardhat --network "YOUR_NETWORK_NAME" run scripts/deployLogic.js
```

Replace YOUR_NETWORK_NAME with your intended network (e.g., "seplioa").
