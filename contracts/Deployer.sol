// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;

import "./Regulator.sol";
import "./Users.sol";
import "./Drugs.sol";
import "./PatchsTransactions.sol";
import "./EPR.sol";

contract Deployer is Regulator, Users, Drugs, PatchsTransactions, EPR {
    constructor() {
        Owner = msg.sender;
        //RegisterDeployer();
        UserAddressMapping[msg.sender] = User(
            "0",
            "Regulator",
            UserRoles.Regulator,
            Statuses.Active,
            "",
            "",
            msg.sender
        );
        UsersAddresses.push(msg.sender);
    }
}