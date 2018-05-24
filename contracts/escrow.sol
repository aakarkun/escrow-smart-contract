pragma solidity ^0.4.21;

contract Escrow {
    
    enum State {UNINITIATED, AWAITING_PAYMENT, AWAITING_DELIVERY, COMPLETE}
    State public currentState;
    
    address buyer;
    address seller;
    uint price;
    
    bool public buyer_in;
    bool public seller_in;
    
    modifier inState(State expectedState) {require(currentState == expectedState); _;}
    modifier correctPrice() {require(msg.value == price); _;}
    modifier buyerOnly() {require(msg.sender == buyer); _;}
    
    
    constructor (address _buyer, address _seller, uint _price) public {
        buyer = _buyer;
        seller = _seller;
        price = _price;
        
    }
    
    function initiateContract() correctPrice inState(State.UNINITIATED) payable public {
        if(msg.sender == buyer) {
            buyer_in = true;
        }
        
        if (msg.sender == seller) {
            seller_in = true;
        }
        
        if (buyer_in && seller_in) {
            currentState = State.AWAITING_PAYMENT;
        }
    }
    
    function confirmPayment() buyerOnly inState(State.AWAITING_PAYMENT) correctPrice payable public {
        currentState = State.AWAITING_DELIVERY;
    }
    
    function confirmDelivery() buyerOnly payable public {
        seller.transfer(price*2);
        buyer.transfer(price);
        currentState = State.COMPLETE;
    }
    
}

