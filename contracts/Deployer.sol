// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;

import "./Regulator.sol";
import "./Users.sol";
import "./Drugs.sol";

contract Deployer is Regulator, Users, Drugs {
    
}