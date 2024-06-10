import 'package:flutter/material.dart';

 const kSecondaryColor =Color(0xff7BCFE9);
 const kColorfont =Color(0xff57636F);
 const kColorfont2 =Color(0xff7A8D9C);
const kShadowColor = Color(0xff5F5F60);
const kColorGray = Color(0xff777777);

const String baseUrl = 'https://tufahatin.net/wp-json/wc/v3';

const String loginUrl ='/login';
const String registerUrl ='/register';
const String registerSocialUrl ='/register_by_social_media';
const String categoyUrl ='/products/categories';
const String verifyEmailUrl ='/forget_password';
const String showProductsUrl ='/products';
const String resendVerificationCodeUrl ='/reset_password';
const String  changePasswordUrl ='/change_password';
const String profile = '/show_profile';
const String review =  '/products/reviews';
const String getreview =  '/reviews';
const String address = '/customers';
const String editaddress = '/update_customer_address';
const String changeProfile = '/edit_profile';
const String order = '/orders';
const String payment = '/payment_gateways';
const String popular = '/products?orderby=popularity&order=desc';
const String addproductstocart = 'https://tufahatin.net/wp-json/';
const String updateorder = '/update_order_to_paid';
const String getproductstocart = 'https://tufahatin.net/wp-json/';
 const String location ='/add_customer_address';
 const String getlocation ='/list_all_address';
 const String deletelocation ='/remove_customer_address';

const String token_pref ='token';
const String cart_key = 'X-CoCart-API';
const String id_pref ='id';
const String cookie_pref ='id';
const String idProduct_Pref ='id_product';
const String skip_intro = 'skip_intro';
const String cart_pro = 'cart';

const String addFigure = '/add_product_to_wishlist';
const String favorite = '/get_favourite_products';
const String deleteFigure = '/remove_product_to_wishlist';

const String searchProducts = '/products';





const kBackgroundColor = Color(0xFFF1EFF1);
const kPrimaryColor = Color(0xFFf53845);
const kSecondaryColor2 = Color(0xFFFFA41B);
const kTextColor = Color(0xFF000839);
const kTextLightColor = Color(0xFF747474);
const kBlueColor = Color(0xFF40BAD5);

const kDefaultPadding = 10.0;

// our default Shadow
const kDefaultShadow = BoxShadow(
 offset: Offset(0, 15),
 blurRadius: 27,
 color: Colors.black12, // Black color with 12% opacity
);
