// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
contract Transactions{
    struct Transaction{
        uint TransactionID;
        uint DrugID;
        uint PatchNo;
        uint FromOwner;
        uint ToOwner;
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

    function addTransaction(uint _drugid, uint _patchno, uint _fromowner, uint _toowner, uint _fullamount, uint _remainamount, uint _transdate) public {
        transactions[transactionsCount] = Transaction(transactionsCount,_drugid, _patchno, _fromowner, _toowner, _fullamount, _remainamount, _transdate);
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
      uint[]  memory fromowner = new uint[](transactionsCount);
      uint[]  memory toowner = new uint[](transactionsCount);
      uint[]  memory fullamount = new uint[](transactionsCount);
      uint[]  memory remainamount = new uint[](transactionsCount);
      uint[]  memory transdate = new uint[](transactionsCount);
      
      for (uint i = 0; i < transactionsCount; i++) {
          Transaction storage transaction = transactions[i];
          transid[i] = transaction.TransactionID;
          drugid[i] = transaction.DrugID;
          patchno[i] = transaction.PatchNo;
          fromowner[i] = transaction.FromOwner;
          toowner[i] = transaction.ToOwner;
          fullamount[i] = transaction.FullAmount;
          remainamount[i] = transaction.RemainAmount;
          transdate[i] = transaction.TransactionDate;
      }

      return (transid, drugid, patchno, fromowner, toowner,fullamount, transdate);

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