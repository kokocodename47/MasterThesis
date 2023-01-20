// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;

contract Regulator {
    enum UserRoles {
        Mnufacturer,
        Transporter,
        Wholesaler,
        Hospital,
        Pharmacy,
        Physician,
        Patient
    }
    struct User {       
        string UserName;
        UserRoles UserRole;
        bool IsActive;
        uint256 Latitude;
        uint256 Longitude;
    }
    uint256 usersCount;
    mapping(address => User) UserAddressMapping;
    address[] UsersAddresses;
    function CreateUser(
        string memory _username,
        UserRoles _userrole,
        uint256 _lat,
        uint256 _long,
        address _address
    ) public returns (bool) {
        UserAddressMapping[_address] = User(
            
            _username,
            UserRoles(_userrole),
            true,
            _lat,
            _long
        );
        usersCount += 1;
        UsersAddresses.push(_address);
        return true;
    }

    function ReadUser(address _address) public view returns (User memory) {
        return UserAddressMapping[_address];
    }

    function SetUserStatus(address _address, bool _status)
        public
        returns (bool)
    {
        UserAddressMapping[_address].IsActive = _status;
        return true;
    }

    struct UsersAddress {
        uint UserIndex;
        address UserAddress;
        string UserName;
    }

    function GetUsersByType(UserRoles _role)
        public
        view
        returns (User[] memory filteredUsers)
    {
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
