//                                                    */**********,**,,,,,,,,,,,,,/,.
//                                             ./********************,,,,,,,,,,,,,,,,,,,,,#.
//                                         ***********************,////,,*,,,,,,,,,,,,,,,,,,,,,/
//                                    (***************..                           .(,,,,,,,,,,,,,,*
//                                 (************,                                         /,,,,,,,,,,,,
//                              /***********                                                  .,,,,,,,,,,,,
//                            ******#                         *%%#######%                            %*,,,,,/
//                                      #**,,,,,,,,,,,,,,,,,,,,,********/   *******************/,(
//                           *.*,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,**,*****/   *******************************(*
//                   ,/.,,,,,,,,,,,,,,,,,,,,,,,,,,,,*/.,*/(      /******/      .(/*,//*****************************/.
//                #.....,,,,,,,,,,,,,,,#                         /,*****/                         ,(*******************/
//                 ......,,,,#            //,*,***************,  /***************************/*#             (********/#
//                 ,.....,*     ,*,,,,,,,,,,,,,***************,  /,*************************************/,/    .******/
//                  ,...,,,/  ...,,,,,,,,,,,,,,********/(,,*/(,            ((/**,(//***********************(   *******#
//                  *...,,.,    ,,,,,,,,*(                                                      %//********   (******(
//               /   ...,,,,,   *,,,,,,,             .,,,,,,,,,,,,,,,,,**************             .*******   (*******   *.
//              /*/   ,.,,,,,,   (,,,,,,*    ,,,**  ,,,,,,,,,,,,,,,,,,****************/  ,,**,   (*******   .*******   (..
//              ///*   *,,,,,,,   /,,,,,,,    .  */,,,,,,                        ******##,  *   ,*******,  /*******    ....
//             (/*/*/   ,,,,,,,,   ,,,,,,,,     ...,,,,,,   /,**.         /,**/   *******//    .*******.  .********  *.....
//             //****/   ,,,,,,,,   .,,,,,,,    ...,,,,,,  ,,,***(      *,,,***(  *******//   (*******   .*******.   .......
//             //****/                          ...,,,,,,  ,,,***        .,,***   *******//             ,*******,   /......(
//             //****/     #//////////////////* /..,,,,,*                        .*******/  (((((((((((/********    #....../
//             //****/      (....,.,,,,,,,,,,,,,   /,,,,,,,*...................(*******    *******************      /......(
//             //*****.      /.,.,,,,,,,,,,,,,,,,*   ,,,,,,,,,,,,,,,,,,***************   *******************/       .,......
//             #//****%        ..,,,,,,   /,,,,,,,*     ,*,,,,,,,,,,,,***********(.     ********                    ,......
//              //*****         ,,.,,,,,,   ,,,,,,,,.   ,(.,,,,*           ****,.#    /*******/   ,,,,,,,,         #,.....*
//              ,/*****(         ..,,,,,,*   *,,,,,,,*    *,,,,,,        .******    .********    ********          ,,.....
//               /******(          ,,,,,,,,    ,,,,,,,,.    ,,,,,,/     ******.    ********.   (*******#          ,......*
//                *******           .,,,,,,,*   (,,,,,,,,    .,,,,,,/ ******/    ,********    ********           ,,,,.../
//                 *******/           ,,,,,,,,.   *,,,,,,,*    *,,,,,,*****    .********.   /*******,           ,,,,,..*
//                  *******/           ,,,,,,,,,    ,,,,,,,,/    /,,,,***     ********(   (********           .,,,.,,.,
//                   ********,           ,,,,,,,,/   .,,,,,,,,,    *,,*,    *********   /********.           ,,,,,,,.,
//                    #********           .,,,,,,,,/   /,,,,,,,,(    .    *,*******    *********           ,,,,,,,,,
//                      /*******/           *,,,,,,,,.   .,,,,,,,,(     *,*,*****.   *********           *,,,,,,,,*
//                        /*********          /,,,,,,,,*   /,,,,,,,,( ,,,,*,***    *********           ,,,,,,,,,,
//                          *********/          ,,,,,,,,,    /,,,,,,,,,,,,,,*    /********.         #,,,,,,,,,#
//                            (**********         /,,,,,,,,.   ,,,,,,,,,,,*    *********         *,,,,,,,,,,
//                              ,***********,       ,,,,,,,,,,   ,,,,,,,*    **********      /*,,,,,,,,,,/
//                                  *************.    ,,,,,,,,,*    *,(   .*********.   .(,,,,,,,,,,,,/
//                                     (************,   .,,,,,,,,,      (,,,******    ,,,,,,,,,,,,,
//                                         ,**********(    ,,,,,,,,,(,,,,,,,****    ,,,,,,,,,,*
//                                              ,/*******    *,,,,,,,,,,,,,***   .,,,,,,,.
//                                                      /,*    (,,,,,,,,,,/    //,*
//                                                                *,,,,,/
//                                                                   /
//
//          Telegram: https://t.me/bankaieth
//          Twitter: https://twitter.com/Bank_AIETH
//          Website: https://bankai.app/
//          Staking: https://dapp.bankai.app/staking
//
//SPDX-License-Identifier: MIT

pragma solidity 0.8.24;
import "./TestLib.sol";
contract getUserStakedNftsFacet is DividendTracker, Ownable {
    using EnumerableSet for EnumerableSet.UintSet;
    using EnumerableSet for EnumerableSet.AddressSet;

    function getUserStakedNfts(
        address _user
    ) external view returns (uint256[] memory) {
        TestLib.TestStorage storage ds = TestLib.diamondStorage();
        return ds.holderNftsStaked[address(ds.nftAddress)][_user].values();
    }
}
