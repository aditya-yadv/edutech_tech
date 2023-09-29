import 'dart:convert';
import 'package:http/http.dart' as http;

class AddressService {
  Future<String?> fetchAddressByPinCode(String pinCode) async {
    final response = await http
        .get(Uri.parse('https://api.postalpincode.in/pincode/${pinCode}'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data[0]["Status"] != "Success") {
        return null;
      }
      return data[0]["PostOffice"][0]["District"];
    } else {
      throw Exception('Failed to fetch address');
    }
  }
}
