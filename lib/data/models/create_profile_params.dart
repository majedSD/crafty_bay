class CreateProfileParams {
  final String firstname;
  final String lastname;
  final String mobile;
  final String city;
  final String shippingAddress;

  CreateProfileParams({
    required this.firstname,
    required this.lastname,
    required this.mobile,
    required this.city,
    required this.shippingAddress,
  });

  Map<String, dynamic> toJson() => {
    "firstName": firstname,
    "lastName": lastname,
    "mobile": mobile,
    "city": city,
    "shippingAddress": shippingAddress,
  };
}