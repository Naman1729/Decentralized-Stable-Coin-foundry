// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {DeployDSC} from "../../script/DeployDSC.s.sol";
import {DecentralizedStableCoin} from "../../src/DecentralizedStableCoin.sol";
import {DSCEngine} from "../../src/DSCEngine.sol";

contract DSCEngineTest {
    DeployDSC deployer;
    DecentralizedStableCoin dsc;
    DSCEngine dscEngine;

    function setup() public {
        deployer = new DeployDSC();
        (dsc, dscEngine) = deployer.run();
    }

      ///////////////////////////
     ///////  Price Tests  /////
    ///////////////////////////
    


}
