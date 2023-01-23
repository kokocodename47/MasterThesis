// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;
import "./Utils.sol";
    contract PatchsTransactions is Utils {

    //Transactions

    struct PatchTransaction {
        string DrugRegNo;
        string PatchNo;
        uint256 LineNo;
        address FromID;
        address ToID;
        uint256 Amount;
        uint TransactionDate; 
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

    function ReadTransactionsByPatchNo(string memory _patchno, string memory _drugno)
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
                compareStringsbyBytes(PatchTrannsactions[i].PatchNo, _patchno) && compareStringsbyBytes(PatchTrannsactions[i].DrugRegNo, _drugno)
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

    function CreatePatch(
        string memory _drugregno,
        string memory _patchno,
        uint256 _amount,
        uint _txdate
    ) public returns (bool) {
        // require(ReadDrug(_drugregno).Manufacturer == msg.sender);
        PatchTransaction memory newtx = PatchTransaction(
            _drugregno,
            _patchno,
            0,
            address(0),
            msg.sender,
            _amount,
            _txdate
        );
        PatchTrannsactions.push(newtx);
        return true;
    }

    function CreateTransaction(
        string memory _drugregno,
        string memory _patchno,
        uint256 _amount,
        address _toaddress,
        uint _txdate
    ) public returns (bool) {
        PatchTransaction memory newtx = PatchTransaction(
            _drugregno,
            _patchno,
            0,
            msg.sender,
            _toaddress,
            _amount,
            _txdate
        );
        PatchTrannsactions.push(newtx);
        return true;
    }


}
