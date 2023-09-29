import 'package:edukit_tech/services/address_service.dart';
import 'package:edukit_tech/view_models/user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateLocation extends StatefulWidget {
  const UpdateLocation({super.key});

  @override
  State<UpdateLocation> createState() => _UpdateLocationState();
}

class _UpdateLocationState extends State<UpdateLocation> {
  bool readOnly = false;
  AddressService service = new AddressService();
  TextEditingController _locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: Text('Update Location'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.grey.shade300,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _locationController,
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
                        icon: Icon(Icons.edit),
                      )
                    : IconButton(
                        iconSize: 18,
                        onPressed: () async {
                          var val = await service
                              .fetchAddressByPinCode(_locationController.text);
                          if (val != null) {
                            setState(() {
                              _locationController.text = val.toString();
                              readOnly = true;
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Enter valid Pincode'),
                              ),
                            );
                          }
                        },
                        icon: Icon(Icons.search_outlined)),
              ),
              readOnly: readOnly,
            ),
            TextButton(
              onPressed: () {
                if (readOnly) {
                  Provider.of<UserViewModel>(context, listen: false)
                      .updateLocation(_locationController.text);
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.red,
                      content: Text('Select the location')));
                }
              },
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
