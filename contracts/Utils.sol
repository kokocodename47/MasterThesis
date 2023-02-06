// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;
import "./Definitions.sol";
contract Utils is Definitions {
    

    function compareStringsbyBytes(string memory s1, string memory s2)
        public
        pure
        returns (bool)
    {
        return
            keccak256(abi.encodePacked(s1)) == keccak256(abi.encodePacked(s2));
    }

    
    //Users
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

    function GetUsersByStatus(Statuses _status)
        public
        view
        returns (User[] memory filteredUsers)
    {
        uint256 usersCount = UsersAddresses.length;
        User[] memory usersTemp = new User[](usersCount);
        uint256 count;
        for (uint256 i = 0; i < usersCount; i++) {
            if (UserAddressMapping[UsersAddresses[i]].UserStatus == _status) {
                usersTemp[count] = UserAddressMapping[UsersAddresses[i]];
                count += 1;
            }
        }

        filteredUsers = new User[](count);
        for (uint256 i = 0; i < count; i++) {
            filteredUsers[i] = usersTemp[i];
        }
    }

    function ReadRoleByUser() public view returns (UserRoles _userrole) {
        if (msg.sender == Owner) {
            _userrole = UserRoles.Regulator;
        } else if (UserAddressMapping[msg.sender].UserAddress == address(0)) {
            _userrole = UserRoles.Unregistered;
        } else {
            _userrole = UserAddressMapping[msg.sender].UserRole;
        }
    }

    //Drugs
    
    function ReadDrug(string memory _regno) public view returns (Drug memory) {
        return DrugRegNoMapping[_regno];
    }

    function ReadDrugsByUser(address _useraddress)
        public
        view
        returns (Drug[] memory DrugsList)
    {
        uint256 drugsCount = DrugsRegNos.length;
        Drug[] memory drugsTemp = new Drug[](drugsCount);
        uint256 count;
        for (uint256 i = 0; i < drugsCount; i++) {
            if (DrugRegNoMapping[DrugsRegNos[i]].Manufacturer == _useraddress) {
                drugsTemp[count] = DrugRegNoMapping[DrugsRegNos[i]];
                count += 1;
            }
        }

        DrugsList = new Drug[](count);
        for (uint256 i = 0; i < count; i++) {
            DrugsList[i] = drugsTemp[i];
        }
    }

    function ReadDrugsWithManufacturer(Statuses _drugstatus) public view returns (DrugMan[] memory DrugsList) {
        uint256 drugsCount = DrugsRegNos.length;
        Drug[] memory drugsTemp = new Drug[](drugsCount);
        uint256 count;
        for (uint256 i = 0; i < drugsCount; i++) {
            if (DrugRegNoMapping[DrugsRegNos[i]].DrugStatus == _drugstatus) {
                drugsTemp[count] = DrugRegNoMapping[DrugsRegNos[i]];
                count += 1;
            }
        }

        DrugsList = new DrugMan[](count);
        for (uint256 i = 0; i < count; i++) {
            DrugsList[i].DrugName = drugsTemp[i].DrugName;
            DrugsList[i].Manufacturer = drugsTemp[i].Manufacturer;
            DrugsList[i].DrugStatus = drugsTemp[i].DrugStatus;
            DrugsList[i].DrugRegNo = drugsTemp[i].DrugRegNo;
            DrugsList[i].ManName = UserAddressMapping[drugsTemp[i].Manufacturer].UserName;
        }
    }

    //Transactions

    

    function ReadTransactionsByUser(address _useraddress)
        public
        view
        returns (PatchTransaction[] memory UserTransaction)
    {
        uint256 MatchedRows;
        PatchTransaction[] memory TempTran = new PatchTransaction[](
            PatchTrannsactions.length
        );
        for (uint256 i = 0; i < PatchTrannsactions.length; i++) {
            // TempTran = PatchTrannsactions[i];
            if (PatchTrannsactions[i].ToID == _useraddress) {
                TempTran[MatchedRows] = PatchTrannsactions[i];
                MatchedRows++;
            }
        }
        UserTransaction = new PatchTransaction[](MatchedRows);
        if (MatchedRows > 0) {
            for (uint256 i = 0; i < MatchedRows; i++) {
                UserTransaction[i] = TempTran[i];
            }
        }
    }

    function ReadTransactionsByDrug(string memory _drugno)
        public
        view
        returns (PatchTransaction[] memory UserTransaction)
    {
        uint256 MatchedRows;
        PatchTransaction[] memory TempTran = new PatchTransaction[](
            PatchTrannsactions.length
        );
        for (uint256 i = 0; i < PatchTrannsactions.length; i++) {
            // TempTran = PatchTrannsactions[i];
            if (
                compareStringsbyBytes(PatchTrannsactions[i].DrugRegNo, _drugno)
            ) {
                TempTran[MatchedRows] = PatchTrannsactions[i];
                MatchedRows++;
            }
        }
        UserTransaction = new PatchTransaction[](MatchedRows);
        if (MatchedRows > 0) {
            for (uint256 i = 0; i < MatchedRows; i++) {
                UserTransaction[i] = TempTran[i];
            }
        }
    }

    function ReadTransactionsByPatchNo(
        string memory _patchno,
        string memory _drugno
    ) public view returns (PatchTransaction[] memory UserTransaction) {
        uint256 MatchedRows;
        PatchTransaction[] memory TempTran = new PatchTransaction[](
            PatchTrannsactions.length
        );
        for (uint256 i = 0; i < PatchTrannsactions.length; i++) {
            // TempTran = PatchTrannsactions[i];
            if (
                compareStringsbyBytes(
                    PatchTrannsactions[i].PatchNo,
                    _patchno
                ) &&
                compareStringsbyBytes(PatchTrannsactions[i].DrugRegNo, _drugno)
            ) {
                TempTran[MatchedRows] = PatchTrannsactions[i];
                MatchedRows++;
            }
        }
        UserTransaction = new PatchTransaction[](MatchedRows);
        if (MatchedRows > 0) {
            for (uint256 i = 0; i < MatchedRows; i++) {
                UserTransaction[i] = TempTran[i];
            }
        }
    }

    function ReadParentAndSiblingsTransactions(
        string memory _patchno,
        string memory _drugno,
        address _fromaddress
    ) public view returns (PatchTransaction[] memory UserTransaction) {
        uint256 MatchedRows;
        PatchTransaction[] memory TempTran = new PatchTransaction[](
            PatchTrannsactions.length
        );
        for (uint256 i = 0; i < PatchTrannsactions.length; i++) {
            // TempTran = PatchTrannsactions[i];
            if (
                compareStringsbyBytes(
                    PatchTrannsactions[i].PatchNo,
                    _patchno
                ) &&
                compareStringsbyBytes(
                    PatchTrannsactions[i].DrugRegNo,
                    _drugno
                ) &&
                (PatchTrannsactions[i].ToID == _fromaddress ||
                    PatchTrannsactions[i].FromID == _fromaddress)
            ) {
                TempTran[MatchedRows] = PatchTrannsactions[i];
                MatchedRows++;
            }
        }
        UserTransaction = new PatchTransaction[](MatchedRows);
        if (MatchedRows > 0) {
            for (uint256 i = 0; i < MatchedRows; i++) {
                UserTransaction[i] = TempTran[i];
            }
        }
    }

    function ReturnRemainingAmount(
        string memory _patchno,
        string memory _drugno,
        address _fromaddress
    ) public view returns (uint256 _remainamount) {
        PatchTransaction[]
            memory UserTransaction = ReadParentAndSiblingsTransactions(
                _patchno,
                _drugno,
                _fromaddress
            );
        uint256 mainAmount;
        uint256 toAmount;
        for (uint256 i = 0; i < UserTransaction.length; i++) {
            if (UserTransaction[i].ToID == _fromaddress) {
                mainAmount = UserTransaction[i].Amount;
            } else {
                toAmount += UserTransaction[i].Amount;
            }
        }
        _remainamount = mainAmount - toAmount;
    }
}
