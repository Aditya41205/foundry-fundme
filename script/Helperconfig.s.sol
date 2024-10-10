// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {MockV3Aggregator} from "../test/mocks/MockV3Aggregator.sol";

contract HelperConfig is Script{


Networkconfig public activeNetworkconfig;

constructor(){
    if(block.chainid==11155111){
        activeNetworkconfig=getsepoliaEthConfig();
    }
    else{
        activeNetworkconfig=getAnvilEthConfig();
    }
}

struct Networkconfig{
    address priceFeed;
}



    function getsepoliaEthConfig() public pure returns(Networkconfig memory){
       Networkconfig  memory Sepoliaconfig= Networkconfig({priceFeed:0x694AA1769357215DE4FAC081bf1f309aDC325306});
       return Sepoliaconfig;
    }

    function getAnvilEthConfig() public  returns (Networkconfig memory){
    vm.startBroadcast();
    MockV3Aggregator mockfeed = new MockV3Aggregator(8,2000e8);
    vm.stopBroadcast();
    Networkconfig memory anvilconfig=Networkconfig({priceFeed:address(mockfeed)});
    return anvilconfig;
    }

}