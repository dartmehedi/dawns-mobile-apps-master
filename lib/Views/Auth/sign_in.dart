import 'package:dawnsapp/Services/Constants/constant_colors.dart';
import 'package:dawnsapp/Services/login_service.dart';
import 'package:dawnsapp/Views/Auth/sign_up.dart';
import 'package:dawnsapp/Views/Layouts/custom_input.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool checkedValue = false;

  String dropdownValue = 'Select Account Type';
  late bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstantColors().primaryColor,
      body: Listener(
        onPointerDown: (_) {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.focusedChild?.unfocus();
          }
        },
        child: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              margin: const EdgeInsets.only(right: 0, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Login text
                  Container(
                    margin: const EdgeInsets.only(left: 30),
                    child: Column(
                      children: [
                        //logo image
                        Container(
                          height: 70,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/logo.png'),
                                  fit: BoxFit.fitHeight)),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                      ),
                      color: Colors.white,
                    ),
                    height: MediaQuery.of(context).size.height - 155,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(25, 35, 25, 55),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Text(
                                "Sign In",
                                style: TextStyle(
                                    color: ConstantColors().greyPrimary,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold),
                              ),

                              const SizedBox(
                                height: 33,
                              ),

                              //Email
                              CustomInput(
                                controller: emailController,
                                hintText: "Email",
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
                                              _passwordVisible =
                                                  !_passwordVisible;
                                            });
                                          },
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
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
                                if (Provider.of<LoginService>(context,
                                            listen: false)
                                        .isloading ==
                                    false) {
                                  LoginService().login(emailController.text,
                                      passwordController.text, false, context);
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: ConstantColors().primaryColor,
                                    borderRadius: BorderRadius.circular(50)),
                                alignment: Alignment.center,
                                height: 50,
                                width: double.infinity,
                                child: Provider.of<LoginService>(context,
                                                listen: true)
                                            .isloading ==
                                        false
                                    ? const Text(
                                        "Login",
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
                              text: 'Don\'t have account?  ',
                              style: const TextStyle(
                                  color: Color(0xff646464), fontSize: 15),
                              children: <TextSpan>[
                                TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const SignUpPage()));
                                      },
                                    text: 'Register',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: ConstantColors().primaryColor,
                                    )),
                              ],
                            ),
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
      ),
    );
  }
}
