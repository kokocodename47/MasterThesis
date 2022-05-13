// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;
contract UsersTypes {
  struct Type{
    uint id;
    string name;
  }
  mapping (uint => Type) public types;
//   event savingsEvent(uint indexed _memberId);
  uint public typeCount;

  constructor()  {
    typeCount = 0;
  }
  function addType(string memory _name) public {
    types[typeCount] = Type(typeCount,_name);
    typeCount++;
  }
  //return Single structure
  function get(uint _typeId) public view returns(Type memory) {
    return types[_typeId];
  }
  //return Array of structure Value
  function getType() public view returns (uint[] memory, string[] memory){
      uint[]    memory id = new uint[](typeCount);
      string[]  memory name = new string[](typeCount);
      
      for (uint i = 0; i < typeCount; i++) {
          Type storage userType = types[i];
          id[i] = userType.id;
          name[i] = userType.name;
      }

      return (id, name);

  }
  //return Array of structure
  function getTypes() public view returns (Type[] memory){
      Type[]    memory id = new Type[](typeCount);
      for (uint i = 0; i < typeCount; i++) {
          Type storage userType = types[i];
          id[i] = userType;
      }
      return id;
  }
}