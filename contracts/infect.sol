pragma solidity ^0.4.18;

import "./zombie.sol";
import "./kitty-interface.sol";

contract Infect is Zombie {
  address KITTY_CONTRACT_ADDRESS = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;

  KittyInterface kittyContract = KittyInterface(KITTY_CONTRACT_ADDRESS);

  function feedAndMultiply(uint _zombieId, uint _targetDna, string _species) public {
    require(zombieToOwner[_zombieId] == msg.sender);

    Undead storage activeZombie = zombies[_zombieId];
    _targetDna = _targetDna % DNA_MODULUS;
    uint newDna = (activeZombie.dna + _targetDna) / 2;

    if (keccak256(_species) == keccak256("kitty")) {
      newDna = newDna - newDna % 100 + 99;
    }

    _createZombie("Zombie", newDna);
  }

  function feedOnKitty(uint _zombieId, uint _kittyId) public {
    uint kittyDna;

    (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);

    feedAndMultiply(_zombieId, kittyDna, "kitty");
  }
}