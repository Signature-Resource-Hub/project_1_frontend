import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project_1_frontend/services/addblogs.dart';
//import 'package:project_1_frontend/services/blogsservice.dart';

class AddBlogPage extends StatefulWidget {
  final Map<String, dynamic>? blog;

  AddBlogPage({this.blog});

  @override
  _AddBlogPageState createState() => _AddBlogPageState();
}

class _AddBlogPageState extends State<AddBlogPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final storage = const FlutterSecureStorage();
  final BlogService blogService = BlogService();
  bool _isEditMode = false; // Variable to track whether in edit mode

  @override
  void initState() {
    super.initState();
    if (widget.blog != null) {
      // _contentController.text = widget.blog!['content'];
      // _locationController.text = widget.blog!['location'];
      _isEditMode = true; // If blog is provided, set edit mode to true
    }
  }

  Future<void> _submitBlog() async {
    final String content = _contentController.text;
    final String location = _locationController.text;
    Map<String, String> allValues = await storage.readAll();
    String normalizedSource =
        base64Url.normalize(allValues["token"]!.split(".")[1]);
    String userId =
        json.decode(utf8.decode(base64Url.decode(normalizedSource)))["id"];

    try {
      final response = widget.blog == null
          ? await blogService.addBlog(
              userid: userId,
              content: content,
              location: location,
            )
          : await blogService.editBlog(
              blogId: widget.blog!['id'],
              content: content,
              location: location,
            );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(widget.blog == null
                ? 'Blog added successfully'
                : 'Blog updated successfully')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(widget.blog == null
                ? 'Failed to add blog'
                : 'Failed to update blog')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditMode ? 'Edit Blog' : 'Add Blog'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade200, Colors.teal.shade600],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    _isEditMode ? 'Edit Blog Post' : 'Create a New Blog Post',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _locationController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Location',
                      labelStyle: TextStyle(color: Colors.teal),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: Icon(Icons.location_on, color: Colors.teal),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter location';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _contentController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Write your content here!!!',
                      labelStyle: TextStyle(color: Colors.teal),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: Icon(Icons.text_fields, color: Colors.teal),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter content';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _submitBlog();
                      }
                    },
                    child: Text(_isEditMode ? 'Save Changes' : 'Add Blog'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.teal,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      textStyle:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  // Only show edit mode option if not editing
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
