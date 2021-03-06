//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

// Deployed to Goerli at 0xdE844613ecD39b611c785b5019C41DA4aF9D05e6

contract BuyMeACoffee {
    // Event to emit when a Memo is created
    event NewMemo(
        address indexed from,
        uint256 timestamp,
        string name,
        string message
    );

    // Memo struct
    struct Memo {
        address from;
        uint256 timestamp;
        string name;
        string message;
    }

    // Address of contract deployer 
    address payable owner;

    // List of all memos received from friends
    Memo[] memos;

    // Deploy Logic
    constructor() {
        owner = payable(msg.sender);
    }

    /**
     * @dev buy a coffee for contract owner
     * @param _name name of the coffee buyer
     * @param _message a message from the coffee buyer
     */
    function buyCoffee(string memory _name, string memory _message) public payable {
        require(msg.value > 0, "can't buy a coffee with 0 eth");

        // adds the memo to storage
        memos.push(Memo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        ));

        // Emit a log event when a new memo is created
        emit NewMemo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        );
    }

    /**
     * @dev send the entire balance stored in this contract to the owner
     */
    function withdrawTips() public {
        require(owner.send(address(this).balance));
    }

    /**
     * @dev retrievs all the memos received and stored on the blockchain
     */
    function getMemos() public view returns(Memo[] memory) {
        return memos;
    }

}