pragma solidity ^0.4.18;

contract KittyInterface {

  // Taken from: https://etherscan.io/address/0x06012c8cf97bead5deae237070f9587f8e7a266d#code
  // ETH Fiddle: https://ethfiddle.com/09YbyJRfiI
  function getKitty(uint256 _id) external view returns (
      bool isGestating,
      bool isReady,
      uint256 cooldownIndex,
      uint256 nextActionAt,
      uint256 siringWithId,
      uint256 birthTime,
      uint256 matronId,
      uint256 sireId,
      uint256 generation,
      uint256 genes
  );
}