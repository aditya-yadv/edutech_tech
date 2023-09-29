import 'package:edukit_tech/view_models/user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool obscureText = true;

  // textfeild controllers
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.grey.shade300,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                Icon(
                  Icons.people_alt_outlined,
                  size: 120,
                ),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(labelText: 'Username'),
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      suffix: IconButton(
                          onPressed: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                          icon: Icon(obscureText
                              ? Icons.visibility_off
                              : Icons.visibility))),
                  obscureText: obscureText,
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () async {
                      bool isvalid = await Provider.of<UserViewModel>(context,
                              listen: false)
                          .validateCredentials(_usernameController.text,
                              _passwordController.text);
                      if (isvalid) {
                        Navigator.of(context).pushReplacementNamed('profile');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: Text('Inalid credentials')));
                      }
                    },
                    child: Text('Login'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade800,
                        foregroundColor: Colors.white),
                  ),
                ),
                Container(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('signup');
                    },
                    child: Text('Register'),
                  ),
                ),
                SizedBox(
                  height: 40,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
