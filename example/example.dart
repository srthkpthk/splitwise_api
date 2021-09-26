// import 'package:splitwise_api/splitwise_api.dart';
// import 'package:splitwise_api/src/util/data/model/current_user_entity.dart';
//
//
// void main() async {
//   SplitWiseService splitWiseService =
//   SplitWiseService.initialize(_consumerKey, _consumerSecret);
//
//   /// SplitWiseHelper is for saving and retrieving from shared storage
//   SplitWiseHelper splitWiseHelper = SplitWiseHelper();
//   if (splitWiseHelper.getTokens() == null) {
//     var authURL = splitWiseService.validateClient();
//     print(authURL);
//     //This Will print the token and also return them save them to Shared Prefs
//     TokensHelper tokens = await splitWiseService.validateClient(
//         verifier: 'theTokenYouGetAfterAuthorization');
//     await splitWiseHelper.saveTokens(tokens);
//
//     splitWiseService.validateClient(tokens: tokens);
//   } else {
//     splitWiseService.validateClient(
//         tokens: /* tokens from saved */);
//     //Example
//     CurrentUserEntity currentUserEntity = await splitWiseService
//         .getCurrentUser();
//     print(currentUserEntity.user.firstName);
//   }
// }
