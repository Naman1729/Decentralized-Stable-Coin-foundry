// SPDX-License-Identifier: MIT

// Have our invariants (properties)
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {StdInvariant} from "forge-std/StdInvariant.sol";
import {DeployDSC} from "../../script/DeployDSC.s.sol";
import {DecentralizedStableCoin} from "../../src/DecentralizedStableCoin.sol";
import {DSCEngine} from "../../src/DSCEngine.sol";
import {HelperConfig} from "../../script/HelperConfig.s.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {Handler} from "./HandlerTest.t.sol";

contract OpenInvariantsTest is StdInvariant, Test {
    DeployDSC deployer;
    DecentralizedStableCoin dsc;
    DSCEngine dsce;
    HelperConfig config;
    address weth;
    address wbtc;
    Handler handler;

    function setUp() external {
        deployer = new DeployDSC();
        (dsc, dsce, config) = deployer.run();
        (,, weth, wbtc,) = config.activeNetworkConfig();
        // targetContract(address(dsce));
        handler = new Handler(dsce, dsc);
        targetContract(address(handler));
    }

    function invariant_protocolMustHaveMoreValueThanCollateral() public view {
        uint256 totalSupply = dsc.totalSupply();
        uint256 totalEthDeposted = IERC20(weth).balanceOf(address(dsce));
        uint256 totalBthDeposted = IERC20(wbtc).balanceOf(address(dsce));

        uint256 wethValue = dsce.getUsdValue(weth, totalEthDeposted);
        uint256 wbtcValue = dsce.getUsdValue(wbtc, totalBthDeposted);

        console.log("totalSupply: ", totalSupply);
        console.log("wethValue: ", wethValue);
        console.log("wbtcValue: ", wbtcValue);
        assert((wethValue + wbtcValue) >= totalSupply);
    }
}

// Notes:
/**
 * These are the steps to follow to run good fuzz tests:
 * 1. Understand the Invariant (the property of the system that should always hold)
 * 2. Write a test for the Invariant
 */

//         fuzz test
//          /     \
//    stateless   stateful
//    fuzzing       fuzzing

// Stateless Fuzzing: Where the state of the previous run is discarded for every new run.
// Stateful Fuzzing: Fuzzing where the final state of your previous run is the starting state of your next run.
// Stateful Fuzzing is more powerful than Stateless Fuzzing because it allows you to test the system in a more realistic way.