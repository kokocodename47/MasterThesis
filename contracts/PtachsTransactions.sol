// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;
import "./Utils.sol";
contract PatchsTransactions is Utils{
    // struct PatchKey{
    //     string DrugRegNo;
    //     string PatchNo;
    // }
    struct PatchTransaction{
        string DrugRegNo;
        string PatchNo;
        uint LineNo;
        string FromID;
        string ToID;
        uint Amount;
    }
    PatchTransaction[] public PatchTrannsactions;

    // mapping(string => mapping(string => PatchTransaction[])) PatchTransactions;
    // PatchKey[] PatchKeys;

    function GetUserByAddress(address _partneraddress)
        public
        view
        returns (User memory filteredUsers)
    {
        uint256 usersCount = UsersIDs.length;
        User memory usersTemp ;
        uint256 count;
        for (uint256 i = 0; i < usersCount; i++) {
            if (UserIDsMapping[UsersIDs[i]].UserAddress == _partneraddress) {
                usersTemp = UserIDsMapping[UsersIDs[i]];
                count += 1;
            }
        }
        return usersTemp;
    }
    function GetUserIDByAddress(address _partneraddress)
        public
        view
        returns (string memory)
    {
        uint256 usersCount = UsersIDs.length;
        string memory userID ;
        for (uint256 i = 0; i < usersCount; i++) {
            if (UserIDsMapping[UsersIDs[i]].UserAddress == _partneraddress) {
                userID = UsersIDs[i];
            }
        }
        return userID;
    }


    function CreatePatch (string memory _drugregno,string memory _patchno, uint _amount) public returns(bool){
        PatchTransaction memory newtx = PatchTransaction(_drugregno, _patchno, 0, "", GetUserIDByAddress(msg.sender), _amount);
        PatchTrannsactions.push(newtx);
        return true;
    }

}