// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
contract User_Types{
    struct UserType{
        uint id;
        string UserTypeName;
    }

    mapping (uint => UserType) public oUserTypes;

    string UserTypeName;
    uint iUserId;
    uint public iTypesCount;

    UserType[] aUserTypes;

    constructor()  {
    iUserId = 0;
    iTypesCount=0;
  }

    function setUserTypeName(string memory _UserTypeName) public{
        UserTypeName = _UserTypeName;
    }

    function getUserTypeName() public view returns (string memory){
        return UserTypeName;
    }

    function AddUserType() public {
        iUserId ++;
        oUserTypes[iUserId] = UserType(iUserId, UserTypeName);
        iTypesCount ++;
        // aUserTypes.push(UserType({id:id, UserTypeName:UserTypeName}));
    }

    function getUserType(uint _id) public view returns (UserType memory) {       
        return (oUserTypes[_id]);
    }

    function getTypes() public view returns (UserType[] memory){
      UserType[] memory id = new UserType[](iTypesCount);
      for (uint i = 1; i < iTypesCount; i++) {
          UserType storage oUserType = oUserTypes[i];
          id[i] = oUserType;
      }
      return id;
  }
}