import 'package:dio/dio.dart';

enum Status { initial, loading, success, error }

enum VendorRole { non, property, activity }

class AppConst {
  static double serviceFees(double price) => price * 4 / 100;
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
  // Vendor signup extra fields
  static const nationalId = 'nationalId';
  static const iban = 'iban';
  static const certificateNumber = 'certificateNumber';
  static const nationalIdDocument = 'nationalIdDocument';
  static const ibanDocument = 'ibanDocument';
  static const certificateNumberDocument = 'certificateNumberDocument';
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
  static String normalizeError(Object e) {
    String? message;

    // 1️⃣ Handle DioException explicitly
    if (e is DioException) {
      // a) Direct Dio message (e.g. DioException(Error: ...))
      if (e.message != null && e.message!.isNotEmpty) {
        message = e.message;
      }

      // b) Response data
      final data = e.response?.data;
      if (data != null) {
        if (data is String && data.isNotEmpty) {
          message = data;
        } else if (data is Map<String, dynamic>) {
          // Common backend keys
          for (final key in ['message', 'error', 'detail', 'details', 'msg']) {
            if (data[key] != null && data[key].toString().isNotEmpty) {
              message = data[key].toString();
              break;
            }

            // Nested data { data: { message: ... } }
            if (data['data'] is Map && data['data'][key] != null && data['data'][key].toString().isNotEmpty) {
              message = data['data'][key].toString();
              break;
            }
          }
        }
      }
    }

    // 2️⃣ Handle normal Exception
    if (message == null && e is Exception) {
      message = e.toString();
    }

    // 3️⃣ Final fallback
    message ??= e.toString();

    // 🔥 Clean technical prefixes
    message =
        message
            .replaceFirst(RegExp(r'^DioException[:\(]*', caseSensitive: false), '')
            .replaceFirst(RegExp(r'^Exception[:\(]*', caseSensitive: false), '')
            .replaceFirst(RegExp(r'^Error[: ]*', caseSensitive: false), '')
            .replaceAll(')', '')
            .trim();

    // 🧠 Friendly defaults
    if (message.isEmpty || message.toLowerCase() == 'null') {
      return 'Something went wrong. Please try again.';
    }

    return message;
  }
}
