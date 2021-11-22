pragma solidity ^0.5.5;

import "./KaseiCoin.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";

contract KaseiCoinCrowdsale is Crowdsale, MintedCrowdsale { 

    constructor(uint rate, address payable wallet, KaseiCoin coin) Crowdsale(rate, wallet, coin) public {
        
    }    
}

contract KaseiCoinCrowdsaleDeployer {

    address public kasei_coin_address;
    address public kasei_crowdsale_address;
    
    constructor(string memory name, string memory symbol, address payable wallet) public {
        
        KaseiCoin coin = new KaseiCoin(name, symbol,0);
        kasei_coin_address = address(coin);
        
        KaseiCoinCrowdsale kasei_crowdsale = new KaseiCoinCrowdsale(1, wallet, coin);
        kasei_crowdsale_address = address(kasei_crowdsale);
        
        coin.addMinter(kasei_crowdsale_address);
        coin.renounceMinter();
        
    }
}