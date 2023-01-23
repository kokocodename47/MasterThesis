// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;
import "./Utils.sol";

contract PatchsTransactions is Utils {
    struct PatchTransaction {
        string DrugRegNo;
        string PatchNo;
        uint256 LineNo;
        address FromID;
        address ToID;
        uint256 Amount;
    }
    PatchTransaction[] public PatchTrannsactions;

    function CreatePatch(
        string memory _drugregno,
        string memory _patchno,
        uint256 _amount
    ) public returns (bool) {
        // require(ReadDrug(_drugregno).Manufacturer == msg.sender);
        PatchTransaction memory newtx = PatchTransaction(
            _drugregno,
            _patchno,
            0,
            msg.sender,
            msg.sender,
            _amount
        );
        PatchTrannsactions.push(newtx);
        return true;
    }

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

    function CreateTransaction(
        string memory _drugregno,
        string memory _patchno,
        uint256 _amount,
        address _toaddress
    ) public returns (bool) {
        PatchTransaction memory newtx = PatchTransaction(
            _drugregno,
            _patchno,
            0,
            msg.sender,
            _toaddress,
            _amount
        );
        PatchTrannsactions.push(newtx);
        return true;
    }
}
