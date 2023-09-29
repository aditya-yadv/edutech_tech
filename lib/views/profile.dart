import 'package:edukit_tech/view_models/user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: Text(' User Profile'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.grey.shade300,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<UserViewModel>(context, listen: false).logoutUser();
                Navigator.of(context).pushReplacementNamed('signin');
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: Text(
                "Hi ${Provider.of<UserViewModel>(context).user!.name}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
            Text("Username:"),
            Text(
              Provider.of<UserViewModel>(context).user!.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(
              height: 20,
            ),
            Text("Location:"),
            Text(
              Provider.of<UserViewModel>(context).user!.location,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ],
        ),
      ),
      bottomSheet: SizedBox(
        width: double.infinity,
        child: TextButton(
          onPressed: () {
            Navigator.of(context).pushNamed('update');
          },
          child: Text('Edit location'),
        ),
      ),
    );
  }
}
