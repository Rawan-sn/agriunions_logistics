import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/blocs/registerBloc.dart';
import 'package:agriunions_logistics/helper/AppColors.dart';
import 'package:agriunions_logistics/helper/TextSizes.dart';
import 'package:agriunions_logistics/user_interfaces/widget/custom_text_field.dart';

import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  FocusNode? _usernameFocusNode,
      _passwordFocusNode,
      _confirmPasswordFocusNode,
      _numberFocusNode,
      _emailFocusNode;
  late AnimationController _animationController;
  late Animation<double> _translateComponents;
  RegisterBloc _bloc = RegisterBloc();

  @override
  void initState() {
    super.initState();
    _usernameFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _confirmPasswordFocusNode = FocusNode();
    _numberFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
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
    _confirmPasswordFocusNode!.dispose();
    _numberFocusNode!.dispose();
    _emailFocusNode!.dispose();
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
                      AppLocalizations.of(context)!.trans("register")!,
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
                          MediaQuery.of(context).size.height / 2.5,
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
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 32.0),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 35.0),
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .trans("create_anew_account")!,
                                      style: TextStyle(
                                          fontSize: TextSizes.smallText,
                                          color: AppColors.Russet1),
                                    ),
                                  ),
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 23,
                                  ),
                                  CustomTextField(
                                    key: ValueKey(1),
                                    width:
                                        MediaQuery.of(context).size.width * 0.70,
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
                                    width:
                                        MediaQuery.of(context).size.width * 0.70,
                                    margin: EdgeInsets.only(top: 25),
                                    label: AppLocalizations.of(context)!
                                        .trans("password")!,
                                    onChanged: (enteredPassword) {
                                      _bloc.password = enteredPassword;
                                    },
                                    onTap: () {},
                                    onSubmitted: (enteredPassword) {
                                      FocusScope.of(context).requestFocus(
                                          _confirmPasswordFocusNode);
                                    },
                                    prefixIcon: Image.asset(
                                        'assets/icons/password.png',
                                        color: Colors.black45),
                                    focusNode: _passwordFocusNode,
                                    isPassword: true,
                                  ),
                                  CustomTextField(
                                    key: ValueKey(3),
                                    width:
                                        MediaQuery.of(context).size.width * 0.70,
                                    margin: EdgeInsets.only(top: 25),
                                    label: AppLocalizations.of(context)!
                                        .trans("confirm_password")!,
                                    onChanged: (enteredPassword) {
                                      _bloc.confirmPassword = enteredPassword;
                                    },
                                    onTap: () {},
                                    onSubmitted: (enteredPassword) {
                                      FocusScope.of(context)
                                          .requestFocus(_numberFocusNode);
                                    },
                                    prefixIcon: Image.asset(
                                        'assets/icons/confirmPassword.png',
                                        scale: 0.2,
                                        color: Colors.black45),
                                    focusNode: _confirmPasswordFocusNode,
                                    isPassword: true,
                                  ),
                                  CustomTextField(
                                    key: ValueKey(4),
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]'))
                                    ],
                                    keyboardType: TextInputType.number,
                                    width:
                                        MediaQuery.of(context).size.width * 0.70,
                                    margin: EdgeInsets.only(top: 25),
                                    label: AppLocalizations.of(context)!
                                        .trans("phone")!,
                                    onChanged: (enteredPhone) {
                                      _bloc.phoneNumber = enteredPhone;
                                    },
                                    onTap: () {},
                                    onSubmitted: (enteredPassword) {
                                      FocusScope.of(context)
                                          .requestFocus(_emailFocusNode);
                                    },
                                    prefixIcon:
                                        Icon(Icons.phone, color: Colors.black45),
                                    focusNode: _numberFocusNode,
                                    // isPassword: true,
                                  ),
                                  CustomTextField(
                                    key: ValueKey(5),
                                    width:
                                        MediaQuery.of(context).size.width * 0.70,
                                    margin: EdgeInsets.only(top: 25),
                                    label: AppLocalizations.of(context)!
                                        .trans("user@sample.com")!,
                                    onChanged: (enteredEmail) {
                                      _bloc.email = enteredEmail;
                                    },
                                    onTap: () {},
                                    onSubmitted: (enteredPassword) {},
                                    prefixIcon:
                                        Icon(Icons.mail, color: Colors.black45),
                                    focusNode: _emailFocusNode,
                                    isPassword: false,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 1.34,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () => _bloc.register(context),
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
                            AppLocalizations.of(context)!.trans("register")!,
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
                                .trans("if_you_have_an_account")! +
                            " ",
                        style: TextStyle(
                            fontSize: TextSizes.notice,
                            height: 1.7,
                            color: Colors.black),
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (context) {
                                  return LoginPage();
                                }));
                              },
                            text: AppLocalizations.of(context)!.trans("sign_in"),
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
