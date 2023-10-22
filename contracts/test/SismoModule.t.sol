// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {SismoModule} from "../src/SismoModule.sol";
import {SismoConnectConfig, VaultConfig} from "sismo-connect-onchain-verifier/src/libs/utils/RequestBuilder.sol";

contract SismoModuleTest is Test {
    SismoModule public sismoModule;
    uint256 goerliFork;

    function setUp() public {
        goerliFork = vm.createFork(vm.envString("RPC_URL"));
    }

    function testSismoModule() public {
        bytes16 _appId = 0x282ff775a754ebea339746f096635a5a;
        VaultConfig memory _vault;
        _vault.isImpersonationMode = false;

        address _safe = 0x0911BA4aE8D1cbC39A3f42bC9F91B06c0d681609;
        SismoConnectConfig memory _config;
        _config.appId = _appId;
        _config.vault = _vault;
        bytes16 _groupId = 0x84f8495423ea1aa1b212356f31f6c7d9;
        sismoModule = new SismoModule(_safe, _config, _groupId);
    }
}
