import 'package:dawnsapp/Services/Constants/constant_colors.dart';
import 'package:dawnsapp/Services/signup_service.dart';
import 'package:dawnsapp/Views/Auth/sign_in.dart';
import 'package:dawnsapp/Views/Layouts/custom_input.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool checkedValue = false;

  String dropdownValue = 'Select Account Type';
  late bool _passwordVisible;
  late bool _confirmpasswordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    _confirmpasswordVisible = false;
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Listener(
        onPointerDown: (_) {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.focusedChild?.unfocus();
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(26.0),
            child: Column(
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    //Sign up text
                    Text(
                      "Sign Up",
                      style: TextStyle(
                          color: ConstantColors().greyPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 27),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    //name
                    CustomInput(
                      controller: nameController,
                      hintText: "Your Name",
                      onChanged: (value) {},
                      onSubmitted: (value) {},
                      textInputAction: TextInputAction.next,
                    ),

                    //Email
                    CustomInput(
                      controller: emailController,
                      hintText: "Email",
                      onChanged: (value) {},
                      onSubmitted: (value) {},
                      textInputAction: TextInputAction.next,
                    ),

                    //Phone
                    CustomInput(
                      controller: mobileController,
                      hintText: "Phone",
                      onChanged: (value) {},
                      onSubmitted: (value) {},
                      textInputAction: TextInputAction.next,
                      isNumberField: true,
                    ),

                    //Address
                    CustomInput(
                      controller: addressController,
                      hintText: "Address",
                      onChanged: (value) {},
                      onSubmitted: (value) {},
                      textInputAction: TextInputAction.next,
                    ),

                    //password
                    Container(
                        margin: const EdgeInsets.only(bottom: 19),
                        padding: const EdgeInsets.only(left: 12),
                        decoration: BoxDecoration(
                            color: const Color(0xfff2f2f2),
                            borderRadius: BorderRadius.circular(50)),
                        child: TextField(
                          controller: passwordController,
                          textInputAction: TextInputAction.next,
                          obscureText: !_passwordVisible,
                          style: const TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Password',
                              suffixIcon: IconButton(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: ConstantColors().greyPrimary,
                                  size: 20,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 13, vertical: 13)),
                        )),

                    //Confirm password
                    Container(
                        margin: const EdgeInsets.only(bottom: 19),
                        padding: const EdgeInsets.only(left: 12),
                        decoration: BoxDecoration(
                            color: const Color(0xfff2f2f2),
                            borderRadius: BorderRadius.circular(50)),
                        child: TextField(
                          controller: confirmPassController,
                          textInputAction: TextInputAction.next,
                          obscureText: !_confirmpasswordVisible,
                          style: const TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Password',
                              suffixIcon: IconButton(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _confirmpasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: ConstantColors().greyPrimary,
                                  size: 20,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    _confirmpasswordVisible =
                                        !_confirmpasswordVisible;
                                  });
                                },
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 13, vertical: 13)),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Material(
                  child: InkWell(
                    onTap: () {
                      if (Provider.of<SignUpService>(context, listen: false)
                              .isloading ==
                          false) {
                        SignUpService().register(
                            nameController.text,
                            emailController.text,
                            passwordController.text,
                            confirmPassController.text,
                            mobileController.text,
                            addressController.text,
                            false, //not sigining up from order page
                            context);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: ConstantColors().primaryColor,
                          borderRadius: BorderRadius.circular(50)),
                      alignment: Alignment.center,
                      height: 50,
                      width: double.infinity,
                      child: Provider.of<SignUpService>(context, listen: true)
                                  .isloading ==
                              false
                          ? const Text(
                              "Register",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            )
                          : const SpinKitThreeBounce(
                              color: Colors.white,
                              size: 20.0,
                            ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 22,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Already have account?  ',
                    style:
                        const TextStyle(color: Color(0xff646464), fontSize: 15),
                    children: <TextSpan>[
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignInPage()));
                            },
                          text: 'Login',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ConstantColors().primaryColor)),
                    ],
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
