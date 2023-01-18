// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;

contract study{
    
    mapping(address => string[]) DrugsManufaturrerMapping;

    function AddDrugToManufacturer (address _Manufaturer , string memory _DrugID) public {
        DrugsManufaturrerMapping[_Manufaturer].push(_DrugID);
    }

    function ReadDrugsManufacturers (address _Manufaturer)  public view returns (string[] memory){
        return DrugsManufaturrerMapping[_Manufaturer];
    }

    function DeleteDrugToManufacturer (address _Manufaturer , uint _DrugIDX) public {
        delete DrugsManufaturrerMapping[_Manufaturer][_DrugIDX];
    }
    
}