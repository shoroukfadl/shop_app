

import '../../modules/ShopApp/Login/ShopLoginScreen.dart';
import '../network/local/cash_helper.dart';
import 'components.dart';

void signOut(context)=> CashHelper.removeData(key: 'token').then((value) {
  if(value)
    navigateAndFinish(context, ShopLoginScreen());
});

String ?token;
void printFullText(String text)
{
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}