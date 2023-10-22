// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import {SismoModule} from "src/SismoModule.sol";
import {SismoConnectConfig, VaultConfig} from "sismo-connect-onchain-verifier/src/libs/utils/RequestBuilder.sol";

contract DeploySismoModule is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        
        bytes16 _appId = 0xf5831918dad952c25dc4b8b45ee1d45f;
        VaultConfig memory _vault;
        _vault.isImpersonationMode = false;

        address _safe = 0xcBA7EF4F7a5e75b2B1bc377684db48bA41516378;
        SismoConnectConfig memory _config;
        _config.appId = _appId;
        _config.vault = _vault;
        bytes16 _groupId = 0x0f800ff28a426924cbe66b67b9f837e2; //ENS Owners

        SismoModule sismoConnectModule = new SismoModule(_safe, _config, _groupId);
        console.log("sismoconnectmodule delpoyed to", address(sismoConnectModule));
        vm.stopBroadcast();
    }
}