pragma solidity ^0.4.18;

contract Zombie {
  event NewZombie(uint id, string name, uint dna);

  uint DNA_DIGITS = 16;
  uint DNA_MODULUS = 10 ** DNA_DIGITS;

  struct Undead {
    string name;
    uint dna;
  }

  mapping (uint => address) zombieToOwner;
  mapping (address => uint) ownerZombieCount;

  Undead[] public zombies;

  function _createZombie(string _name, uint _dna) internal {
    Undead memory zombie = Undead(_name, _dna);
    uint zombieCount = zombies.push(zombie);
    uint id = zombieCount - 1;

    zombieToOwner[id] = msg.sender;
    ownerZombieCount[msg.sender]++;

    NewZombie(id, _name, _dna);
  }

  function _generateRandomDna(string _str) private view returns (uint) {
    uint rand = uint(keccak256(_str));
    uint dna = rand % DNA_MODULUS;

    return dna;
  }

  function create(string _name) public {
    // Only allowed to have 1 Zombie
    require(ownerZombieCount[msg.sender] == 0);

    uint dna = _generateRandomDna(_name);

    _createZombie(_name, dna);
  }
}
