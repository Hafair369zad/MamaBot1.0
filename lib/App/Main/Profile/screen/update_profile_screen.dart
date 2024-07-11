library ProfileUpdate;

import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trestapkmamabot/App/Auth/model/colors.dart';
import 'package:trestapkmamabot/App/Main/Profile/widget/main_button.dart';

part '../widget/background_image_UpdateProfile.dart';
part '../widget/background_content_UpdateProfile.dart';
part '../widget/header_UpdateProfile.dart';

class UpdateProfileScreen extends StatefulWidget {
  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  File? _imageFile;
  String _photoURL = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.reload();
        user = FirebaseAuth.instance.currentUser;

        setState(() {
          _usernameController.text = user?.displayName ?? '';
          _emailController.text = user?.email ?? '';
          _photoURL = user?.photoURL ?? '';
        });
      }
    } catch (e) {
      print('Failed to load user data: $e');
    }
  }

  void _chooseImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<String> _uploadProfilePicture(File image, String userId) async {
    try {
      Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_pictures')
          .child(userId);
      UploadTask uploadTask = storageRef.putFile(image);
      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print('Failed to upload profile picture: $e');
      rethrow;
    }
  }

  Future<void> _updateProfile() async {
    setState(() {
      _isLoading = true;
    });

    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String username = _usernameController.text;
        String photoURL = _photoURL;

        if (_imageFile != null) {
          photoURL = await _uploadProfilePicture(_imageFile!, user.uid);
        }

        await user.updateDisplayName(username);
        await user.updatePhotoURL(photoURL);

        await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .update({
          'username': username,
          'photoURL': photoURL,
        });

        await user.reload();
        user = FirebaseAuth.instance.currentUser;

        setState(() {
          _usernameController.text = user?.displayName ?? '';
          _photoURL = user?.photoURL ?? '';
        });

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Profile updated successfully')));
        Navigator.pop(context, true);
      }
    } catch (e) {
      print('Failed to update profile: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to update profile')));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FillOnboarding,
      body: Stack(
        children: [
          _BackgroundImageUpdateProfile(),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(height: 50),
                _HeaderUpdateProfil(),
                SizedBox(height: 40),
                _BackgroundContentUpdateProfile(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 70,
                                  backgroundImage: _imageFile != null
                                      ? FileImage(_imageFile!)
                                      : (_photoURL.isNotEmpty
                                              ? NetworkImage(_photoURL)
                                              // : NetworkImage(
                                              //     'https://firebasestorage.googleapis.com/v0/b/mamabot-4eba5.appspot.com/o/profile_pictures%2FuserBlank.png?alt=media&token=a3f40d30-e3d6-4bc7-bc47-0ad7ed0a6ea0'))
                                              : AssetImage(
                                                  'assets/default_profile.png'))
                                          as ImageProvider<Object>?,
                                ),
                                Positioned(
                                  bottom: 5,
                                  right: 5,
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: BlueButtonOnboarding,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.blue,
                                        width: 2,
                                      ),
                                    ),
                                    child: IconButton(
                                      icon: Icon(Icons.edit, size: 20),
                                      onPressed: _chooseImage,
                                      color: Colors.white,
                                      padding: EdgeInsets.all(0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 50, width: 20),
                        TextFormField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            labelStyle: TextStyle(
                              color: BlueButtonOnboarding,
                              fontSize: 18,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: BlueButtonOnboarding),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: BlueButtonOnboarding),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 20, width: 20),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              color: BlueButtonOnboarding,
                              fontSize: 18,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: BlueButtonOnboarding),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: BlueButtonOnboarding),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                          enabled: false,
                        ),
                        SizedBox(height: 120),
                        Mainbutton(
                          onTap: _isLoading ? null : _updateProfile,
                          text: 'Update Profile',
                          btnColor: NewMainBgButton,
                          isLoading: _isLoading,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
