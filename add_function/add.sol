// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract Counter {
  /**
   * @dev
   */
  uint public counter;
  constructor() {
    counter = 0;
  }
  
  function count() public {
    counter = counter + 1;
  }

  function add(uint x) public {
    counter = counter + x;
  }
}

