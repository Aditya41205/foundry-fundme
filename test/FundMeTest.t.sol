// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test,console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundeMe.sol";
import {DeployFundMe} from "../script/DeployFundMe.s.sol";

contract FundMeTest is Test{
    FundMe fundMe;
    address USER =makeAddr("user");
    
   function setUp() external{
     //fundMe= new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);
     DeployFundMe deployfundme = new DeployFundMe();
     fundMe=deployfundme.run();
     vm.deal(USER,100 ether);
   }


   modifier funded(){
     vm.prank(USER);
      fundMe.fund{value:5e18}();
      _;
   }

   function testminimumusd()public {
      assertEq(fundMe.MINIMUM_USD(),5e18);
      
   }

   function testOwnerIsMsgSender() public {
     
      assertEq(fundMe.i_owner(), msg.sender);
      
   }

   function testversion() public{
      uint256 version  = fundMe.getVersion();
      assertEq(version, 4);
   }


   function testEnougheth() public {
       vm.expectRevert();
       fundMe.fund();
   }

   function testfunctiongetsupdated() public funded {
      
      uint256 amountfunded = fundMe.getAddressToAmountFunded(USER);
      assertEq(amountfunded, 5e18);
      
   }



   function testaddsfundertoarray() public  funded{
     
      address funder = fundMe.getFunder(0);
      assertEq(funder,USER);
   }


   function testwithdrawonlyowner() public {
      vm.prank(USER);
      fundMe.fund{value:5e18}();

      vm.expectRevert();
      fundMe.withdraw();
   }


   
}