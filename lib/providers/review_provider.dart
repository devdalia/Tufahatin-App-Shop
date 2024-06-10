import 'package:ecommerce/api/get_review_api.dart';
import 'package:ecommerce/api/review_api.dart';
import 'package:ecommerce/helpers/internet_helper.dart';
import 'package:ecommerce/model/review_model.dart';
import 'package:ecommerce/utilities/custom_dialog.dart';
import 'package:flutter/material.dart';

import '../get_it.dart';

class ReviewProvider extends ChangeNotifier {
  GlobalKey<ScaffoldState> ?review = GlobalKey<ScaffoldState>();
  TextEditingController nameReview = TextEditingController();
  TextEditingController emailReview = TextEditingController();
  TextEditingController addReviewController = TextEditingController();

  int? rating;
  int ?id; //

  bool reviewloading = false;
  bool error = false;
  bool noInternet = false;

  ReviewModel ?_reviewModel;

  ReviewModel ?get reviewModel => _reviewModel;

  void getReviewdata() async {
    reviewloading = true;
    bool isinternet = await isInternet;
    if (isinternet) {
      print('start getting Review');
      getIt<AllReviewApi>().getReviewData(id!).then((value) {
        if (value != null) {
          error = false;
          noInternet = false;
          reviewloading = false;
          notifyListeners();
          _reviewModel = value;
          print('done getting');
        } else {
          error = true;
          noInternet = false;
          reviewloading = false;
          notifyListeners();
        }
      });
    } else {
      errorDialog(
          message: ('There_no_internet_connection'),
          context: review!.currentContext!);
    }
  }

  void addReview() async {
    bool isinternet = await isInternet;
    if (isinternet) {
      reviewloading = true;
      getIt<ReviewAddApi>().ReviewData(data: {
        nameReview.text.isEmpty ? "" : "reviewer": "${nameReview.text}",
        emailReview.text.isEmpty ? "" : "reviewer_email": "${emailReview.text}",
        addReviewController.text.isEmpty ? "" : "review":
            "${addReviewController.text}",
        "rating": rating,
        "product_id": id,
      }).then((value) {
        if (value != null) {
          reviewloading = false;
          getReviewdata();
          notifyListeners();
          successfulDialog(
            message: 'edit Done',
            context: review!.currentContext!,
            functionOk: () => Navigator.pop(review!.currentContext!),
          );
        } else {
          reviewloading = false;
          print('error');
          notifyListeners();
          errorDialog(
              message: ('There_no_internet_connection'),
              context: review!.currentContext!);
        }
      });
    } else {
      errorDialog(
          message: ('There_no_internet_connection'),
          context: review!.currentContext!);
    }
  }
}
