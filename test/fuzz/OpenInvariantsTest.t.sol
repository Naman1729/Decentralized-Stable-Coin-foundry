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

contract OpenInvariantsTest is StdInvariant, Test {
    DeployDSC deployer;
    DecentralizedStableCoin dsc;
    DSCEngine dsce;
    HelperConfig config;
    address weth;
    address wbtc;

    function setUp() external {
        deployer = new DeployDSC();
        (dsc, dsce, config) = deployer.run();
        (,, weth, wbtc,) = config.activeNetworkConfig();
        targetContract(address(dsce));
    }

    function invariant_protocolMustHaveMoreValueThanCollateral() public view {
        uint256 totalSupply = dsc.totalSupply();
        uint256 totalEthDeposted = IERC20(weth).balanceOf(address(dsce));
        uint256 totalBthDeposted = IERC20(wbtc).balanceOf(address(dsce));

        uint256 wethValue = dsce.getUsdValue(weth, totalEthDeposted);
        uint256 wbtcValue = dsce.getUsdValue(wbtc, totalBthDeposted);

        console.log("totalSupply: %s", totalSupply);
        console.log("wethValue: %s", wethValue);
        console.log("wbtcValue: %s", wbtcValue);
        assert((wethValue + wbtcValue) >= totalSupply);
    }
}
