// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;
import "./Users.sol";
contract Regulator is Users {
    
    address public Owner;
    
    constructor() {
        Owner = msg.sender;
    }
    
    modifier onlyOwner() {
        require(Owner == msg.sender);
        _;
    }

    function ReadUser(address _address) public view returns (User memory) {
        return UserAddressMapping[_address];
    }

    function SetUserStatus(address _address, bool _status)
        public
        onlyOwner 
        returns (bool)
    {
        UserAddressMapping[_address].IsActive = _status;
        return true;
    }
 
    function GetUsersByType(UserRoles _role)
        public
        view
        returns (User[] memory filteredUsers)
    {
        uint256 usersCount = UsersAddresses.length;
        User[] memory usersTemp = new User[](usersCount);
        uint256 count;
        for (uint256 i = 0; i < usersCount; i++) {
            if (UserAddressMapping[UsersAddresses[i]].UserRole == _role) {
                usersTemp[count] = UserAddressMapping[UsersAddresses[i]];
                count += 1;
            }
        }

        filteredUsers = new User[](count);
        for (uint256 i = 0; i < count; i++) {
            filteredUsers[i] = usersTemp[i];
        }
    }
}
