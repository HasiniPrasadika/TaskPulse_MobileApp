import 'package:TaskPulse/const/colors.dart';
import 'package:TaskPulse/data/auth_data.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  final VoidCallback show;
  const SignupPage(this.show, {super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();

  final email = TextEditingController();
  final password = TextEditingController();
  final confirmpassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool obsecurePassword_1 = true;
  bool obsecurePassword_2 = true;

  @override
  void initState() {
    super.initState();
    _focusNode1.addListener(() {
      setState(() {});
    });
    super.initState();
    _focusNode2.addListener(() {
      setState(() {});
    });
    super.initState();
    _focusNode3.addListener(() {
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
        backgroundColor: backgroundColors,
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
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          SizedBox(
                            height: height * 0.04,
                          ),
                          textfield(email, _focusNode1, "Email", Icons.email,
                              emailValidator, false, false, '3'),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          textfield(
                            password,
                            _focusNode2,
                            "Password",
                            Icons.lock,
                            passwordValidator,
                            obsecurePassword_1,
                            true,
                            '1',
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          textfield(
                              confirmpassword,
                              _focusNode3,
                              "Confirm Password",
                              Icons.lock,
                              confirmPasswordValidator,
                              obsecurePassword_2,
                              true,
                              '2'),
                          SizedBox(height: height * 0.08),
                          Signup_bottom(),
                          SizedBox(height: height * 0.015),
                          account(),
                          SizedBox(
                            height: height * 0.08,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
        ),
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
            "You have an account?",
            style: TextStyle(color: Colors.grey[700], fontSize: width * 0.035),
          ),
          SizedBox(width: width * 0.01),
          GestureDetector(
            onTap: widget.show,
            child: Text(
              'Login',
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

  Widget Signup_bottom() {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.035),
      child: GestureDetector(
        onTap: () async {
          if (_formKey.currentState!.validate()) {
            String message = await AuthenticationRemote()
                .register(email.text, password.text, confirmpassword.text);
            if (message == 'Registration Successful!') {
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
            'Sign Up',
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
      bool obs,
      String type) {
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
                        type == '1'
                            ? setState(() {
                                obsecurePassword_1 = !obsecurePassword_1;
                              })
                            : type == '2'
                                ? setState(() {
                                    obsecurePassword_2 = !obsecurePassword_2;
                                  })
                                : null;
                      },
                      child: Icon(
                        type == '1'
                            ? obsecurePassword_1
                                ? Icons.visibility
                                : Icons.visibility_off
                            : type == '2'
                                ? obsecurePassword_2
                                    ? Icons.visibility
                                    : Icons.visibility_off
                                : null,
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
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  String? confirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != password.text) {
      return 'Passwords do not match';
    }

    return null;
  }
}
