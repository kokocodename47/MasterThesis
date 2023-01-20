// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;

import "./Regulator.sol";
contract study is Regulator {
    // mapping(address => string[]) DrugsManufaturrerMapping;

    // function AddDrugToManufacturer (address _Manufaturer , string memory _DrugID) public {
    //     DrugsManufaturrerMapping[_Manufaturer].push(_DrugID);
    // }

    // function ReadDrugsManufacturers (address _Manufaturer)  public view returns (string[] memory){
    //     return DrugsManufaturrerMapping[_Manufaturer];
    // }

    // function DeleteDrugToManufacturer (address _Manufaturer , uint _DrugIDX) public {
    //     delete DrugsManufaturrerMapping[_Manufaturer][_DrugIDX];
    // }

    struct Drugs {
        string DrugID;
        bool IsActive;
    }
    mapping(address => Drugs[]) DrugsManufaturrerMapping;

    function AddDrugToManufacturer(address _Manufaturer, string memory _DrugID)
        public
    {
        Drugs memory drug = Drugs(_DrugID, true);
        DrugsManufaturrerMapping[_Manufaturer].push(drug);
    }

    function ReadDrugsManufacturers(address _Manufaturer)
        public
        view
        returns (Drugs[] memory)
    {
        return DrugsManufaturrerMapping[_Manufaturer];
    }

    function DeactivateDrug(
        address _Manufaturer,
        uint256 _DrugIDX,
        bool _isActive
    ) public {
        for (
            uint256 i = 0;
            i < DrugsManufaturrerMapping[_Manufaturer].length;
            i++
        ) {
            
            if(i == _DrugIDX){
                DrugsManufaturrerMapping[_Manufaturer][i].IsActive = _isActive;
            }
            
        }
    }

    struct PatchTransaction{
        string PatchNo;
        uint TxIndex;
        string DrugID;
        address FromAddress;
        address ToAddress;
        uint Amount;
        string TxDate;
    }

    PatchTransaction[] PatchTransactions;
    string _userManufacturer = "Mnufacturer";

    modifier isManufacturer() {
        UserRoles UserRole;
        for (uint256 i = 0; i < usersCount; i++) {
            if (UserAddressMapping[i].UserAddress == msg.sender) {
                UserRole = UserAddressMapping[i].UserRole;
            }
        }
        require(UserRole == UserRoles.Mnufacturer);
        _;
    }
    function CreatePatch(string memory _patch, string memory _drugid, address _toaddress, uint _amount, string memory _txdate) public returns (string memory){
        PatchTransaction memory patchTX = PatchTransaction(_patch, 1, _drugid, msg.sender, _toaddress, _amount, _txdate);
        // PatchTransactions.push({PatchNo : _patch, TxIndex : 1, DrugID : _drugid, FromAddress : msg.sender, ToAddress: _toaddress, Amount: _amount, TxDate: _txdate });
        PatchTransactions.push(patchTX);
        return("Patch created");
    }

}
