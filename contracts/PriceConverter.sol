// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";


library PriceConverter {
    // Getting real time Data from the data feeds 
    function getPrice() internal view returns(uint256){
        // Interacting with the contract we need two things
        // Address 0x694AA1769357215DE4FAC081bf1f309aDC325306
        // ABI (Interface of functions )

        // We are creating a new instance with the contract address of the ETH/USD 
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int256 price,,,) = priceFeed.latestRoundData();
        // Price we get here is the ETH in terms of USD
        // 2e8 But the msg value is in terms of 1e18 so we need to convert it

        return uint256(price * 1e10);
    }

    function getConversionRate(uint256 ethAmount) internal view returns(uint256){
        // ethAmount = 1e18
        // ethPrice = 2000e18
        // ethAmountinUSD = 2000
        uint256 ethPrice = getPrice();
        uint256 ethAmountinUSD = (ethAmount * ethPrice) / 1e18;
        return ethAmountinUSD;
    }

    function getVersion() internal view returns(uint256){
        return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    }
}
