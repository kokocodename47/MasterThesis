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
    function SetUserStatus(address _address, Statuses _status)
        public
        onlyOwner 
        returns (bool)
    {
        UserAddressMapping[_address].UserStatus = _status;
        return true;
    }
 
        
    //Drugs
    function SetDrugStatus(string memory _regno, Statuses _status)
        public
        onlyOwner 
        returns (bool)
    {
        DrugRegNoMapping[_regno].DrugStatus = _status;
        return true;
    }
}
