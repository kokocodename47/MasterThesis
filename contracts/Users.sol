// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;

contract Users{
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

    mapping(address => User) UserAddressMapping;
    address[] UsersAddresses;
    function CreateUser(
        string memory _username,
        UserRoles _userrole,
        uint256 _lat,
        uint256 _long
    ) public returns (bool) {
        if(){
            
        }
        UserAddressMapping[msg.sender] = User(
            _username,
            UserRoles(_userrole),
            true,
            _lat,
            _long
        );
        UsersAddresses.push(msg.sender);
        return true;
    }

}