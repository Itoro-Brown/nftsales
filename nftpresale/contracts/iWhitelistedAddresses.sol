//SPDX-License-Identifier : MIT

pragma solidity 0.8.9;

//The keyword "interface" is used to call a particular function on the on the
//earlier whitelist contract. This to done in order to avoid calling the whole
//functions on the contract and paying high gas fees for transactons
interface iWhitelistedAddress {
    function whitelistedAddresses(address) external view returns (bool);
}
