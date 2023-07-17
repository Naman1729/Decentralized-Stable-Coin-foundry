// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

/**
 * @title DSCEngine
 * @author Naman Gautam
 *
 * The sysytem is designed to be as minimal as possible, and have the tokens maintain a 1 token == $1 peg.
 * This stablecoin has the properties:
 * - Exogenous Collateral
 * - Dollar Pegged
 * - Algorithmically Stable
 *
 * It is similar to DAI if DAI had no governance, no fees, and was only backed by WETH and WBTC.
 *
 * @notice This contract is the DSC System. It handles all the logic for mining and redeeming DSC, as well as deposting & withdrawing collateral.
 * @notice This contract is VERY loosly based on the MakerDAO DSS (DAI) system
 */

contract DSCEngine {
    function depositCollateralAndMintDsc() external {}

    function redeemCollateralForDsc() external {}
}
