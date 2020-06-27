library splitwise_api;

import 'package:splitwise_api/src/util/auth/splitwise_auth.dart';

void main() async {
  SplitWiseAuth splitWiseAuth = SplitWiseAuth.initialize('KCrjuMMMNe2avjUM1ok2NtqXPgT5rc8bDy0XZGZD', 'vaYRDfQ4OVS6q01yDj7IjK1QctDCz8sL27l7SYfD');
//  var t = await splitWiseAuth.validateClient();
//  print(t);
//  await splitWiseAuth.validateClient(verifier: stdin.readLineSync());
  await splitWiseAuth.validateClient(token: 'Wks8yaWMzgsKhv9QLSLU5mDpaLt9RgEc4YSYUQ9R', tokenSecret: 'xaGEB1lsMk9YO87Jq0hlWz3VVgrthNtYtIa3hR95');
}
