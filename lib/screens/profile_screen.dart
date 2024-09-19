import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  final String username;
  final String email;

  ProfileScreen({required this.username, required this.email});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _profileImage;
  final TextEditingController _usernameController = TextEditingController();
  final ImagePicker _picker =
      ImagePicker(); //used to access device gallery  or camera
  bool _isEditing = false; // Controls the visibility of the TextField

  @override
  void initState() {
    super.initState();
    _usernameController.text =
        widget.username; // Initialize the controller with the current username
  }

  Future<void> _pickImageFromGallery() async {
    // returns future object
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickImageFromCamera() async {
    // returns future object
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  void _showImageOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          // avoid obscure by notch or other elements
          child: Wrap(
            // wraps listtile vertically
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () {
                  _pickImageFromGallery();
                  Navigator.of(context)
                      .pop(); // Close the bottom sheet after selecting
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Camera'),
                onTap: () {
                  _pickImageFromCamera();
                  Navigator.of(context)
                      .pop(); // Close the bottom sheet after selecting
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _saveUsername() {
    setState(() {
      _isEditing = false; // Close the TextField after saving
    });
  }

  void _logout() {
    // Add your logout logic here
    print("User logged out");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              // enables tap function across profile
              onTap: _showImageOptions,
              // Show gallery and camera options on tap
              child: CircleAvatar(
                radius: 50,
                backgroundImage:
                    _profileImage != null ? FileImage(_profileImage!) : null,
                child:
                    _profileImage == null ? Icon(Icons.person, size: 50) : null,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _isEditing
                    ? Expanded(
                        child: TextField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      )
                    : Text(
                        'Username: ${_usernameController.text}',
                        style: TextStyle(fontSize: 24, color: Colors.black),
                      ),
                IconButton(
                  icon: Icon(_isEditing ? Icons.check : Icons.edit),
                  color: Colors.black,
                  onPressed: () {
                    if (_isEditing) {
                      _saveUsername();
                    } else {
                      setState(() {
                        _isEditing = true;
                      });
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Email: ',
                  style: TextStyle(fontSize: 24, color: Colors.black),
                ),
                Text(
                  widget.email,
                  style: TextStyle(fontSize: 24, color: Colors.black),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _logout,
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
