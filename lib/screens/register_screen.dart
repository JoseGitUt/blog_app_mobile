import 'package:blog_app_mobile/constants.dart';
import 'package:blog_app_mobile/models/api_response.dart';
import 'package:blog_app_mobile/models/user.dart';
import 'package:blog_app_mobile/screens/home_screen.dart';
import 'package:blog_app_mobile/screens/login_screen.dart';
import 'package:blog_app_mobile/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool loading = false;
  TextEditingController nameController = TextEditingController(),
      emailController = TextEditingController(),
      passwordController = TextEditingController(),
      passwordConfirmController = TextEditingController();

void _registerUser() async {
  setState(() {
    loading = true; // Mostrar indicador de carga
  });

  ApiResponse response = await register(
    nameController.text,
    emailController.text,
    passwordController.text,
    passwordConfirmController.text, 
  );

  setState(() {
    loading = false; // Ocultar indicador de carga
  });

  if (response.error == null) {
    _saveAndRedirectToHome(response.data as User);
  } else {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('${response.error}')));
  }
}

  // Save and redirect to home
  void _saveAndRedirectToHome(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('userId', user.id ?? 0);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
          children: [
            TextFormField(
                controller: nameController,
                validator: (val) => val!.isEmpty ? 'Invalid name' : null,
                decoration: kInputDecoration('Name')),
            SizedBox(
              height: 20,
            ),
            TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (val) =>
                    val!.isEmpty ? 'Invalid email address' : null,
                decoration: kInputDecoration('Email')),
            SizedBox(
              height: 20,
            ),
            TextFormField(
                controller: passwordController,
                obscureText: true,
                validator: (val) =>
                    val!.length < 6 ? 'Required at least 6 chars' : null,
                decoration: kInputDecoration('Password')),
            SizedBox(
              height: 20,
            ),
            TextFormField(
                controller: passwordConfirmController,
                obscureText: true,
                validator: (val) => val != passwordController.text
                    ? 'Confirm password does not match'
                    : null,
                decoration: kInputDecoration('Confirm password')),
            SizedBox(
              height: 20,
            ),
            loading
                ? Center(child: CircularProgressIndicator())
                : kTextButton(
                    'Register',
                    () {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          loading = !loading;
                          _registerUser();
                        });
                      }
                    },
                  ),
            SizedBox(
              height: 20,
            ),
            kLoginRegisterHint('Already have an account? ', 'Login', () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false);
            })
          ],
        ),
      ),
    );
  }
}
