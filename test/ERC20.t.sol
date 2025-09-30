function testMint() public {
    ERC20 token = new ERC20("Test Token", "TST");
    token.mint(address(this), 1000 ether);
    assertEq(token.balanceOf(address(this)), 1000 ether);
}

