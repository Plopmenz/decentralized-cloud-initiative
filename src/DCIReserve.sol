// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DCIReserve {
    event Reserved(address indexed account, uint256 amount);
    event Waitlisted(address indexed account, uint256 amount);

    uint256 public available;

    constructor(uint256 totalAvailable) {
        available = totalAvailable;
    }

    function reserve(uint256 amount) external {
        if (amount > available) {
            // Can not reserve full amount
            emit Waitlisted(msg.sender, amount - available);
            if (available != 0) {
                emit Reserved(msg.sender, available);
                available = 0;
            }
        } else {
            // Can reserve full amount
            emit Reserved(msg.sender, amount);
            unchecked {
                available -= amount;
            }
        }
    }
}
