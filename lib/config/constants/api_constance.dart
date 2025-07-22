class ApiConstance {
  static const baseUrl = "https://Luby-rafiks-projects-827f7443.vercel.app/api/v1/";

  static const signin = "auth/signin";
  static const signup = "auth/signup";
  static const logout = "auth/logout";

  static const getActivities = 'activities';
  static const userProfile = "users/me";
  static getProperty(String id) => "properties/$id";
  static updateProperty(String id) => "properties/$id";
  static getActivity(String id) => "activities/$id";
  static updateActivity(String id) => "activities/$id";
  static deleteActivity(String id) => "activities/$id";
  static const refreshToken = 'auth/refresh-token';

  static const createProperty = 'properties';
  static const getProperties = 'properties/me';
  static const createActivity = "activities";
}
