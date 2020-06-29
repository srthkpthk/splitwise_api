import 'package:splitwise_api/splitwise_api.dart';

void main() async {
  SplitWiseService splitWiseService = SplitWiseService.initialize(_consumerKey, _consumerSecret);
  SplitWiseHelper splitWiseHelper = SplitWiseHelper();
  if (splitWiseHelper.getTokens() == null) {
    var authURL = splitWiseService.validateClient();
    print(authURL);
    var tokens = await splitWiseService.validateClient(verifier: 'theTokenYouGetAfterAuthorization');
    //This Will print the token and also return them save them to Shared Prefs
    splitWiseHelper.saveTokens(tokens);
    splitWiseService.validateClient(token: 'tokenYouGet', tokenSecret: 'tokenSecretYouGet');
  } else {
    splitWiseService.validateClient(token: 'FromSaved', tokenSecret: 'FromSaved');
    //Example
    splitWiseService.getCurrentUser();
  }
}
