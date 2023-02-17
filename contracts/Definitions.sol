// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;

contract Definitions {
    //Shared
    enum Statuses {
        New,
        Active,
        Suspended
    }

    //Users
    address public Owner;
    enum UserRoles {
        Unregistered,
        Regulator,
        Mnufacturer,
        Transporter,
        Wholesaler,
        Hospital,
        Pharmacy,
        Physician,
        Patient
    }
    struct User {
        string UserID;
        string UserName;
        UserRoles UserRole;
        Statuses UserStatus;
        string Latitude;
        string Longitude;
        address UserAddress;
    }
    mapping(address => User) UserAddressMapping;
    address[] UsersAddresses;
    //////////////////
    //Drugs
    struct Drug {
        string DrugName;
        address Manufacturer;
        Statuses DrugStatus;
        string DrugRegNo;
    }

    struct DrugMan {
        string DrugName;
        address Manufacturer;
        Statuses DrugStatus;
        string DrugRegNo;
        string ManName;
    }
    mapping(string => Drug) DrugRegNoMapping;
    string[] DrugsRegNos;

    //Transactions
    struct PatchTransaction {
        string DrugRegNo;
        string PatchNo;
        uint256 LineNo;
        address FromID;
        address ToID;
        uint256 Amount;
        uint256 TransactionDate;
    }

    struct PatchTransactionsFullData {
        string DrugRegNo;
        string PatchNo;
        uint256 LineNo;
        address FromID;
        string FromName;
        UserRoles FromRole;
        address ToID;
        string ToName;
        UserRoles ToRole;
        uint256 Amount;
        uint256 TransactionDate;
    }
    PatchTransaction[] public PatchTrannsactions;

    struct EPRAccess{
        address PatientAddress;
        address DoctorAddress;
        bool HasAccess;
    }

    struct EPRAccessFullData{
        address PatientAddress;
        string PatientName;
        address DoctorAddress;
        string DoctorName;
        bool HasAccess;
    }
    EPRAccess[] public EPRAccessList;
}
