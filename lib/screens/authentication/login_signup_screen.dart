import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:moviemate/services/user_provider.dart';

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({super.key});

  @override
  State<LoginSignupScreen> createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  bool isLogin = true;

  bool _emailValidate = false;
  bool _usernameValidate = false;
  bool _passValidate = false;
  String _emailErrorMessage = "An email address must be provided";
  String _usernameErrorMessage = "A username must be provided";
  String _passwordErrorMessage = "A password must be provided";
  String? _generalErrorMessage;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(isLogin ? 'Login' : 'Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (!isLogin)
              TextField(
                controller: _userNameController,
                decoration: InputDecoration(
                  labelText: 'User Name',
                  errorText: _usernameValidate ? _usernameErrorMessage : null,
                ),
              ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                errorText: _emailValidate ? _emailErrorMessage : null,
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                errorText: _passValidate ? _passwordErrorMessage : null,
              ),
              obscureText: true,
            ),
            if (_generalErrorMessage != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  _generalErrorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  _emailValidate = _emailController.text.isEmpty;
                  _usernameValidate = !isLogin && _userNameController.text.isEmpty;
                  _passValidate = _passwordController.text.isEmpty;
                  _generalErrorMessage = null;
                });

                if (_emailValidate || _usernameValidate || _passValidate) {
                  return;
                }

                try {
                  if (isLogin) {
                    await userProvider.signIn(_emailController.text, _passwordController.text);
                  } else {
                    await userProvider.register(
                      _emailController.text,
                      _passwordController.text,
                      _userNameController.text,
                    );
                  }
                } catch (e) {
                  setState(() {
                    _generalErrorMessage = e.toString();
                  });
                }
              },
              child: Text(isLogin ? 'Login' : 'Sign Up'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  isLogin = !isLogin;
                  _generalErrorMessage = null;
                });
              },
              child: Text(isLogin
                  ? 'Don\'t have an account? Sign Up'
                  : 'Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }
}
