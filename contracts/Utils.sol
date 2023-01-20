// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;

contract Utils{
    //Shared
    enum Statuses{
        New,
        Active,
        Suspended
    }
    //Users
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
        Statuses UserStatus;
        uint256 Latitude;
        uint256 Longitude;
        address UserAddress;
    }
    mapping(string => User) UserIDsMapping;
    string[] UsersIDs;
    //Drugs
    struct Drug {
        string DrugName;
        address Manufacturer;
        Statuses DrugStatus;
    }
    enum DrugTypes {
        HumanPharmaceutical,
        Biological,
        HerbalMedicine,
        Veterinary,
        Biocides,
        Cosmetics,
        DietarySupplement
    }
    mapping(string => Drug) DrugRegNoMapping;
    string[] DrugsRegNos;

    //Drugs
    function ReadDrug(string memory _regno) public view returns (Drug memory) {
        return DrugRegNoMapping[_regno];
    }
}