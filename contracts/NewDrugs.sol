// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;
contract Drugs{
    struct drug{
        string regNo;
        address manufacturer;
        bool isActive;
    }
    address owner;
    modifier onlyOwner(){
        require(owner == msg.sender);
        _;
    }



    struct country{
      string name;
      string leader;
      uint256 population;
   }
  
   drug[] public drugs; 

   uint256 public totalDrugs;
  
  
    constructor() {
       totalDrugs = 0;
   }

   event CountryEvent(string regNo , string leader, uint256 population);
   
   event LeaderUpdated(string regNo , string leader);

   event CountryDelete(string regNo);

    
   function insert( string memory regNo , address manufacturer ) public returns (uint256 _totalDrugs){
        drug memory newDrug = drug(regNo , manufacturer, true);
        drugs.push(newDrug);
        totalDrugs++;
        //emit event
        //emit CountryEvent (regNo, leader, population);
        return totalDrugs;
   }
   
   function updateDrugStatus(string memory regNo, bool isActive) public returns (bool success){
       //This has a problem we need loop
       for(uint256 i =0; i< totalDrugs; i++){
           if(compareStrings(drugs[i].regNo ,regNo)){
              drugs[i].isActive = isActive;
              //emit LeaderUpdated(regNo, newLeader);
              return true;
           }
       }
       return false;
   }
   
   function deleteDrug(string memory regNo) public returns(bool success){
        require(totalDrugs > 0);
        for(uint256 i =0; i< totalDrugs; i++){
           if(compareStrings(drugs[i].regNo , regNo)){
              drugs[i] = drugs[totalDrugs-1]; // pushing last into current arrray index which we gonna delete
              delete drugs[totalDrugs-1]; // now deleteing last index
              totalDrugs--; //total count decrease
            //   countries.length--; // array length decrease
              //emit event
              //emit CountryDelete(regNo);
              return true;
           }
       }
       return false;
   }
   
     
   function getDrug(string memory regNo) public view returns(string memory _regNo , address manufacturer , bool isActive){
        for(uint256 i =0; i< totalDrugs; i++){
           if(compareStrings(drugs[i].regNo, regNo)){
              //emit event
              return (drugs[i].regNo , drugs[i].manufacturer , drugs[i].isActive);
           }
       }
       revert('drug not found');
   }     
   
  function compareStrings (string memory a, string memory b)  internal pure returns (bool){
       return keccak256(abi.encodePacked(a)) == keccak256(abi.encodePacked(b));
   }
   
   
   function gettotalDrugs() public view returns (uint256 length){
      return drugs.length;
   }

   function getDrugss() public view returns (drug[] memory allDrugs){
      // return country;
      drug[] memory drugsArr = new drug[](totalDrugs);
        for (uint i = 0; i < totalDrugs; i++) {
            // country storage stored_country = country[i];
            // if(compareStrings(countries[i].name , "Karim")){
            //    CountriesArr.push(countries[i]);
            // }
            drugsArr[i] = drugs[i];
        }
        return drugsArr;
      //   return countries;
   }

     function getDrugs2() public view returns (drug[] memory allDrugs){
      // return country;
         return drugs;
   }

}
