import 'package:TaskPulse/const/colors.dart';
import 'package:TaskPulse/data/auth_data.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback show;
  const LoginPage(this.show, {super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();

  final email = TextEditingController();
  final password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool obsecurePassword = true;

  @override
  void initState() {
    super.initState();
    _focusNode1.addListener(() {
      setState(() {});
    });
    _focusNode2.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [custom_purple, Colors.white, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: height * 0.04,
                      ),
                      image(),
                      SizedBox(
                        height: height * 0.08,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            textfield(email, _focusNode1, "Email", Icons.email,
                                emailValidator, false, false),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            textfield(
                                password,
                                _focusNode2,
                                "Password",
                                Icons.lock,
                                passwordValidator,
                                obsecurePassword,
                                true),
                            SizedBox(height: height * 0.015),
                            reset_password(),
                            SizedBox(height: height * 0.08),
                            Login_bottom(),
                            SizedBox(height: height * 0.015),
                            account(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget reset_password() {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () async {
              if (email.text.isNotEmpty) {
                String message =
                    await AuthenticationRemote().resetPassword(email.text);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(message)),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content:
                          Text('Please enter your email to reset password.')),
                );
              }
            },
            child: Text(
              'Reset Password',
              style: TextStyle(
                  color: custom_purple,
                  fontSize: width * 0.034,
                  fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }

  Widget account() {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don't have an account?",
            style: TextStyle(color: Colors.grey[700], fontSize: width * 0.035),
          ),
          SizedBox(width: width * 0.01),
          GestureDetector(
            onTap: widget.show,
            child: Text(
              'Sign Up',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: width * 0.035,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  Widget Login_bottom() {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.035),
      child: GestureDetector(
        onTap: () async {
          if (_formKey.currentState!.validate()) {
            String message =
                await AuthenticationRemote().login(email.text, password.text);
            if (message == 'Login Successful!') {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: custom_purple,
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }
        },
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: height * 0.065,
          decoration: BoxDecoration(
            color: custom_purple,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            'Login',
            style: TextStyle(
              color: Colors.white,
              fontSize: height * 0.026,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget textfield(
      TextEditingController controller,
      FocusNode focusNode,
      String hinttext,
      IconData icon,
      String? Function(String?) validator,
      bool obsecure,
      bool obs) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.035),
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: TextFormField(
          obscureText: obsecure,
          controller: controller,
          validator: validator,
          focusNode: focusNode,
          style: TextStyle(
            fontSize: width * 0.034,
            color: Colors.black,
          ),
          decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                color: focusNode.hasFocus
                    ? custom_purple
                    : const Color(0xFF848484),
              ),
              contentPadding: EdgeInsets.symmetric(
                  horizontal: width * 0.035, vertical: width * 0.035),
              hintText: hinttext,
              hintStyle: const TextStyle(fontWeight: FontWeight.w400),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: Color(0xffc5c5c5),
                  width: 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: custom_purple,
                  width: 1.0,
                ),
              ),
              suffixIcon: obs
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          obsecurePassword = !obsecurePassword;
                        });
                      },
                      child: Icon(
                        obsecurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: const Color(0xFF848484),
                        size: width * 0.044,
                      ),
                    )
                  : null),
        ),
      ),
    );
  }

  Widget image() {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.035),
      child: Container(
        width: double.infinity,
        height: height * 0.4,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/login.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }
}
