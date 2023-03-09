//SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;

contract Bank{
    struct Account{
        address owner;
        uint256 balances;
        uint256 accountcreatedTime;
    }                                      //database of the bank
    mapping (address=> Account) public SealedSafeBank;
    event balancesadded(address owner,uint256 balances,uint256 timestamp);
    event withdrawalDone(address owner,uint256 balances,uint256 timestamp);

    modifier minimum() {
        require(msg.value >= 1 ether,"Doesn't follow minimum criteria ");
        _;

    }
    //account creation
    function accountcreated()
        public
        payable
        minimum{
            SealedSafeBank[msg.sender].owner = msg.sender;
            SealedSafeBank[msg.sender].balances =msg.value; 
            SealedSafeBank[msg.sender].accountcreatedTime=block.timestamp;
            emit balancesadded(msg.sender,msg.value,block.timestamp);
        }
    
    //depositing 
    function deposit()
    public
    payable
    minimum{
        SealedSafeBank[msg.sender].balances+=msg.value;
        emit balancesadded(msg.sender,msg.value,block.timestamp);
    
    }
    function withdrawal()
    public
    payable{
        //address.transfer(amount to transfer)
       payable(msg.sender).transfer(SealedSafeBank[msg.sender].balances); 
       emit withdrawalDone(msg.sender,SealedSafeBank[msg.sender].balances,block.timestamp);
    }
    
}
