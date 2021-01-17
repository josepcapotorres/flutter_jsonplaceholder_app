import 'package:flutter/material.dart';
import 'package:jsonplaceholder_app/helpers/crypto_helper.dart';
import 'package:jsonplaceholder_app/helpers/format_helper.dart';
import 'package:jsonplaceholder_app/interfaces/ILogeable.dart';
import 'package:jsonplaceholder_app/providers/login/custom_login.dart';
import 'package:jsonplaceholder_app/providers/login/facebook_login.dart';
import 'package:jsonplaceholder_app/providers/login/google_login.dart';
import 'package:jsonplaceholder_app/shared_prefs/user_preferences.dart';
import 'package:jsonplaceholder_app/views/users_view.dart';
import 'package:jsonplaceholder_app/widgets/custom_appbar.dart';
import 'package:jsonplaceholder_app/widgets/custom_button.dart';
import 'package:jsonplaceholder_app/widgets/custom_text_form_field.dart';
import 'package:jsonplaceholder_app/widgets/custom_toast.dart';

class LoginView extends StatefulWidget {
  static const routeName = "login_view";

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String _email = "";
  String _password = "";
  final _userPrefs = UserPreferences();
  final _formKey = GlobalKey<FormState>();
  ILoggeable _iLoggeable;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Login",
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 20),
            children: [
              CustomTextFormField(
                keyboardType: TextInputType.emailAddress,
                hint: "Email",
                validator: (val) {
                  if (val.isEmpty)
                    return "Field cannot be empty";
                  else if (!FormatHelper.checkEmailFormat(val))
                    return "Field must be an email format";
                  else
                    return null;
                },
                onSaved: (val) {
                  _email = val;
                },
              ),
              CustomTextFormField(
                hint: "Password",
                obscureText: true,
                validator: (val) {
                  if (val.isEmpty)
                    return "Field cannot be empty";
                  else
                    return null;
                },
                onSaved: (val) {
                  _password = CryptoHelper.encryptPassword(val);
                },
              ),
              SizedBox(height: 15),
              CustomButton(
                text: "Custom login",
                onPressed: () {
                  _iLoggeable = CustomLogin();
                  _validateLogin(context);
                },
              ),
              SizedBox(height: 30),
              _FacebookLoginBtn(
                userPrefs: _userPrefs,
                onPressed: () {
                  _iLoggeable = FacebookLogin();
                  _validateLogin(context);
                },
              ),
              SizedBox(height: 10),
              _GoogleLoginBtn(
                userPrefs: _userPrefs,
                onPressed: () {
                  _iLoggeable = GoogleLogin();
                  _validateLogin(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _validateLogin(BuildContext context) async {
    final formState = _formKey.currentState;

    if (formState.validate()) {
      formState.save();

      final loginResult = await _iLoggeable.login(_email, _password);

      if (loginResult) {
        _userPrefs.userLogged = true;
        Navigator.pushReplacementNamed(context, UsersView.routeName);
      } else {
        _userPrefs.userLogged = false;
        CustomToast("Wrong email or password");
      }
    }
  }
}

class _FacebookLoginBtn extends StatelessWidget {
  final UserPreferences userPrefs;
  final VoidCallback onPressed;

  _FacebookLoginBtn({@required this.userPrefs, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        //width: 20,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset("assets/facebook_login.png"),
        ),
      ),
      onTap: onPressed,
    );
  }
}

class _GoogleLoginBtn extends StatelessWidget {
  final UserPreferences userPrefs;
  final VoidCallback onPressed;

  _GoogleLoginBtn({@required this.userPrefs, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: ClipRRect(
          child: Image.asset("assets/google_login.png"),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onTap: onPressed,
    );
  }
}
