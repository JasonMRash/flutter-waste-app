import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:wasteagram/models/waste_item.dart';

class NewPostScreen extends StatefulWidget {

  NewPostScreen({Key? key}) : super(key: key);

  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  File? image;

  final picker = ImagePicker();
  final formKey = GlobalKey<FormState>();
  LocationData? locationData;
  String? url;
  double? longitude;
  double? latitude;
  int? quantity;
  WasteItem? wasteItem;

  void getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    image = File(pickedFile!.path);
    
    Reference storageReference =
      FirebaseStorage.instance.ref().child(DateFormat.yMMMMd('en_US').add_jm().format(DateTime.now()));
    
    UploadTask uploadTask = storageReference.putFile(image!);
    await uploadTask.whenComplete(() async => {
    url = await storageReference.getDownloadURL()});
  }

  void getLocationData() async {
    var locationService = Location();
    locationData = await locationService.getLocation();
    latitude = locationData!.latitude;
    longitude = locationData!.longitude;
    setState(() {   
    });
  }

   @override
  void initState() {
    super.initState();
    getImage();
    getLocationData();
  }

   @override
  Widget build(BuildContext context) {
    if (image != null) {
      return Scaffold(
        appBar: AppBar(
          leading: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back)
          ),
          title: Center(
            child: Text('New Waste Item')
          ),
        ),
        body: Center(
          child: Column(
            children: [
              Image.file(image!, height: 200),
              SizedBox(height: 40),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Number of Waste Items',
                        hintStyle: Theme.of(context).textTheme.headline4
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline4,
                      onSaved: (value) {
                        quantity = int.tryParse(value!);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter number of waste items';
                        } else {
                          return null;
                        }
                      },
                    ),
                    ElevatedButton(
                      child: Text('Save'),
                      onPressed: () {
                        if (formKey.currentState!.validate())
                        {
                          formKey.currentState!.save();
                          wasteItem = WasteItem(
                            imageURL: url, 
                            date: DateFormat.yMMMMd('en_US').format(DateTime.now()), 
                            latitude: latitude, 
                            longitude: longitude,
                            quantity: quantity);
                          // Save to FireStore
                          FirebaseFirestore.instance.collection('wasteItems').add(wasteItem!.fromMap());
                          Navigator.of(context).pop();
                        }
                      }
                    )
                  ]
                )
              ),
            ]
          )
        )
      );
    } else {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
  }
}