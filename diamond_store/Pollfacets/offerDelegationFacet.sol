// SPDX-License-Identifier: MIT

/*
MIT License

Copyright (c) 2024 Cat Church LLC (see CCC.meme)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

pragma solidity ^0.8.0;

interface IVoteWeightSource {
    // Function to get the index and vote weight based on a timestamp
    function GetIndexAndVoteWeight(
        address user,
        uint40 inputTimestamp
    ) external view returns (bool isValid, uint64 index, uint256 voteWeight);

    // Low gas alternative to GetIndexAndVoteWeight for validating and retrieving vote weight
    function GetAndValidateVoteWeight(
        address user,
        uint64 indexUint64,
        uint40 inputTimestampUint40
    ) external view returns (bool isValid, uint96 voteWeight);
}

// votedPower is 0 if < 1M votes, else 1 if < 3M votes, else 2 if less than 10M votes,
//   else 3 if < 30M, else 4 if < 100M, else 5 if < 300M, else 6.  Thus voted power is sort of like a decibels metric.
// Hopefully this enables efficient spam filtration and also polls that start with high votePower have higher
// pollNumber. (top 3 bits of 40-bit number are the initial votedPower upon creation,
// if creator both creates the poll and votes on it in one transaction).  There is a gas optimization
// for voters that vote on polls and they voted on recent polls of the same votePower.  Therefore it
// can cost less to vote on polls that start off above the spam filter (e.g. at least above 0 in power).
// Which helps facilitate more voting by reducing gas costs of those votes.  This is because
// the cheapest way to vote will be to vote all votePower in a single vote, these vote records will
// be stored in-order in an array indexed by the votePower.  The voteRecord is only the 4-bits of which
// which option was chosen (add 1 to it, so it is non-zero for true vote).  So a 256-bit word can
// hold 64 votes.

// votedOption has 1 of 16 values:
// 0 means unvoted
// 1 means voted through the partial-vote mechanism
// 2 means Reserved/(Previosly used for Invalid Proposal) (Option 0)
// 3 means Active Abstain (Option 1)
// 4 means Poll Creator-defined Option 0 (Option 2)
// 5 means Poll Creator-defined option 1 (Option 3)
// 6 means Poll Creator-defined option 2 (Option 4)
// 7 means Poll Creator-defined option 3 (Option 5)
// 8 means Poll Creator-defined option 4 (Option 6)
// 9 means Poll Creator-defined option 5 (Option 7)
// 10 means Poll Creator-defined option 6 (Option 8)
// 11 means Poll Creator-defined option 7 (Option 9)
// 12 means Poll Creator-defined option 8 (Option 10)
// 13 means Poll Creator-defined option 9 (Option 11)
// 14 means Poll Creator-defined option 10 (Option 12)
// 15 means Poll Creator-defined option 11 (Option 13)

// We will not actually let people vote Invalid Proposal explicitly, since we have changed the
// design to use a flag so any vote can also vote invalid proposal.  But we keep Invalid Proposal
// reserved here in case we need a flag late in design and don't want to have to change so much code.

// The vote weight that is voted can be read from the voteWeight contract so
// the amount voted does not need to be stored when full vote weight is being voted.

// The sum gas for votes at votePowers the voter has previously voted on, where the voter votes
// frequently on votes of that vote power is 21k (base transaction) + ~5200 (Get and Verify voteWeight)
// plus read and modify non-zero storage (5100) (check if already voted) plus read and modify non-zero storage
// (5100) (update vote total for selected options), plus some extra calldata (~200), plus emitting an event (~700).
// Thus, gas is trending for frequent voters on polls with non-spammed votePowers, of 37,300.  So less than 2x the minimum (< 42k)

import "./TestLib.sol";
contract offerDelegationFacet {
    function offerDelegation(address offerDelegationTo) external {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        cancelDelegationOffer();
        ds.delegationOffers[msg.sender] = offerDelegationTo;
    }
    function cancelDelegationOffer() public {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        address previousOffer = ds.delegationOffers[msg.sender];
        if (previousOffer != address(0)) {
            ds.delegationOffers[msg.sender] = address(0);
            if (ds.delegationAcceptances[previousOffer] == msg.sender) {
                ds.delegationAcceptances[previousOffer] = address(0);
            }
        }
    }
}
