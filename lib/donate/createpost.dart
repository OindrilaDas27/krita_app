import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:krita/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:krita/provider/sign_in_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:geocoding/geocoding.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});
  @override
  PostState createState() => PostState();
}

class PostState extends State<CreatePost> {
  bool isUploading = false;
  bool status = false;
  bool isLoading = false;
  String postId = const Uuid().v4();
  XFile? file;
  TextEditingController locationController = TextEditingController();
  TextEditingController foodItemController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController vegnController = TextEditingController();
  TextEditingController msgController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  final Reference storageref = FirebaseStorage.instance.ref();
  User? user;
  String? mediaUrl;
  Position? position;

  fromCamera() async {
    Navigator.pop(context);
    var img = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxHeight: 675,
      maxWidth: 960,
    );
    setState(() {
      file = img;
    });
    File image = File(img!.path);
    uploadFile(image);
  }

  fromGallery() async {
    Navigator.pop(context);
    var image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 675,
      maxWidth: 960,
    );
    setState(() {
      file = image;
    });
    File imagee = File(image!.path);
    uploadFile(imagee);
  }

  selectImage(parentContext) {
    return showDialog(
        context: parentContext,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Upload Image'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: fromCamera,
                child: const Text("Camera"),
              ),
              SimpleDialogOption(
                onPressed: fromGallery,
                child: const Text("Gallery"),
              ),
            ],
          );
        });
  }

  Future<String> uploadimage(imagefile) async {
    UploadTask uploadTask =
        storageref.child('post_$postId.jpg').putFile(imagefile);
    TaskSnapshot storagesnap = await uploadTask;
    String downloadurl = await storagesnap.ref.getDownloadURL();
    return downloadurl;
  }

  Future<String> uploadFile(File image) async {
    String downloadURL;
    String postId = DateTime.now().millisecondsSinceEpoch.toString();
    Reference ref = FirebaseStorage.instance
        .ref()
        .child("images")
        .child("post_$postId.jpg");
    await ref.putFile(image);
    downloadURL = await ref.getDownloadURL();
    return downloadURL;
  }

  Future<void> userSetup(
    User? user,
    String location,
    String foodItem,
    String time,
    String date,
    String quantity,
    String? mediaurl,
    String vegn,
    String msg,
  ) async {
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('Users')
        .doc(user?.uid)
        .collection('userpost')
        .doc(postId)
        .set({
      'displayName': user?.displayName,
      'uid': user?.uid,
      "postId": postId,
      "location": location,
      "fooditem": foodItem,
      "time": time,
      "date": date,
      "quantity": quantity,
      "mediaurl": mediaurl,
      "veg/nonveg": vegn,
      "msg": msg,
    });
    setState(() {
      status = true;
    });
  }

  Future<void> getUserCurrentLocation() async {
    setState(() {
      isLoading = true;
    });
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position!.latitude, position!.longitude);
    Placemark placemark = placemarks[0];
    setState(() {
      locationController.text =
          "${placemark.street}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}";
    });
    setState(() {
      isLoading = false;
    });
  }

  Future<void> datetime() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        dateController.text = picked.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Krita',
        home: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(left: 20.0, right: 20.0),
              height: MediaQuery.of(context).size.height * 0.8,
              child: ListView(
                children: [
                  isUploading
                      ? const LinearProgressIndicator()
                      : const Text(""),
                  const Text(
                    'Donate Food Details',
                    style: TextStyle(
                      fontSize: 24.0,
                      color: main_theme,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 15),
                    margin: const EdgeInsets.only(top: 40),
                    child: TextField(
                      controller: foodItemController,
                      decoration: const InputDecoration(
                        hintText: "Food Item(s)",
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    title: TextField(
                      controller: locationController,
                      decoration: const InputDecoration(
                        hintText: "PickUp Where?",
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    trailing: isLoading
                        ? CircularProgressIndicator()
                        : IconButton(
                            icon: const Icon(
                              Icons.pin_drop_outlined,
                              color: main_theme,
                            ),
                            onPressed: getUserCurrentLocation),
                  ),
                  const Divider(),
                  Container(
                    padding: const EdgeInsets.only(left: 15),
                    child: TextFormField(
                      keyboardType: TextInputType.datetime,
                      maxLength: 5,
                      onChanged: (value) {
                        if (timeController.text.length == 2) {
                          timeController.text = "${timeController.text}:";
                        }
                      },
                      controller: timeController,
                      decoration: const InputDecoration(
                        hintText: "Prefered Time (Use 24hrs format)",
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    title: TextField(
                      controller: dateController,
                      decoration: const InputDecoration(
                        hintText: "PickUp Date",
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    trailing: IconButton(
                        icon: const Icon(
                          Icons.calendar_today,
                          color: main_theme,
                        ),
                        onPressed: () {
                          datetime();
                        }),
                  ),
                  const Divider(),
                  Container(
                    padding: const EdgeInsets.only(left: 15),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: quantityController,
                      decoration: const InputDecoration(
                        hintText: "Quantity",
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Divider(),
                  Container(
                    padding: const EdgeInsets.only(left: 15),
                    child: TextField(
                      controller: vegnController,
                      decoration: const InputDecoration(
                        hintText: "Veg/Non-Veg",
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Divider(),
                  Container(
                    padding: const EdgeInsets.only(left: 15),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      controller: msgController,
                      decoration: const InputDecoration(
                        hintText: "Add a message",
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'Add Photos',
                    style: TextStyle(
                      color: Color.fromARGB(255, 117, 117, 117),
                      fontSize: 12,
                    ),
                  ),
                  file != null
                      ? Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              File(file!.path),
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                            ),
                          ),
                        )
                      : Container(
                          margin: const EdgeInsets.only(right: 280.0),
                          child: DottedBorder(
                              padding: const EdgeInsets.all(20),
                              color: const Color.fromRGBO(158, 158, 158, 1),
                              strokeWidth: 1,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.add_box_rounded,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  selectImage(context);
                                },
                              ))),
                  const Padding(padding: EdgeInsets.only(top: 30)),
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 1,
                    child: ElevatedButton(
                        onPressed: () async {
                          user = await Authentication.signInWithGoogle(
                              context: context);
                          isUploading
                              ? null
                              : setState(() {
                                  isUploading = true;
                                });
                          // await compressImage();
                          File image = File(file!.path);
                          mediaUrl = await uploadimage(image);
                          String location = locationController.text;
                          String foodItem = foodItemController.text;
                          String time = timeController.text;
                          String date = dateController.text;
                          String quantity = quantityController.text;
                          String vegn = vegnController.text;
                          String msg = msgController.text;
                          userSetup(user, location, foodItem, time, date,
                              quantity, mediaUrl, vegn, msg);
                          locationController.clear();
                          foodItemController.clear();
                          timeController.clear();
                          dateController.clear();
                          quantityController.clear();
                          vegnController.clear();
                          setState(() {
                            file = null;
                            isUploading = false;
                          });
                          if (status == true && context.mounted) {
                            const snackBar = SnackBar(
                              content: Text('Post Uploaded!'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(main_theme),
                        ),
                        child: const Text('Post')),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
//todo: null values => snackbar and disable linearprogrss bar