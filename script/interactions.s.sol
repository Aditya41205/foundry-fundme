// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.19;


import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundeMe.sol";

contract FundFundMe is Script{
    uint256 send_value = 0.01 ether;
    function fundFundMe(address mostrecentdeployed) public{
     vm.startBroadcast();
     FundMe(payable(mostrecentdeployed)).fund{value:send_value}();
     vm.stopBroadcast();
    }

function run() external {
 address mostrecentdeployed= DevOpsTools.get_most_recent_deployment("FundMe",block.chainid);
 fundFundMe(mostrecentdeployed);
}
}


