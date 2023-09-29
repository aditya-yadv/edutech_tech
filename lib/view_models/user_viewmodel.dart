import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "../model/user.dart";

class UserViewModel extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  Future<bool> validateCredentials(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final storedUsername = prefs.getString('username');
    final storedPassword = prefs.getString('password');

    // Check if stored credentials match the input
    return (storedUsername == username && storedPassword == password);
  }

  Future<void> storeUser(User user) async {
    // Save user data to local storage
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('name', user.name);
    prefs.setString('username', user.username);
    prefs.setString('password', user.password);
    prefs.setString('location', user.location);

    _user = user;

    notifyListeners();
  }

  Future<void> updateLocation(String location) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('location', location);
    user!.location = location;

    _user = user;

    notifyListeners();
  }

  Future<void> logoutUser() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('location', 'Update Location');
    user!.location = "Update Location";

    _user = user;
    notifyListeners();
  }
}
