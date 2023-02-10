// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;
import "./Utils.sol";

contract EPR is Utils {
    function GrantAccess(address _doctor) public returns (bool) {
        EPRAccess memory newaccess = EPRAccess(msg.sender, _doctor, true);
        EPRAccessList.push(newaccess);
        return true;
    }

    function AlterAccess(address _doctor, bool _access) public returns (bool) {
        for (uint256 i = 0; i < EPRAccessList.length; i++) {
            if(EPRAccessList[i].PatientAddress == msg.sender && EPRAccessList[i].DoctorAddress == _doctor){
                EPRAccessList[i].HasAccess = _access;
            }
        }
        return true;
    }
}
