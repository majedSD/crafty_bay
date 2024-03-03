class Urls {
  static const String _baseUrl = 'https://craftybay.teamrabbil.com/api';
  static String sentEmailOtp(String email) => '$_baseUrl/UserLogin/$email';
  static String otpVerify(String email, String otp) =>
      '$_baseUrl/VerifyLogin/$email/$otp';

  static String readProfile = '$_baseUrl/ReadProfile';
  static String createProfile = '$_baseUrl/CreateProfile';
  static String homeBanner = '$_baseUrl/ListProductSlider';
  static String categoryItems = '$_baseUrl/CategoryList';
  static String popularProductList = '$_baseUrl/ListProductByRemark/popular';
  static String specialProductList = '$_baseUrl/ListProductByRemark/special';
  static String newProductList = '$_baseUrl/ListProductByRemark/new';
  static String productListByCategory(int categoryId) =>
      '$_baseUrl/ListProductByCategory/$categoryId';
}