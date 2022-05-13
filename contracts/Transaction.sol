// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
contract Transactions{
    struct Transaction{
        uint TransactionID;
        uint DrugID;
        uint PatchNo;
        uint CurrentOwner;
        uint FromOwner;
        uint FullAmount;
        uint RemainAmount;
        uint TransactionDate;
    }

    mapping (uint => Transaction) public transactions;
//   event savingsEvent(uint indexed _memberId);
    uint public transactionsCount;
    constructor()  {
        transactionsCount = 0;
    }

    function addTransaction(uint _drugid, uint _patchno, uint _currentowner, uint _fromowner, uint _fullamount, uint _remainamount, uint _transdate) public {
        transactions[transactionsCount] = Transaction(transactionsCount,_drugid, _patchno, _currentowner, _fromowner, _fullamount, _remainamount, _transdate);
        transactionsCount++;
    }

    function get(uint _transid) public view returns(Transaction memory) {
        return transactions[_transid];
    }

    //return Array of structure Value
  function getTransaction() public view returns (uint[] memory, uint[] memory, uint[] memory, uint[] memory, uint[] memory, uint[] memory, uint[] memory){
      uint[]  memory transid = new uint[](transactionsCount);
      uint[]  memory drugid = new uint[](transactionsCount);
      uint[]  memory patchno = new uint[](transactionsCount);
      uint[]  memory currentowner = new uint[](transactionsCount);
      uint[]  memory fromowner = new uint[](transactionsCount);
      uint[]  memory fullamount = new uint[](transactionsCount);
      uint[]  memory remainamount = new uint[](transactionsCount);
      uint[]  memory transdate = new uint[](transactionsCount);
      
      for (uint i = 0; i < transactionsCount; i++) {
          Transaction storage transaction = transactions[i];
          transid[i] = transaction.TransactionID;
          drugid[i] = transaction.DrugID;
          patchno[i] = transaction.PatchNo;
          currentowner[i] = transaction.CurrentOwner;
          fromowner[i] = transaction.FromOwner;
          fullamount[i] = transaction.FullAmount;
          remainamount[i] = transaction.RemainAmount;
          transdate[i] = transaction.TransactionDate;
      }

      return (transid, drugid, patchno, currentowner, fromowner,fullamount, transdate);

  }
    //return Array of structure
  function getTransactions() public view returns (Transaction[] memory){
      Transaction[]    memory id = new Transaction[](transactionsCount);
      for (uint i = 0; i < transactionsCount; i++) {
          Transaction storage transaction = transactions[i];
          id[i] = transaction;
      }
      return id;
  }

}