import 'package:splitwise_api/splitwise_api.dart';


//Data Classes are provided in the package see under [src/util/data/model]
void main() {
  ///to be used with shared prefs or any other token saving mech.

  SplitWiseService splitWiseService = SplitWiseService.initialize(_consumerKey, _consumerSecret);

  /// You will get the consumer key and secret from splitwise https://secure.splitwise.com/apps

  if (sharedPrefs.getString('raw_token') == null) {
    splitWiseService.validateClient();
    // this will return an authentication url you need to redirect the user to get the code
    splitWiseService.validateClient(verifier: varifierTheUserWillEnter);
    // this will then print the raw token save th etoken and tokenSecret for future use
    splitWiseService.validateClient(token: theToken, tokenSecret: theTokenSecret);
  } else {
    splitWiseService.validateClient(token: fromSavedPlace, tokenSecret: fromSavedPlace);
  }
  //example to get the current user

  CurrentUserEntity currentUserEntity = splitWiseService.getCurrentUser();
  print(currentUserEntity.user.first_name);
}
