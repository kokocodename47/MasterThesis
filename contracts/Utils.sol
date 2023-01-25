// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;

contract Utils {
    //Shared
    enum Statuses {
        New,
        Active,
        Suspended
    }

    function compareStringsbyBytes(string memory s1, string memory s2)
        public
        pure
        returns (bool)
    {
        return
            keccak256(abi.encodePacked(s1)) == keccak256(abi.encodePacked(s2));
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

    function ReadDrug(string memory _regno) public view returns (Drug memory) {
        return DrugRegNoMapping[_regno];
    }

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
    PatchTransaction[] public PatchTrannsactions;

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
    ) public view returns (uint _remainamount){
        PatchTransaction[] memory UserTransaction = ReadParentAndSiblingsTransactions(_patchno,_drugno, _fromaddress); 
        uint mainAmount;
        uint toAmount;
        for (uint256 i = 0; i < UserTransaction.length; i++) 
        {
            if (UserTransaction[i].ToID == _fromaddress) {
                mainAmount = UserTransaction[i].Amount;
            } else {
                toAmount += UserTransaction[i].Amount;
            }
        }
        _remainamount = mainAmount - toAmount;
    }

}
