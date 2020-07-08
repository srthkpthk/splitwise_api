# SplitWise API for Dart [![Say Thanks!](https://img.shields.io/badge/Say%20Thanks-!-1EAEDB.svg)](https://saythanks.io/to/techysrthk%40gmail.com) [![License](https://img.shields.io/badge/license-MIT-orange.svg)](https://github.com/srthkpthk/splitwise_api/blob/master/LICENSE.md) ![GitHub stars](https://img.shields.io/github/stars/srthkpthk/splitwise_api)

A wrapper based on [SplitWise](http://dev.splitwise.com/#introduction)

- Feel free to open a PR or Issue
- Uses OAuth 1
- Data Classes Included

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
|   |-- splitwise_api.dart
|   '-- src
|       '-- util
|           |-- auth
|           |   '-- splitwise_main.dart
|           |-- data
|           |   '-- model
|           |       |-- categoriesSection
|           |       |   |-- CategoriesEntity.dart
|           |       |   |-- categories.dart
|           |       |   |-- icon_types.dart
|           |       |   |-- slim.dart
|           |       |   |-- square.dart
|           |       |   '-- subcategories.dart
|           |       |-- commentsSection
|           |       |   '-- comments
|           |       |       |-- CommentsEntity.dart
|           |       |       |-- comments.dart
|           |       |       |-- picture.dart
|           |       |       '-- user.dart
|           |       |-- expensesSection
|           |       |   |-- expenses
|           |       |   |   |-- ExpensesEntity.dart
|           |       |   |   |-- category.dart
|           |       |   |   |-- created_by.dart
|           |       |   |   |-- expenses.dart
|           |       |   |   |-- picture.dart
|           |       |   |   |-- receipt.dart
|           |       |   |   |-- repayments.dart
|           |       |   |   |-- user.dart
|           |       |   |   '-- users.dart
|           |       |   '-- postExpense
|           |       |       |-- PostExpenseEntity.dart
|           |       |       |-- category.dart
|           |       |       |-- created_by.dart
|           |       |       |-- errors.dart
|           |       |       |-- expenses.dart
|           |       |       |-- picture.dart
|           |       |       |-- receipt.dart
|           |       |       |-- repayments.dart
|           |       |       |-- user.dart
|           |       |       '-- users.dart
|           |       |-- friendsSection
|           |       |   |-- friend
|           |       |   |   |-- FriendEntity.dart
|           |       |   |   |-- balance.dart
|           |       |   |   |-- friend.dart
|           |       |   |   |-- groups.dart
|           |       |   |   '-- picture.dart
|           |       |   '-- friends
|           |       |       |-- FriendsEntity.dart
|           |       |       |-- balance.dart
|           |       |       |-- friends.dart
|           |       |       |-- groups.dart
|           |       |       '-- picture.dart
|           |       |-- groupSection
|           |       |   |-- group
|           |       |   |   |-- GroupEntity.dart
|           |       |   |   |-- avatar.dart
|           |       |   |   |-- balance.dart
|           |       |   |   |-- cover_photo.dart
|           |       |   |   |-- group.dart
|           |       |   |   |-- members.dart
|           |       |   |   |-- original_debts.dart
|           |       |   |   |-- picture.dart
|           |       |   |   '-- simplified_debts.dart
|           |       |   '-- groups
|           |       |       |-- GroupsEntity.dart
|           |       |       |-- avatar.dart
|           |       |       |-- balance.dart
|           |       |       |-- cover_photo.dart
|           |       |       |-- groups.dart
|           |       |       |-- members.dart
|           |       |       |-- original_debts.dart
|           |       |       |-- picture.dart
|           |       |       '-- simplified_debts.dart
|           |       |-- notificationSection
|           |       |   '-- getNotifications
|           |       |       |-- NotificationEntity.dart
|           |       |       |-- notifications.dart
|           |       |       '-- source.dart
|           |       |-- postResponse
|           |       |   '-- PostResponse.dart
|           |       '-- userSection
|           |           |-- currentUser
|           |           |   |-- CurrentUserEntity.dart
|           |           |   |-- notifications.dart
|           |           |   |-- picture.dart
|           |           |   '-- user.dart
|           |           '-- user
|           |               |-- User.dart
|           |               |-- picture.dart
|           |               '-- user.dart
|           '-- helper
|               '-- TokensHelper.dart
'-- pubspec.yaml


```
#### Usage 
- Import the package 
```yaml
dependencies:
  splitwise_api: ^1.0.1
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
  SplitWiseService splitWiseService =
  SplitWiseService.initialize(_consumerKey, _consumerSecret);

  /// SplitWiseHelper is for saving and retrieving from shared storage
  SplitWiseHelper splitWiseHelper = SplitWiseHelper();
  if (splitWiseHelper.getTokens() == null) {
    var authURL = splitWiseService.validateClient();
    print(authURL);
    //This Will print the token and also return them save them to Shared Prefs
    TokensHelper tokens = await splitWiseService.validateClient(
        verifier: 'theTokenYouGetAfterAuthorization');
    await splitWiseHelper.saveTokens(tokens);

    splitWiseService.validateClient(tokens: tokens);
  } else {
    splitWiseService.validateClient(
        tokens: /* tokens from saved */);
    //Example
    splitWiseService.getCurrentUser();
  }
}

```
> Hit like if it helped 

