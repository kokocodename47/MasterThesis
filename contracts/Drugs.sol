// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;
contract Drugs {
    struct Drug{
        uint DrugID;
        string RegNo;
        address Manufacturer;
        bool IsActive;
    }
    address owner;
    modifier onlyOwner(){
        require(owner == msg.sender);
        _;
    }
    mapping (uint => Drug) public drugs;
    mapping (string => Drug) public newdrugs;
//   event savingsEvent(uint indexed _memberId);
    uint public drugsCount;
    constructor()  {
        drugsCount = 0;
        owner = msg.sender;
    }

//     Drug[] private Drugs;

// function getDrugStruct() public view returns(Drug[] memory) {
//   return Drug;
// }


    function addDrug(string memory _regno) public{
        drugs[drugsCount] = Drug(drugsCount, _regno,msg.sender , true);
        drugsCount++;
    }
    //return Single structure
    function get(uint _drugid) public view returns(Drug memory) {
        return drugs[_drugid];
    }
    //return Array of structure Value
    function getDrug() public view returns (uint[] memory, string[] memory, address[] memory, bool[] memory){
        uint[] memory drugid = new uint[](drugsCount);
        string[]  memory regno = new string[](drugsCount);
        address[]  memory manufacturer = new address[](drugsCount);   
        bool[] memory isactive = new bool[](drugsCount);    
        for (uint i = 0; i < drugsCount; i++) {
            Drug storage drug = drugs[i];

            regno[i] = drug.RegNo;
            manufacturer[i] = drug.Manufacturer;
            isactive[i] = drug.IsActive;
        }
        return (drugid, regno, manufacturer, isactive);
    }
    //return Array of structure
    function getDrugs() public view returns (Drug[] memory){
        Drug[]    memory id = new Drug[](drugsCount);
        for (uint i = 0; i < drugsCount; i++) {
            Drug storage drug = drugs[i];
            id[i] = drug;
        }
        return id;
    }
    function changeDrugStatus(uint _drugid, bool _status) public onlyOwner{
        drugs[_drugid].IsActive = _status;
    }

}