// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;
contract Patchs {
  struct Patch{
    uint PatchNo;
    uint DrugID;
    uint FullAmount;
    uint ReleaseDate;
  }
  mapping (uint => Patch) public patchs;
//   event savingsEvent(uint indexed _memberId);
  uint public patchsCount;

  constructor()  {
    patchsCount = 0;
  }
  function addPatch(uint _drugid, uint _fullamount, uint _releasedate) public {
    patchs[patchsCount] = Patch(patchsCount,_drugid, _fullamount, _releasedate);
    patchsCount++;
  }
  //return Single structure
  function get(uint _patchid) public view returns(Patch memory) {
    return patchs[_patchid];
  }
  //return Array of structure Value
  function getPatch() public view returns (uint[] memory, uint[] memory, uint[] memory, uint[] memory){
      uint[]  memory patchno = new uint[](patchsCount);
      uint[]  memory drugid = new uint[](patchsCount);
      uint[]  memory fullamount = new uint[](patchsCount);
      uint[]  memory releasedate = new uint[](patchsCount);
      
      for (uint i = 0; i < patchsCount; i++) {
          Patch storage patch = patchs[i];
          patchno[i] = patch.PatchNo;
          drugid[i] = patch.DrugID;
          fullamount[i] = patch.FullAmount;
          releasedate[i] = patch.ReleaseDate;

      }

      return (patchno, drugid, fullamount, releasedate);

  }
  //return Array of structure
  function getPatchs() public view returns (Patch[] memory){
      Patch[]    memory id = new Patch[](patchsCount);
      for (uint i = 0; i < patchsCount; i++) {
          Patch storage patch = patchs[i];
          id[i] = patch;
      }
      return id;
  }
}