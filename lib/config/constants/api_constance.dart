class ApiConstance {
  // static const baseUrl = "https://Luby-rafiks-projects-827f7443.vercel.app/api/v1/";
  static const baseUrl = "https://dashboard.lubyksa.com/api/v1/";

  static const signin = "auth/vendor/signin";
  static const signup = "auth/vendor/signup";
  // Vendor specific signup route
  static const vendorSignup = "auth/vendor/signup";
  static const logout = "auth/logout";
  static const refreshToken = "auth/refresh-token";
  static const resetpassword = "auth/reset-password";
  static const confirmOtpSignUp = "auth/vendor/signup/verify";
  static const confirmOtpResetPassword = "auth/vendor/confirm-otp-reset-password";
  static const forgetPasswordReset = "auth/vendor/forget-password/reset";
  static const verifyEmail = "auth/vendor/signup/initiate";
  static const userProfile = "users/me";
  static const setVendorRole = "users/choose-vendor-role";
  static const updateFcmToken = "auth/vendor/update-fcm-token";
  static const updateVendorDocuments = "auth/vendor/vendor/update-documents";

  static const createActivity = "activities";
  static const getActivities = 'activities/me';
  static getActivity(String id) => "activities/$id";
  static updateActivity(String id) => "activities/$id";
  static deleteActivity(String id) => "activities/$id";

  static const createProperty = 'properties';
  static getProperty(String id) => "properties/$id";
  static updateProperty(String id) => "properties/$id";
  static const getProperties = 'properties/me';

  static const getReservations = 'registrations/vendor-registrations';
  static deleteProperty(String id) => "properties/$id";

  static String updateReservation(String id) => "registrations/vendor-registrations/$id";
  static String acceptReservation(String id) => "registrations/$id/confirm-payment";
  static const refundReservation = "payments/refund";
  static String getReservation(String id) => "registrations/$id";

  // Notifications
  static const notifications = "notifications";
  static String readNotification(String id) => "notifications/$id";
}
