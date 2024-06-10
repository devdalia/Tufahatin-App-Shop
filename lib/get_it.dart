import 'package:dio/dio.dart';
import 'package:ecommerce/api/category_api.dart';
import 'package:ecommerce/api/resend_verification_code_api.dart';
import 'package:ecommerce/api/update_order_api.dart';
import 'package:ecommerce/api/get_totals_cart_api.dart';
import 'package:ecommerce/providers/home_provider.dart';
import 'package:ecommerce/providers/order_provider.dart';
import 'package:ecommerce/providers/profile_provider.dart';
import 'package:ecommerce/providers/review_provider.dart';
import 'package:ecommerce/providers/verification_code_provider.dart';
import 'package:get_it/get_it.dart';
import 'api/Create_order_api.dart';
import 'api/ProfileApi.dart';
import 'api/all_searh_api.dart';
import 'api/category_product_api.dart';
import 'api/change_password_api.dart';
import 'api/discount_api.dart';
import 'api/get_payment_api.dart';
import 'api/get_review_api.dart';
import 'api/login_api.dart';
import 'api/profileEditApi.dart';
import 'api/register_api.dart';
import 'api/review_api.dart';
import 'api/add_products_to_cart_api.dart';
import 'api/getCart_api.dart';
import 'api/verify_email_api.dart';
import 'api/updataCart_api.dart';
import 'api/delet_cart.dart';
import 'providers/details_realestate_provider.dart';
import 'providers/register_provider.dart';
import 'utilities/const.dart';
import 'package:ecommerce/providers/add_cart_provider.dart';
import 'package:ecommerce/providers/location_provider.dart';
import 'package:ecommerce/api/add_new_address_api.dart';
import 'package:ecommerce/api/location_api.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerLazySingleton<LoginApi>(
    () => LoginApi(
      client: getIt(),
    ),
  );
  getIt.registerLazySingleton<RegisterApi>(
    () => RegisterApi(
      client: getIt(),
    ),
  );
  getIt.registerLazySingleton<CategoriesApi>(
    () => CategoriesApi(),
  );

  getIt.registerLazySingleton<CategoryProductApi>(
      () => CategoryProductApi(client: getIt()));

  getIt.registerLazySingleton<DiscountCodeApi>(
      () => DiscountCodeApi(client: getIt()));

  getIt.registerLazySingleton<DetailsProductApi>(
      () => DetailsProductApi(client: getIt()));

  getIt.registerLazySingleton<SearchForAllApi>(
      () => SearchForAllApi(client: getIt()));

  getIt.registerLazySingleton<ProfileApi>(() => ProfileApi(client: getIt()));

  getIt.registerLazySingleton<ProfileEditApi>(
      () => ProfileEditApi(client: getIt()));

  getIt.registerLazySingleton<ChangePasswordApi>(
    () => ChangePasswordApi(
      client: getIt(),
    ),
  );

  getIt.registerLazySingleton<AllReviewApi>(
    () => AllReviewApi(
      client: getIt(),
    ),
  );
  getIt.registerLazySingleton<ReviewAddApi>(
    () => ReviewAddApi(
      client: getIt(),
    ),
  );

  getIt.registerLazySingleton<AddProductCartApi>(
    () => AddProductCartApi(),
  );
  getIt.registerLazySingleton<GetCartApi>(
    () => GetCartApi(),
  );
  getIt.registerLazySingleton<GetTotalsApi>(
        () => GetTotalsApi(client:  getIt(),),
  );
  getIt.registerLazySingleton<VerifyEmailApi>(
    () => VerifyEmailApi(
      client: getIt(),
    ),
  );
  getIt.registerLazySingleton<ResendVerificationCodeApi>(
    () => ResendVerificationCodeApi(
      client: getIt(),
    ),
  );
  getIt.registerLazySingleton<CreateOrderApi>(
    () => CreateOrderApi(
      client: getIt(),
    ),
  );
  getIt.registerLazySingleton<GetPaymentApi>(
    () => GetPaymentApi(
      client: getIt(),
    ),
  );

  getIt.registerLazySingleton<UpdateOrderApi>(
    () => UpdateOrderApi(
      client: getIt(),
    ),
  );
  getIt.registerLazySingleton<AllProductApi>(
    () => AllProductApi(
      client: getIt(),
    ),
  );
  getIt.registerLazySingleton<AddNewAddressApi>(
    () => AddNewAddressApi(
      client: getIt(),
    ),
  );
  getIt.registerLazySingleton<LocationApi>(
    () => LocationApi(
      client: getIt(),
    ),
  );

  getIt.registerLazySingleton<UpdataCartApi>(
    () => UpdataCartApi(),
  );
  getIt.registerLazySingleton<DeleteCartApi>(
    () => DeleteCartApi(),
  );

  Dio client = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      contentType: 'application/json',
      queryParameters: {
        "Username": "ck_23129b745a10c8a46a75c186596104351566cb78",
        "Password": "cs_d624488a855f1a891bea08e9b9d963a89cc51dfe",
      },
      headers: {
        "Accept": "application/json",
        "Authorization":
            "Basic Y2tfMjMxMjliNzQ1YTEwYzhhNDZhNzVjMTg2NTk2MTA0MzUxNTY2Y2I3ODpjc19kNjI0NDg4YTg1NWYxYTg5MWJlYTA4ZTliOWQ5NjNhODljYzUxZGZl",
        "Cookie":
            "wp-wpml_current_admin_language_d41d8cd98f00b204e9800998ecf8427e=ar; __cfduid=dd43fd44b574a5c1285320853a6bd0ca01619687479"
      },
    ),
  );

  getIt.registerLazySingleton<Dio>(() => client);
  getIt.registerLazySingleton(() => RegisterProvider());
  getIt.registerLazySingleton(() => HomeProvider());
  getIt.registerLazySingleton(() => DetailsProductsProvider());
  getIt.registerLazySingleton(() => ProfileProvider());
  getIt.registerLazySingleton(() => VerificationCodeProvider());
  getIt.registerLazySingleton(() => ReviewProvider());
  getIt.registerLazySingleton(() => AddCartProvider());
  getIt.registerLazySingleton(() => CreateOrderProvider());
  getIt.registerLazySingleton(() => LocationProvider());
}
