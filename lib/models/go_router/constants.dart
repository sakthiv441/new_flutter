import 'Recipes.dart';

const String initialize = 'initialize';
const String rootRouteName = 'rootRouteName';

const String loginRouteName = 'login';
const String createAccountRouteName = 'createAccountRouteName';
const String subDetailsRouteName = 'subDetailsRouteName';
const String profile = 'profile';
const String profilePaymentRouteName = 'profilePaymentRouteName';
const String profileSigninInfoRouteName = 'profileSigninInfoRouteName';
const String profileMoreInfoRouteName = 'profileMoreInfoRouteName';
const String detailsRouteName = 'detailsRouteName';

const String personalRouteName = 'personalRouteName';

const String onboarding = 'onboard';
const String homeRouteName = 'Home';
const String Explore = 'Explore';
const String loggedInKey = 'LoggedIn';

class Recipes {
  static final data = [
    IsRecipe(id: 'Explore', name: 'Explores'),
    IsRecipe(id: 'Recipes', name: 'Recipess'),
    IsRecipe(id: 'tobuy', name: 'tobuys'),
  ];

  static IsRecipe family(String fid) => data.family(fid);
}

extension on List<IsRecipe> {
  IsRecipe family(String fid) => singleWhere(
        (f) => f.id == fid,
        orElse: () => throw Exception('unknown family $fid'),
      );
}
