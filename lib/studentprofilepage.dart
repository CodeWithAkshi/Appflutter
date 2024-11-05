import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_database/firebase_database.dart';
import 'utils.dart';
import 'package:flutter/gestures.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';




class StudentProfilePage extends StatefulWidget {
  @override
  _StudentProfilePageState createState() => _StudentProfilePageState();
}

class _StudentProfilePageState extends State<StudentProfilePage> {
  final firestore = FirebaseFirestore.instance.collection("user").snapshots();
  final auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController studentNumberController = TextEditingController();
  final TextEditingController branchController = TextEditingController();
  final TextEditingController sectionController = TextEditingController();
  File? image;

  final List<String> skills = ['Flutter', 'Dart'];
  List<bool> _selectedSkills = List.generate(2, (index) => false);

  String? _selectedGender;

  Future<void> _pickImage() async {
    print('Pick Image Called');
    
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          image = File(pickedFile.path);
        });
      }
   
    
    
  }

  String? _validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Full Name cannot be empty';
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return 'Full Name must contain only alphabets';
    }
    return null;
  }

  String? _validateStudentNumber(String? value) {
    if (value == null || value.length != 7) {
      return 'Student Number must be exactly 7 characters';
    }
    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return 'Student Number must contain only digits';
    }
    return null;
  }

  String? _validateRollNumber(String? value) {
    if (value == null || !RegExp(r'^[A-Z][2][0-9]{2}[0-9]{4}$').hasMatch(value)) {
      return 'Roll Number must follow the format: <BranchLetter><YY><0000>';
    }
    return null;
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      print('Full Name: ${fullNameController.text}');
      print('Student Number: ${studentNumberController.text}');
      print('Branch: ${branchController.text}');
      print('Section: ${sectionController.text}');

      List<String> selectedSkills = [];
      for (int i = 0; i < skills.length; i++) {
        if (_selectedSkills[i]) {
          selectedSkills.add(skills[i]);
        }
      }
      print('Selected Skills: ${selectedSkills.join(', ')}');
      print('Gender: ${_selectedGender ?? "Not specified"}');

      if (image != null) {
        print('Image Path: ${image!.path}');
      }
    }
  }

  @override
  void dispose() {
    fullNameController.dispose();
    studentNumberController.dispose();
    branchController.dispose();
    sectionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: image != null ? FileImage(image!) : null,
                  child: image == null
                      ? Icon(Icons.camera_alt, size: 40, color: Colors.white)
                      : null,
                ),
              ),
              SizedBox(height: 2),
              TextFormField(
                controller: fullNameController,
                decoration: InputDecoration(labelText: 'Full Name'),
                validator: _validateFullName
              ),
              TextFormField(
                controller: studentNumberController,
                decoration: InputDecoration(labelText: 'Student Number'),
                keyboardType: TextInputType.number,
                validator: _validateStudentNumber,
              ),
              TextFormField(
                controller: branchController,
                decoration: InputDecoration(labelText: 'Branch'),
              ),
              TextFormField(
                controller: sectionController,
                decoration: InputDecoration(labelText: 'Section'),
              ),
              SizedBox(height: 3),
              Text('Roll Number:', style: TextStyle(fontSize: 10)),
              TextFormField(
                decoration: InputDecoration(labelText: 'Roll Number (e.g. C230001)'),
                validator: _validateRollNumber,
              ),
              SizedBox(height: 3),
              Text('Skills:', style: TextStyle(fontSize: 18)),
              Column(
                children: List.generate(skills.length, (index) {
                  return CheckboxListTile(
                    title: Text(skills[index]),
                    value: _selectedSkills[index],
                    onChanged: (bool? value) {
                      setState(() {
                        _selectedSkills[index] = value ?? false;
                      });
                    },
                  );
                }),
              ),
              SizedBox(height: 2),
              Text('Gender:', style: TextStyle(fontSize: 12)),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Radio<String>(
                    value: 'Male',
                    groupValue: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                  ),
                  Text('Male'),
                  Radio<String>(
                    value: 'Female',
                    groupValue: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                  ),
                  Text('Female'),
                  Radio<String>(
                    value: 'Other',
                    groupValue: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                  ),
                  Text('Other'),
                ],
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: _saveProfile,
                child: Text('Save Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
