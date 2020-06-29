# SplitWise API for Dart [![Say Thanks!](https://img.shields.io/badge/Say%20Thanks-!-1EAEDB.svg)](https://saythanks.io/to/techysrthk%40gmail.com) [![License](https://img.shields.io/badge/license-MIT-orange.svg)](https://github.com/srthkpthk/splitwise_api/blob/master/LICENSE.md) ![GitHub stars](https://img.shields.io/github/stars/srthkpthk/splitwise_api)

A wrapper based on [SplitWise](http://dev.splitwise.com/#introduction)

- Feel free to open a PR or Issue
- Uses OAuth 1

-[ ] Included Data Classes in the Package

###  Steps
 - Get the consumerKey and consumerSecret from [Splitwise Register App](https://secure.splitwise.com/apps)
 - Check the example.dart located in example/example.dart
 
 ### Project Structure
```text
|-- .gitignore
|-- .metadata
|-- CHANGELOG.md
|-- LICENSE
|-- README.md
|-- example
|   '-- example.dart
|-- lib
|   '-- splitwise_api.dart
'-- pubspec.yaml

```
#### Usage 
- Import the package 
```yaml
dependencies:
  splitwise_api: ^0.0.1
```
- Import in the file 

```dart
import 'package:splitwise_api/splitwise_api.dart';
```
- Setup SharedPreferences or any other system to save the token and tokenSecret to keep user logged in.
     -  For Example :-
```dart
import 'package:shared_preferences/shared_preferences.dart';

class SplitWiseHelper {
  saveTokens(String text) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('tokens', text);
  }

  getTokens() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.getString('tokens');
  }
}
```
- Now Use the Wrapper and save the tokens.
  - ForExample :-
```dart
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
```
> Hit like if it helped 

