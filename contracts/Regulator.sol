// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;

import "./Utils.sol";
contract Regulator is Utils { 
    modifier onlyOwner() {
        require(Owner == msg.sender);
        _;
    }
    //Regulator 
    function CreateRegulator(
        string memory _id,
        string memory _username,
        address _regaddress
    ) public returns (bool) {
        require(ReadUser(msg.sender).UserRole == UserRoles.Regulator);
        UserAddressMapping[msg.sender] = User(
            _id,
            _username,
            UserRoles.Regulator,
            Statuses.Active,
            "",
            "",
            _regaddress
        );
        UsersAddresses.push(_regaddress);
        return true;
    }
    //Users 
    function SetUserStatus(address _address, Statuses _status)
        public
        onlyOwner 
        returns (bool)
    {
        require(ReadUser(msg.sender).UserRole == UserRoles.Regulator);
        UserAddressMapping[_address].UserStatus = _status;
        return true;
    }
 
        
    //Drugs
    function SetDrugStatus(string memory _regno, Statuses _status)
        public
        onlyOwner 
        returns (bool)
    {
        require(ReadUser(msg.sender).UserRole == UserRoles.Regulator);
        DrugRegNoMapping[_regno].DrugStatus = _status;
        return true;
    }
}
