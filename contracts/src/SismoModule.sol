// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// import SismoConnect Solidity library
import "sismo-connect-packages/SismoLib.sol";
import {SismoConnectConfig} from "sismo-connect-onchain-verifier/src/libs/utils/RequestBuilder.sol";

/**
 * @title Bond
 * @author nigsdev
 */
 contract Enum {
    enum Operation {
        Call,
        DelegateCall
    }
}

interface GnosisSafe {
    /// @dev Allows a Module to execute a Safe transaction without any further confirmations.
    /// @param to Destination address of module transaction.
    /// @param value Ether value of module transaction.
    /// @param data Data payload of module transaction.
    /// @param operation Operation type of module transaction.
    function execTransactionFromModule(
        address to,
        uint256 value,
        bytes calldata data,
        Enum.Operation operation
    ) external returns (bool success);

    function addOwnerWithThreshold(address owner, uint256 threshold) external;
}


contract SismoModule is SismoConnect {
    bytes16 public groupId;
    GnosisSafe public safe;

    constructor(address _safe, SismoConnectConfig memory _config, bytes16 _groupId) SismoConnect(_config) {
        safe = GnosisSafe(_safe);
        groupId = _groupId;
    }

    /// @dev Change group identifier
    /// @param _groupId group identifier to check the claim
    function setGroupId(bytes16 _groupId) public {
        require(msg.sender == address(safe), "!safe");
        groupId = _groupId;
    }


    /// @dev Exec tx using zkConnect proof
    /// @param to Destination address of module transaction
    /// @param value Ether value of module transaction
    /// @param data Data payload of module transaction
    /// @param operation Operation type of module transaction
    function execTransactionFromModule(
        address to,
        uint256 value,
        bytes calldata data,
        Enum.Operation operation,
        bytes memory zkConnectResponse
    ) public virtual returns (bool success) {
        SismoConnectVerifiedResult memory result = verify({
            responseBytes: zkConnectResponse,
            auth: buildAuth({authType: AuthType.VAULT}),
            claim: buildClaim({groupId: groupId}),
            signature: buildSignature({message: abi.encode(to, value, data, operation)})
        });

        require(safe.execTransactionFromModule(to, value, data, operation), "Module transaction failed");

        return true;
    }

}