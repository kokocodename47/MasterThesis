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
        string UserID;       
        string UserName;
        UserRoles UserRole;
        Statuses UserStatus;
        uint256 Latitude;
        uint256 Longitude;
        address UserAddress;
    }
    mapping(address => User) UserAddressMapping;
    address[] UsersAddresses;
    function ReadUser(address _address) public view returns (User memory) {
        return UserAddressMapping[_address];
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