// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;
import "./Utils.sol";
contract Users is Utils {
    
    function CreateUser(
        string memory _id,
        string memory _username,
        UserRoles _userrole,
        string memory _lat,
        string memory _long
    ) public returns (bool) {
        require (_userrole != UserRoles.Regulator);
        Statuses _activeUser;
        if(_userrole == UserRoles.Physician || _userrole == UserRoles.Patient){
            _activeUser = Statuses.Active;
        }
        else{
            _activeUser = Statuses.New;
        }
        UserAddressMapping[msg.sender] = User(
            _id,
            _username,
            UserRoles(_userrole),
            _activeUser,
            _lat,
            _long,
            msg.sender
        );
        UsersAddresses.push(msg.sender);
        return true;
    }

    event UserCreationEvent(
        address indexed _useraddress
    );
}