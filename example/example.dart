// ignore_for_file: avoid_print

import 'package:splitwise_api/splitwise_api.dart';

/// Demonstrates both ways to authenticate and a few typed API calls.
///
/// Register an application at https://secure.splitwise.com/apps to obtain a
/// consumer key/secret (for OAuth 2.0) or generate a personal API key.
Future<void> main() async {
  // ---------------------------------------------------------------------
  // Option A: personal API key — the quickest way to get started.
  // ---------------------------------------------------------------------
  final client = SplitwiseClient.apiKey('YOUR_API_KEY');

  try {
    final me = await client.getCurrentUser();
    print('Signed in as ${me.firstName} ${me.lastName} (${me.email})');

    final groups = await client.getGroups();
    for (final group in groups) {
      print(
        'Group ${group.id}: ${group.name} (${group.members.length} members)',
      );
    }

    final expenses = await client.getExpenses(limit: 5);
    for (final expense in expenses) {
      print(
        '${expense.date}  ${expense.description}  '
        '${expense.cost} ${expense.currencyCode}',
      );
    }

    // Create an expense split equally between everyone in a group.
    if (groups.isNotEmpty) {
      final created = await client.createExpense(
        EqualGroupSplit(
          cost: '25.00',
          description: 'Brunch',
          groupId: groups.first.id,
        ),
      );
      print('Created expense ${created.first.id}');

      // ...and delete it again.
      await client.deleteExpense(created.first.id);
    }
  } on SplitwiseUnauthorizedException {
    print('Invalid API key or access token.');
  } on SplitwiseRequestFailedException catch (e) {
    print('Splitwise rejected the request: ${e.errors}');
  } on SplitwiseHttpException catch (e) {
    print('HTTP ${e.statusCode}: ${e.errors}');
  } finally {
    client.close();
  }

  // ---------------------------------------------------------------------
  // Option B: OAuth 2.0 authorization-code flow for acting on behalf of
  // other users.
  // ---------------------------------------------------------------------
  final oauth = SplitwiseOAuth2(
    clientId: 'YOUR_CONSUMER_KEY',
    clientSecret: 'YOUR_CONSUMER_SECRET',
    redirectUri: Uri.parse('https://example.com/splitwise/callback'),
  );

  // 1. Send the user to this URL in a browser.
  print('Authorize at: ${oauth.authorizationUrl(state: 'random-state')}');

  // 2. Splitwise redirects back to redirectUri with ?code=...&state=...
  const codeFromRedirect = 'PASTE_THE_CODE_FROM_THE_REDIRECT';

  // 3. Exchange the code for an access token and persist token.toJson().
  final token = await oauth.exchangeCode(codeFromRedirect);
  oauth.close();

  // 4. Later: restore the token and create a client with it.
  final restored = OAuth2Token.fromJson(token.toJson());
  final userClient = SplitwiseClient.accessToken(restored.accessToken);
  final friends = await userClient.getFriends();
  print('${friends.length} friends');
  userClient.close();
}
