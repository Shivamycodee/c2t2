// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "lib/wormhole-solidity-sdk/src/WormholeRelayerSDK.sol";
import "lib/wormhole-solidity-sdk/src/interfaces/IERC20.sol";

contract CrossChainSender is TokenSender {
    uint256 constant GAS_LIMIT = 250_000;

    constructor(
        address _wormholeRelayer,
        address _tokenBridge,
        address _wormhole
    ) TokenBase(_wormholeRelayer, _tokenBridge, _wormhole) {}


    function quoteCrossChainDeposit(
        uint16 targetChain
    ) public view returns (uint256 cost) {
        uint256 deliveryCost;
        (deliveryCost, ) = wormholeRelayer.quoteEVMDeliveryPrice(
            targetChain,
            0,
            GAS_LIMIT
        );

        cost = deliveryCost + wormhole.messageFee();
    }

        function sendCrossChainDeposit(
        uint16 targetChain,
        address targetReceiver,
        address recipient,
        uint256 amount,
        address token
    ) public payable {
        uint256 cost = quoteCrossChainDeposit(targetChain);
        require(
            msg.value == cost,
            "msg.value must equal quoteCrossChainDeposit(targetChain)"
        );

        IERC20(token).transferFrom(msg.sender, address(this), amount);

        bytes memory payload = abi.encode(recipient);

        sendTokenWithPayloadToEvm(
            targetChain,
            targetReceiver,
            payload,
            0,
            GAS_LIMIT,
            token,
            amount
        );
    }
}
