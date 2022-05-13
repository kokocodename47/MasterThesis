// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
contract Entity_Types{
    struct EntityType{
        uint id;
        string EntityTypeName;
    }

    mapping (uint => EntityType) public oEntityTypes;

    string EntityTypeName;
    uint iEntityId;
    uint public iTypesCount;

    EntityType[] aEntityTypes;

    function setEntityTypeName(string memory _EntityTypeName) public{
        EntityTypeName = _EntityTypeName;
    }

    function getEntityTypeName() public view returns (string memory){
        return EntityTypeName;
    }

    function AddEntityType() public {
        iEntityId ++;
        oEntityTypes[iEntityId] = EntityType(iEntityId, EntityTypeName);
        iTypesCount ++;
        // aEntityTypes.push(EntityType({id:id, EntityTypeName:EntityTypeName}));
    }

    function getEntityType(uint _id) public view returns (EntityType memory) {       
        return (oEntityTypes[_id]);
    }

    function getTypes() public view returns (EntityType[] memory){
      EntityType[] memory id = new EntityType[](iTypesCount);
      for (uint i = 0; i < iEntityId; i++) {
          EntityType storage oEntityType = oEntityTypes[i];
          id[i] = oEntityType;
      }
      return id;
  }



}