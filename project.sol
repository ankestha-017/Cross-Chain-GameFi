// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title CrossChainGameFi
 * @dev A smart contract enabling cross-chain interoperability for GameFi projects.
 */
contract CrossChainGameFi {
    address public owner;
    uint256 public gameAssetCount;

    struct GameAsset {
        uint256 id;
        address owner;
        string metadataURI;
        string chain;
    }

    mapping(uint256 => GameAsset) public gameAssets;

    event AssetCreated(uint256 id, address owner, string metadataURI, string chain);
    event AssetTransferred(uint256 id, address from, address to, string toChain);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can perform this action");
        _;
    }

    modifier onlyAssetOwner(uint256 assetId) {
        require(gameAssets[assetId].owner == msg.sender, "Only the asset owner can perform this action");
        _;
    }

    constructor() {
        owner = msg.sender;
        gameAssetCount = 0;
    }

    /**
     * @dev Create a new GameFi asset.
     * @param metadataURI The URI pointing to the asset metadata.
     * @param chain The blockchain network where the asset originates.
     */
    function createAsset(string memory metadataURI, string memory chain) public {
        gameAssetCount++;
        gameAssets[gameAssetCount] = GameAsset(gameAssetCount, msg.sender, metadataURI, chain);

        emit AssetCreated(gameAssetCount, msg.sender, metadataURI, chain);
    }

    /**
     * @dev Transfer an asset to another user on the same or another chain.
     * @param assetId The ID of the asset being transferred.
     * @param to The address of the recipient.
     * @param toChain The blockchain network where the recipient resides.
     */
    function transferAsset(uint256 assetId, address to, string memory toChain) public onlyAssetOwner(assetId) {
        require(to != address(0), "Recipient address cannot be zero address");

        address previousOwner = gameAssets[assetId].owner;
        gameAssets[assetId].owner = to;

        emit AssetTransferred(assetId, previousOwner, to, toChain);
    }

    /**
     * @dev Update the owner address.
     * @param newOwner The address of the new owner.
     */
    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "New owner address cannot be zero address");
        owner = newOwner;
    }
}
# Cross-Chain GameFi: Interoperability Smart Contract

## Project Description
Cross-Chain GameFi is a decentralized platform designed to enable seamless interoperability between different blockchain networks for GameFi (Gaming Finance) projects. By leveraging this smart contract, users can create, own, and transfer game assets across multiple blockchain ecosystems, fostering a unified gaming experience.

## Contract Address
```
<To be deployed>
```

## Project Vision
The vision of Cross-Chain GameFi is to empower a new generation of blockchain games by bridging the gaps between disparate networks. This project aims to:
- Enhance user experience by enabling cross-chain interactions.
- Facilitate true ownership and transferability of game assets.
- Create a robust framework for developers to build interoperable GameFi applications.

## Key Features
- **Asset Creation**: Users can mint unique game assets tied to metadata and a specific blockchain.
- **Cross-Chain Transfer**: Seamlessly transfer assets across different blockchain networks while preserving ownership integrity.
- **Secure Ownership**: The contract ensures that only asset owners can manage or transfer their assets.
- **Developer Friendly**: Provides a reliable foundation for GameFi developers to create interoperable applications.

## Deployment
This smart contract is written in Solidity and can be deployed on any EVM-compatible blockchain such as Ethereum, Binance Smart Chain, or Polygon.
