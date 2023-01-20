// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
contract Companies {
    struct Company {
        string title; 
        bool active;  
        address account; 
    }
    string title;
    bool active;
    address account;

    Company[] CompaniesArray;

    constructor(){
        
    }

    function setTitle(string memory _title) public{
        title = _title;
    }

    function getTitle() public view returns (string memory){
        return title;
    }

    function getAddress() public view returns (address){
        return account;
    }

    function AddCompany() public {

        CompaniesArray.push(Company({title:title, active:true, account:msg.sender}));
    }

    function getCompany(uint _index) public view returns (string memory _title, bool _active, address _account) {
        Company storage company = CompaniesArray[_index];
        return (company.title, company.active, company.account);
    }

}