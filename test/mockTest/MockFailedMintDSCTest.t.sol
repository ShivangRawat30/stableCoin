// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import { MockFailedMintDSC } from "../mocks/MockFailedMintDSC.sol";
import { Test, console } from "forge-std/Test.sol";
import { StdCheats } from "forge-std/StdCheats.sol";

contract MockFailedMintDSCTest is Test {
    MockFailedMintDSC public mockDsc;
    uint256 public BURN_AMOUNT = 1 ether;

    function setUp() public {
        mockDsc = new MockFailedMintDSC();
    }

    function testRevertWhenAmountIsLessThanZero() public {
        vm.prank(mockDsc.owner());
        vm.expectRevert(MockFailedMintDSC.DecentralizedStableCoin__AmountMustBeMoreThanZero.selector);
        mockDsc.mint(address(this), 0);
    }

    function testRevertWhenAmountIsMoreThanBalance() public {
        vm.startPrank(mockDsc.owner());
        vm.expectRevert(MockFailedMintDSC.DecentralizedStableCoin__BurnAmountExceedsBalance.selector);
        mockDsc.burn(1 ether);
    }

    function testMintToAddressIsNotZero() public {
        vm.startPrank(mockDsc.owner());
        vm.expectRevert(MockFailedMintDSC.DecentralizedStableCoin__NotZeroAddress.selector);
        mockDsc.mint(address(0), 1 ether);
    }

    function testMintAmountCannotbeZero() public {
        vm.startPrank(mockDsc.owner());
        vm.expectRevert(MockFailedMintDSC.DecentralizedStableCoin__AmountMustBeMoreThanZero.selector);
        mockDsc.mint(address(this), 0);
    }

    function testMintFunctionAlwaysReturnFalse() public {
        vm.startPrank(mockDsc.owner());
        assert(false == mockDsc.mint(address(this), 1 ether));
    }
}
