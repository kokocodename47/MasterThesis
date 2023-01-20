// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;

import "./Utils.sol";
contract Regulator is Utils {
    
    address public Owner;
    
    constructor() {
        Owner = msg.sender;
    }
    
    modifier onlyOwner() {
        require(Owner == msg.sender);
        _;
    }
    //Users 
    function ReadUser(string memory _id) public view returns (User memory) {
        return UserIDsMapping[_id];
    }

    function SetUserStatus(string memory _id, Statuses _status)
        public
        onlyOwner 
        returns (bool)
    {
        UserIDsMapping[_id].UserStatus = _status;
        return true;
    }
 
    function GetUsersByType(UserRoles _role)
        public
        view
        returns (User[] memory filteredUsers)
    {
        uint256 usersCount = UsersIDs.length;
        User[] memory usersTemp = new User[](usersCount);
        uint256 count;
        for (uint256 i = 0; i < usersCount; i++) {
            if (UserIDsMapping[UsersIDs[i]].UserRole == _role) {
                usersTemp[count] = UserIDsMapping[UsersIDs[i]];
                count += 1;
            }
        }

        filteredUsers = new User[](count);
        for (uint256 i = 0; i < count; i++) {
            filteredUsers[i] = usersTemp[i];
        }
    }
    

    function SetDrugStatus(string memory _regno, Statuses _status)
        public
        onlyOwner 
        returns (bool)
    {
        DrugRegNoMapping[_regno].DrugStatus = _status;
        return true;
    }
}
