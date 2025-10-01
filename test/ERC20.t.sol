// SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.19;

import "forge-std/Test.sol"; // gives you assertEq, vm, etc
import "../src/ERC20.sol";// importing 

contract ERC20Test is Test {
    ERC20 token;

    function setUp() public {
        // it will run before each test
        token = new ERC20("Mock Token", "MCK");
    }

    function testMint() public {
        token.mint(address(this), 1000 ether);
        assertEq(token.balanceOf(address(this)), 1000 ether);
    }

    function testTransfer() public {
        token.mint(address(this), 100 ether);

        // transfer 50 to another address
        address recipient = address(0xBEEF);
        token.transfer(recipient, 50 ether);

        assertEq(token.balanceOf(address(this)), 50 ether);
        assertEq(token.balanceOf(recipient), 50 ether);
    }

    function testApproveAndTransferFrom() public {
        token.mint(address(this), 200 ether);

        address spender = address(0xCAFE);

        // approve sender
        token.approve(spender, 100 ether);

        // prank makes the next call come "from" spender
        vm.prank(spender);
        token.transferFrom(address(this), spender, 100 ether);

        assertEq(token.balanceOf(spender), 100 ether);
        assertEq(token.balanceOf(address(this)), 100 ether);
    }
}