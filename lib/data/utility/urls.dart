class Urls{
  static const String _baseUrl='http://ecom-api.teamrabbil.com/api';
  static String sendEmailOtp(String email)=>'$_baseUrl/UserLogin/$email';
  static String sendOtp(String email,String otp)=>'$_baseUrl/VerifyLogin/$email/$otp';
  static String readProfile='$_baseUrl/ReadProfile';
  static String creatProfile='$_baseUrl/CreateProfile';
  static String brandList='$_baseUrl/BrandList';
  static String categoryList='$_baseUrl/CategoryList';
  static String cartList='$_baseUrl/CartList';
  static String createCartList='$_baseUrl/CreateCartList';
  static String productWishList='$_baseUrl/ProductWishList';
  static String listProductSlider='$_baseUrl/ListProductSlider';
  static String createProductReview='$_baseUrl/CreateProductReview';
  static String listProductByCategory(int id)=>'$_baseUrl/ListProductByCategory/$id';
  static String listProductByRemark(String remark)=>'$_baseUrl/ListProductByRemark/$remark';
  static String productDetailsById(int id)=>'$_baseUrl/ProductDetailsById/$id';
  static String deleteCartList(int id)=>'$_baseUrl/DeleteCartList/$id';
  static String invoiceCreate='$_baseUrl/InvoiceCreate';
  static String reviewList(int id)=>'$_baseUrl/ListReviewByProduct/$id';
}