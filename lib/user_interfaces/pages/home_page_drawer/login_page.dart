import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/blocs/loginBloc.dart';
import 'package:agriunions_logistics/helper/AppColors.dart';
import 'package:agriunions_logistics/helper/TextSizes.dart';
import 'package:agriunions_logistics/user_interfaces/pages/home_page_drawer/register_page.dart';
import 'package:agriunions_logistics/user_interfaces/widget/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> with SingleTickerProviderStateMixin {
  FocusNode? _usernameFocusNode;
  FocusNode? _passwordFocusNode;
  late AnimationController _animationController;
  late Animation<double> _translateComponents;
  LoginBloc _bloc = LoginBloc();

  @override
  void initState() {
    super.initState();
    _usernameFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _animationController.forward();
    });
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
  }

  @override
  void dispose() {
    _usernameFocusNode!.dispose();
    _passwordFocusNode!.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _translateComponents =
        Tween(begin: MediaQuery.of(context).size.height, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.8,
                padding: const EdgeInsets.only(top: 55.0, left: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30)),
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [AppColors.darkRed, AppColors.Russet]),
                ),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      AppLocalizations.of(context)!.trans("login")!,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: TextSizes.title,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 6,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height -
                          MediaQuery.of(context).size.height / 2.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: kElevationToShadow[4],
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: AnimatedBuilder(
                        animation: _translateComponents,
                        builder: (context, child) {
                          return Container(
                            transform: Matrix4.identity()
                              ..translate(0.0, _translateComponents.value),
                            child: child,
                          );
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 35.0),
                              child: Text(
                                AppLocalizations.of(context)!
                                    .trans("login_with_exist_account")!,
                                style: TextStyle(
                                    fontSize: TextSizes.smallText,
                                    color: AppColors.Russet1),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 23,
                            ),
                            CustomTextField(
                              key: ValueKey(1),
                              width: MediaQuery.of(context).size.width * 0.70,
                              margin: EdgeInsets.only(top: 16),
                              label: AppLocalizations.of(context)!
                                  .trans("username")!,
                              keyboardType: TextInputType.name,
                              onChanged: (enteredUsername) {
                                _bloc.username = enteredUsername;
                              },
                              onSubmitted: (enteredUsername) {
                                FocusScope.of(context)
                                    .requestFocus(_passwordFocusNode);
                              },
                              onTap: () {},
                              focusNode: _usernameFocusNode,
                              prefixIcon: Image.asset(
                                'assets/icons/username.png',
                                color: Colors.black45,
                              ),
                            ),
                            CustomTextField(
                              key: ValueKey(2),
                              width: MediaQuery.of(context).size.width * 0.70,
                              margin: EdgeInsets.only(top: 25),
                              label: AppLocalizations.of(context)!
                                  .trans("password")!,
                              onChanged: (enteredPassword) {
                                _bloc.password = enteredPassword;
                              },
                              onTap: () {},
                              onSubmitted: (enteredPassword) {},
                              prefixIcon: Image.asset(
                                  'assets/icons/password.png',
                                  color: Colors.black45),
                              focusNode: _passwordFocusNode,
                              isPassword: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 1.55,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () => _bloc.login(context),
                      child: Container(
                        margin: EdgeInsets.only(top: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white, width: 1.5),
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [AppColors.Russet1, AppColors.Russet]),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            AppLocalizations.of(context)!.trans("login")!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: TextSizes.smallText,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: AppLocalizations.of(context)!
                                .trans("if_you_do_not_have_an_account")! +
                            " ",
                        style: TextStyle(
                            fontSize: TextSizes.notice,
                            height: 1.7,
                            color: Colors.black),
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                  builder: (context) => RegisterPage(),
                                ));
                              },
                            text: AppLocalizations.of(context)!.trans('sign_up'),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.Russet1),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
