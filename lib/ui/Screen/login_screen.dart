import 'package:ecommerce/providers/register_provider.dart';
import 'package:ecommerce/ui/Screen/forgotpassword/enter_email_screen.dart';
import 'package:ecommerce/ui/Screen/home_application.dart';
import 'package:ecommerce/ui/Screen/registers_screen.dart';
import 'package:ecommerce/ui/widget/custom_button_widget.dart';
import 'package:ecommerce/ui/widget/custom_text_field.dart';
import 'package:ecommerce/ui/widget/custom_text_widget.dart';
import 'package:ecommerce/utilities/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../get_it.dart';
import 'package:ecommerce/utilities/custom_dialog.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'LoginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: getIt<RegisterProvider>().scaffoldKey,
      body:  SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           /* Container(
              width: double.infinity,
              height: 24.5.h,
              padding:
                  EdgeInsets.only(right: 15, left: 15, top: 15, bottom: 5),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                  bottomRight: const Radius.circular(35),
                  bottomLeft: const Radius.circular(35),
                ),
              ),
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, RegisterScreen.id);
                    },
                    trailing: Text(
                      'SIGN UP',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 2.0.h),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sign in',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 1.5.h),
                        Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit.\nInteger maximus accumsan erat id facilisis.',
                          style: TextStyle(
                              color: Colors.white, fontSize: 9.0.sp),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),*/
         SizedBox(height:5.0.h),
              Container(
                height:44.0.h,
              width: 60.0.w,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitHeight,
                  image: AssetImage('assets/images/logoo.png',),
                ),
              ),
            ),

           SizedBox(height: 2.0.h),
            CustomTextField(
              keyboardType: TextInputType.emailAddress,
              hintText: 'الإيميل',
              textEditingController:
                  getIt<RegisterProvider>().emailController,
            ),
            CustomTextField(
              keyboardType: TextInputType.visiblePassword,
              hintText: 'كلمة السر',
              textEditingController:
                  getIt<RegisterProvider>().passwordController,
              password: true,
            ),
            SizedBox(height: 0.5.h),
            ListTile(
              onTap: () {
                Navigator.pushReplacementNamed(context, EnterEmailScreen.id);
              },
              trailing: CustomTextWidget(
                title: ('هل نسيت كلمة السر؟'),
                paddingLeft: 40,
                paddingRight: 15,
                size: 10.0.sp,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),

              //Text('Forgot password?',style: TextStyle(color: Colors.red),),
            ),
            SizedBox(height:1.0.h),

            Consumer<RegisterProvider>(
              builder: (context, value, child) => CustomButtonWidget(
                title: ('تسجيل دخول'),
                color: kPrimaryColor,
                loading: value.logInLoading,

                onClick: () {
 
                  value.login();
                  //Navigator.pushNamed(context, HomeScreen.id);
                },
              ),
            ),
         SizedBox(height: 4.0.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(context, HomeApplication.id,(route) => false);
                  },
                  child: Text(' تسجيل دخول كزائر',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0.sp)),
                ),
                Text('  /  ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xff7A8D9C),
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0.sp)),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, RegisterScreen.id);
                  },
                  child: Text(
                    '   انشاء حساب',
                    style: TextStyle(
                        color: kBlueColor,
                        fontSize: 15.0.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.0.h),
          ],
        ),
      ),
    );
  }
/*     SizedBox(height: 6.0.h),
              Container(
                height: 60,
                width: double.infinity,
                padding: EdgeInsets.only(right: 15, left: 15),
                margin: EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                  color: Color(0xffF6F6F7),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ListTile(
                  title: Text('CONTINUE WITH GOOGLE',
                      style: TextStyle(
                          color: Color(0xff57636F),
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0.sp)),
                  onTap: () => null,
                  leading: ImageIcon(
                    AssetImage("assets/images/google logo.png"),
                  ),
                ),
              ),
              SizedBox(height: 5.0.h),
              Container(
                height: 60,
                width: double.infinity,
                padding: EdgeInsets.only(right: 15, left: 15),
                margin: EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                  color: kMainColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ListTile(
                  title: Text('CONTINUE WITH FACEBOOK',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 11.0.sp,
                          fontWeight: FontWeight.bold)),
                  onTap: () async {
                    //  await signInWithFacebook();
                  },
                  leading: ImageIcon(
                    AssetImage("assets/images/Facebook Logo.png"),
                    color: Colors.white,
                  ),
                ),
              ),*/
/*  Future<UserCredential> signInWithGoogle() async {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    final GoogleAuthCredential authCredential= GoogleAuthProvider.credential(idToken: googleSignInAuthentication.idToken, accessToken: googleSignInAuthentication.accessToken);
    return await FirebaseAuth.instance.signInWithCredential(authCredential);


   // AuthResult  authResult = await _auth.signInWithCredential(authCredential );
   //  FirebaseAuth  user = await authResult.user;
    //print('user email = ${user.currentUser.email}');

  }

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final AccessToken result = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final FacebookAuthCredential facebookAuthCredential =
    FacebookAuthProvider.credential(result.token);

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }*/

// Widget _buildBody() {
//   if (_currentUser != null) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisSize: MainAxisSize.max,
//       children: <Widget>[
//         ListTile(
//           leading: GoogleUserCircleAvatar(
//             identity: _currentUser,
//           ),
//           title: Text(_currentUser.displayName ?? ''),
//           subtitle: Text(_currentUser.email ?? ''),
//         ),
//         RaisedButton(
//           onPressed: _handleSignOut,
//           child: Text('SIGN OUT'),
//         )
//       ],
//     );
//   }
//   else{
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisSize: MainAxisSize.max,
//       children: <Widget>[
//         Text('You are not signed in..'),
//         RaisedButton(
//           onPressed: _handleSignIn,
//           child: Text('SIGN IN'),
//         )
//       ],
//     );
//   }
// }
// Future<void> _handleSignIn() async{
//   try{
//     await _googleSignIn.signIn();
//   }catch(error){
//     print(error);
//   }
// }
//
// Future<void> _handleSignOut() async{
//   _googleSignIn.disconnect();
// }

}
