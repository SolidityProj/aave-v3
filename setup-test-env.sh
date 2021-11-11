#!/bin/bash

# @dev
# This bash script setups the needed artifacts to use
# the @aave/deploy-v3 package as source of deployment
# scripts for testing or coverage purposes.
#
# A separate  artifacts directory was created 
# due at running tests all external artifacts
# located at /artifacts are deleted,  causing
# the deploy library to not find the external
# artifact dependencies. 

echo "[BASH] Setting up testnet enviroment"

if [ "$COVERAGE" == false ]; then
    # remove hardhat and artifacts cache
    npm run ci:clean

    # compile @aave/core-v3 contracts
    npm run compile
fi

# Copy artifacts into separate directory to allow
# the hardhat-deploy library load all artifacts without duplicates 
mkdir -p temp-artifacts
cp -r artifacts/* temp-artifacts

# Import external @aave/periphery artifacts
mkdir -p temp-artifacts/periphery
cp -r node_modules/@aave/periphery-v3/artifacts/contracts/* temp-artifacts/periphery

# Import external @aave/deploy artifacts
mkdir -p temp-artifacts/deploy
cp -r node_modules/@aave/deploy-v3/artifacts/contracts/* temp-artifacts/deploy

echo "[BASH] Testnet enviroment ready"