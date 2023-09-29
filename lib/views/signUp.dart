import 'package:edukit_tech/model/user.dart';
import 'package:edukit_tech/services/address_service.dart';
import 'package:edukit_tech/view_models/user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // controllers of text fields
  TextEditingController _locationController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _cpasswordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();

  AddressService service = new AddressService();
  bool readOnly = false;
  String initialvalue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: Text('Register User'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.grey.shade300,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formKey,
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
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextFormField(
                  controller: _usernameController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: 'Username'),
                ),
                TextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                TextFormField(
                  controller: _cpasswordController,
                  validator: (val) {
                    if (val != _passwordController.text) {
                      return 'Password do not match';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(labelText: 'Confirm Password'),
                  obscureText: true,
                ),
                TextFormField(
                  controller: _locationController,
                  validator: (value) {
                    if (!readOnly) {
                      return 'Plase select the location';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Enter pincode',
                    suffix: readOnly
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                readOnly = false;
                                _locationController.text = "";
                              });
                            },
                            icon: Icon(Icons.edit))
                        : IconButton(
                            iconSize: 18,
                            onPressed: () async {
                              var val = await service.fetchAddressByPinCode(
                                  _locationController.text);
                              if (val != null) {
                                setState(() {
                                  _locationController.text = val.toString();
                                  readOnly = true;
                                  _formKey.currentState!.validate();
                                });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text('Enter valid Pincode')));
                              }
                            },
                            icon: Icon(Icons.search_outlined)),
                  ),
                  readOnly: readOnly,
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        User user = User(
                            name: _nameController.text,
                            username: _usernameController.text,
                            location: _locationController.text,
                            password: _passwordController.text);
                        // register the user and store details lcoally
                        try {
                          await Provider.of<UserViewModel>(context,
                                  listen: false)
                              .storeUser(user);
                          print("${user.name} is registered");
                          Navigator.of(context).pushReplacementNamed('signin');
                        } catch (e) {
                          print(e);
                        }
                      }
                    },
                    child: Text('Register'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade800,
                        foregroundColor: Colors.white),
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
