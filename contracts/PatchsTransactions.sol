// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;
import "./Utils.sol";

contract PatchsTransactions is Utils {

    function CreatePatch(
        string memory _drugregno,
        string memory _patchno,
        uint256 _amount,
        uint256 _txdate
    ) public returns (bool) {
        require(ReadDrug(_drugregno).Manufacturer == msg.sender);
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
        uint256 _txdate,
        address _fromaddress
    ) public returns (bool) {
        require(ReturnRemainingAmount(_patchno,_drugregno, _fromaddress) >= _amount);
        PatchTransaction memory newtx = PatchTransaction(
            _drugregno,
            _patchno,
            ReadTransactionsByPatchNo(_drugregno, _patchno).length + 1,
            msg.sender,
            _toaddress,
            _amount,
            _txdate
        );
        PatchTrannsactions.push(newtx);
        return true;
    }
}
