import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_loader.dart';
import 'package:amazon_clone/common/widgets/custom_text_field.dart';
import 'package:amazon_clone/constants/enums.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/auth/services/auth_services.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';

  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signIn;
  final _signInFormKey = GlobalKey<FormState>();
  final _signUpFormKey = GlobalKey<FormState>();
  final AuthServices authServices = AuthServices();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _signUpEmailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _signUpPasswordController =
      TextEditingController();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _signUpNameController = TextEditingController();

  bool isVisible = true;
  bool isLoading = false;
  IconData icon = Icons.visibility_off;

  @override
  void dispose() {
    super.dispose();
    _signUpEmailController.dispose();
    _signUpPasswordController.dispose();
    _signUpNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  void signUpUser() {
    authServices.signUpUser(
      context: context,
      email: _signUpEmailController.text,
      password: _signUpPasswordController.text,
      name: _signUpNameController.text,
    );
  }

  void signInUser() {
    authServices.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  //! Toggle between Password Visibility
  void togglePasswordVisibility() {
    setState(() {
      isVisible = !isVisible;
      icon = isVisible ? Icons.visibility_off : Icons.visibility;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: GlobalVariables.greyBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Welcome',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                ),
                ListTile(
                  tileColor: _auth == Auth.signUp
                      ? GlobalVariables.backgroundColor
                      : GlobalVariables.greyBackgroundColor,
                  title: const Text(
                    'Create Account',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  leading: Radio(
                    activeColor: GlobalVariables.secondaryColor,
                    value: Auth.signUp,
                    groupValue: _auth,
                    onChanged: (Auth? val) {
                      setState(
                        () {
                          _auth = val!;
                        },
                      );
                    },
                  ),
                ),
                //! Sign Up
                if (_auth == Auth.signUp)
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: GlobalVariables.backgroundColor,
                    child: Form(
                      key: _signUpFormKey,
                      child: Column(
                        children: [
                          //! Full Name
                          CustomTextFormField(
                            hintText: 'Full Name',
                            controller: _signUpNameController,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          //! E-mail
                          CustomTextFormField(
                            hintText: 'Email',
                            controller: _signUpEmailController,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          //! Password
                          CustomTextFormField(
                            hintText: 'Password',
                            controller: _signUpPasswordController,
                            icon: icon,
                            obscureText: isVisible,
                            onChangeVisibilityPress: togglePasswordVisibility,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          isLoading == true
                              ? const CustomLoader()
                              : CustomButton(
                                  text: 'Sign-Up',
                                  onTap: () {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    if (_signUpFormKey.currentState!
                                        .validate()) {
                                      signUpUser();
                                    }
                                    setState(() {
                                      isLoading = false;
                                    });
                                  },
                                ),
                        ],
                      ),
                    ),
                  ),
                ListTile(
                  tileColor: _auth == Auth.signIn
                      ? GlobalVariables.backgroundColor
                      : GlobalVariables.greyBackgroundColor,
                  title: const Text(
                    'Sign-In',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  leading: Radio(
                    activeColor: GlobalVariables.secondaryColor,
                    value: Auth.signIn,
                    groupValue: _auth,
                    onChanged: (Auth? val) {
                      setState(
                        () {
                          _auth = val!;
                        },
                      );
                    },
                  ),
                ),
                //! Sign IN
                if (_auth == Auth.signIn)
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: GlobalVariables.backgroundColor,
                    child: Form(
                      key: _signInFormKey,
                      child: Column(
                        children: [
                          CustomTextFormField(
                            hintText: 'Email',
                            controller: _emailController,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextFormField(
                            hintText: 'Password',
                            controller: _passwordController,
                            icon: icon,
                            obscureText: isVisible,
                            onChangeVisibilityPress: togglePasswordVisibility,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          isLoading == true
                              ? const CustomLoader()
                              : CustomButton(
                                  text: 'Sign-In',
                                  onTap: () {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    if (_signInFormKey.currentState!
                                        .validate()) {
                                      signInUser();
                                    }
                                    setState(() {
                                      isLoading = false;
                                    });
                                  },
                                ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
