class ApiConstant {
  static const String baseUrl = 'https://accept.paymob.com/api';
  static const String getAuthToken = '/auth/tokens';
  static const String paymentApiKey =
      'ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2TnpRek5qa3lMQ0p1WVcxbElqb2lhVzVwZEdsaGJDSjkuakxZNlJiY3VOUVZfX2Vpc0NmWVllVXhLREVTLUtQWTQtNnpKXzlSQVgxRkVmdjRJTmxYUzZvalhIUXhnYmhpenNBbmFCckw0RVU2NXRvMGYwR3Qtd0E=';
  static const String getOrderId = '/ecommerce/orders';
  static const String getPaymentKeyRequest = '/acceptance/payment_keys';
  static const getRefCode = '/acceptance/payments/pay';
  static String visaUrl =
      '$baseUrl/acceptance/iframes/752845?payment_token=$paymentFinalToken';

  static String paymentFirstToken = '';
  static String paymentFinalToken = '';
  static String paymentOrderId = '';
  static String refCode = '';

  static const String integrationIdCard = '3733354';
  static const String integrationIdKiosk = '3736224';
}

class AppImages {
  static const String refCodeImage =
      "https://cdn-icons-png.flaticon.com/128/4090/4090458.png";
  static const String visaImage =
      "https://cdn-icons-png.flaticon.com/128/349/349221.png";
}
