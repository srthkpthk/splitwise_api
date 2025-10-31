import 'package:splitwise_api/splitwise_api.dart';

/// Simple example demonstrating the Splitwise API OAuth 1.0 authentication flow.
///
/// Note: This package returns raw JSON responses. You need to parse them yourself.
void main() async {
  // Step 1: Register your app at https://secure.splitwise.com/apps
  const consumerKey = 'YOUR_CONSUMER_KEY';
  const consumerSecret = 'YOUR_CONSUMER_SECRET';

  // Step 2: Initialize the service
  final splitWiseService = SplitWiseService.initialize(
    consumerKey,
    consumerSecret,
  );

  // Step 3: Get the authorization URL
  final authURL = await splitWiseService.validateClient();
  print('Visit this URL to authorize:\n$authURL\n');

  // Step 4: User visits the URL and authorizes your app
  // They will receive a verifier code
  const verifier = 'PASTE_YOUR_VERIFIER_CODE_HERE';

  // Step 5: Exchange the verifier for access tokens
  final tokens = await splitWiseService.validateClient(verifier: verifier);
  print('Authentication successful!');
  print('Token: ${tokens.token}');
  print('Token Secret: ${tokens.tokenSecret}\n');

  // IMPORTANT: Save these tokens securely for future use
  // Example using shared_preferences:
  //   await prefs.setString('token', tokens.token ?? '');
  //   await prefs.setString('tokenSecret', tokens.tokenSecret ?? '');

  // Step 6: For subsequent sessions, restore the client with saved tokens
  await splitWiseService.validateClient(tokens: tokens);

  // Step 7: Make API calls (returns raw JSON strings)
  final currentUser = await splitWiseService.getCurrentUser();
  print('Current User:\n$currentUser\n');

  final friends = await splitWiseService.getFriends();
  print('Friends:\n$friends\n');

  final groups = await splitWiseService.getGroups();
  print('Groups:\n$groups');
}
