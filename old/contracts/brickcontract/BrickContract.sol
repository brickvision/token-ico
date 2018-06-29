pragma solidity ^0.4.23;

import 'zeppelin-solidity/contracts/token/ERC20/MintableToken.sol';

contract BrickContract is MintableToken {
    string public name = "BrickContract by BrickVision";
    string public symbol = "BRICKS";
    uint8 public decimals = 18;
}