// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;
import "./Utils.sol";
contract Drugs is Utils{

    constructor() {
        //DrugOwner = msg.sender;
    }

    modifier onlyDrugOwner() {
        address DrugOwner;
        require(DrugOwner == msg.sender);
        _;
    }
    
    function CreateDrug(
        string memory _regno,
        string memory _drugname
    ) public returns (bool) {
        DrugRegNoMapping[_regno] = Drug(
            _drugname,
            msg.sender,
            Statuses.New,
            _regno
        );
        DrugsRegNos.push(_regno);
        return true;
    }

    function SetDrugSuspended(string memory _regno)
        public
        returns (bool)
    {
        require (DrugRegNoMapping[_regno].Manufacturer == msg.sender);
        DrugRegNoMapping[_regno].DrugStatus = Statuses.Suspended;
        return true;
    }
}
