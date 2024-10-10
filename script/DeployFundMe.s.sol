// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.19;


import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundeMe.sol";
import {HelperConfig} from "./Helperconfig.s.sol";
contract DeployFundMe is Script{
    function run() external returns(FundMe){
        HelperConfig helperConfig = new HelperConfig();
        (address ethusd)= helperConfig.activeNetworkconfig();
        vm.startBroadcast();
       FundMe fundme= new FundMe(ethusd);
        vm.stopBroadcast();
        return(fundme);
    
    }
}