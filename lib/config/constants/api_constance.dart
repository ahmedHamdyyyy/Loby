class ApiConstance {
  static const baseUrl = "https://Luby-rafiks-projects-827f7443.vercel.app/api/v1/";

  static const signin = "auth/signin";
  static const signup = "auth/signup";
  static const logout = "auth/logout";

  static userProfile(String id) => "users/$id";
  static getProperty(String id) => "properties/$id";
  static updateProperty(String id) => "properties/$id";
  static const createProperty = "properties";
}
