import 'package:splitwise_api/splitwise_api.dart';

void main() async {
  SplitWiseService splitWiseService = SplitWiseService.initialize(_consumerKey, _consumerSecret);
  final prefs = await SharedPreferences.instance();
  if (prefs.getString('tokens') == null) {
    var authURL = splitWiseService.validateClient();
    print(authURL);
    var tokens = await splitWiseService.validateClient(verifier: 'theTokenYouGetAfterAuthorization');
    //This Will print the token and also return them save them to Shared Prefs
    prefs.setString('tokens', tokens);
    splitWiseService.validateClient(token: 'tokenYouGet', tokenSecret: 'tokenSecretYouGet');
  } else {
    splitWiseService.validateClient(token: 'FromSaved', tokenSecret: 'FromSaved');
    //Example
    splitWiseService.getCurrentUser();
  }
}
