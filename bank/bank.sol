// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract Bank{
  /**
   * @dev
   */
  address public owner;
  mapping(address => uint) public balances;
  address[3] public topAddresses;
  uint256[3] public topAmounts;

  constructor() payable {
    owner = msg.sender;
  }
  function updateTopThree(address account, uint256 amount) public {
        // 先跟第三名比较，确定是否进入前三名的排序
        if (amount > topAmounts[2]) {
            // 检查是否是第一名
            if (amount > topAmounts[0]) {
                // 移动第一名到第二名，第二名到第三名
                topAmounts[2] = topAmounts[1];
                topAddresses[2] = topAddresses[1];

                topAmounts[1] = topAmounts[0];
                topAddresses[1] = topAddresses[0];

                // 设置新的第一名
                topAmounts[0] = amount;
                topAddresses[0] = account;
            } else if (amount > topAmounts[1]) {
                // 移动第二名到第三名
                topAmounts[2] = topAmounts[1];
                topAddresses[2] = topAddresses[1];

                // 设置新的第二名
                topAmounts[1] = amount;
                topAddresses[1] = account;
            } else {
                // 设置新的第三名
                topAmounts[2] = amount;
                topAddresses[2] = account;
            }
        }
    }
    receive() external payable {
    balances[msg.sender] += msg.value;
    updateTopThree(msg.sender, balances[msg.sender]);
  }
  function withdraw() public{
    if(msg.sender == owner){
        uint256 contractBalance = address(this).balance;
        payable(owner).transfer(contractBalance);
    }
  }
}
