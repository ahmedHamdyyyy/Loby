enum Status { initial, loading, success, error }

enum VendorRole { non, property, activity }

class AppConst {
  //variables
  static const id = '_id';
  static const email = 'email';
  static const name = 'name';
  static const phone = 'phone';
  static const gender = 'gender';
  static const password = 'password';
  static const passwordConfirmation = 'password_confirmation';
  static const isPropertyOwner = 'isPropertyOwner';
  static const theme = 'theme';
  static const lang = 'lang';
  static const firstName = 'firstName';
  static const lastName = 'lastName';
  static const role = 'role';
  static const vendor = 'vendor';

  static const userId = "_id";
  static const viewOnboarding = "viewOnboarding";
  static const createdAt = 'createdAt';
  static const updatedAt = 'updatedAt';
  static const address = 'address';
  static const city = 'city';
  static const type = 'type';
  static const date = 'date';
  static const accessToken = 'accessToken';
  static const refreshToken = 'refreshToken';
  static const profilePicture = 'profilePicture';
  static const user = 'user';
  static const vendorRole = 'vendorRole';

  //screens
  /*   static const splashScreen = '/';
  static const signInScreen = '/signInScreen';
  static const signUpScreen = '/signUpScreen';
  static const adminScreen = '/adminHomeScreen';
  static const userScreen = '/userHomeScreen';
  static const addProductScreen = '/AddProductScreen';
  static const detailsScreen = '/detailsScreen';
  static const cutomerScreen = '/customerHomeScreen'; */

  // cache
  static const String tokenKey = 'auth_token';
  static const String isLoggedInKey = 'is_logged_in';

  static const daysOfWeek = ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'];
}
