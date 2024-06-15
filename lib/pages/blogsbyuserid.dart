// import 'dart:convert';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:project_1_frontend/pages/addblog.dart';
// import 'package:project_1_frontend/services/addblog.dart';

// class BlogListPage extends StatefulWidget {
//   @override
//   _BlogListPageState createState() => _BlogListPageState();
// }

// class _BlogListPageState extends State<BlogListPage> {
//   final storage = const FlutterSecureStorage();
//   final BlogService blogService = BlogService();
//   List<dynamic> _blogs = [];
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _fetchBlogs();
//   }

//   Future<void> _fetchBlogs() async {
//   Map<String, String> allValues = await storage.readAll();
//   String normalizedSource = base64Url.normalize(allValues["token"]!.split(".")[1]);
//   String userId = json.decode(utf8.decode(base64Url.decode(normalizedSource)))["id"];

//   try {
//     List<dynamic> blogs = await blogService.fetchUserBlogs(userId);
//     setState(() {
//       _blogs = blogs;
//       _isLoading = false;
//     });
//   } on DioException catch (e) {
//     // Check if the error message contains "404" and handle it appropriately
//     if (e.toString().contains("No blogs found for the given userid")) {
      
//       setState(() {
//         _isLoading = false;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('No blogs found')));
//     } else {
//       // Handle other errors
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
// }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Your Blogs'),
//         backgroundColor: Colors.teal,
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : _blogs.isEmpty
//               ? Center(child: Text('No blogs found'))
//               : ListView.builder(
//                   itemCount: _blogs.length,
//                   itemBuilder: (context, index) {
//                     final blog = _blogs[index];
//                     return ListTile(
//                       title: Text(blog['content']),
//                       subtitle: Text(blog['location']),
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => AddBlogPage(blog: blog),
//                           ),
//                         ).then((value) => _fetchBlogs());
//                       },
//                     );
//                   },
//                 ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => AddBlogPage(),
//             ),
//           ).then((value) => _fetchBlogs());
//         },
//         child: Icon(Icons.add),
//         backgroundColor: Colors.teal,
//       ),
//     );
//   }
// }


import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project_1_frontend/pages/addblog.dart';
import 'package:project_1_frontend/services/addblog.dart';

class BlogListPage extends StatefulWidget {
  @override
  _BlogListPageState createState() => _BlogListPageState();
}

class _BlogListPageState extends State<BlogListPage> {
  final storage = const FlutterSecureStorage();
  final BlogService blogService = BlogService();
  List<dynamic> _blogs = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchBlogs();
  }

  Future<void> _fetchBlogs() async {
    Map<String, String> allValues = await storage.readAll();
    String normalizedSource =
        base64Url.normalize(allValues["token"]!.split(".")[1]);
    String userId =
        json.decode(utf8.decode(base64Url.decode(normalizedSource)))["id"];

    try {
      List<dynamic> blogs = await blogService.fetchUserBlogs(userId);
      setState(() {
        _blogs = blogs;
        _isLoading = false;
      });
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('No blogs found')));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _deleteBlog(String blogId) async {
    try {
      await blogService.deleteBlog(blogId);
      _fetchBlogs();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Blog deleted successfully')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to delete blog: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Blogs'),
        backgroundColor: Colors.teal,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _blogs.isEmpty
              ? Center(child: Text('No blogs found'))
              : ListView.builder(
                  itemCount: _blogs.length,
                  itemBuilder: (context, index) {
                    final blog = _blogs[index];
                    return Card(
                      elevation: 3,
                      margin: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 12,
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(12),
                        title: Text(
                          blog['location'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8),
                            Text(
                              blog['content'],
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Timestamp: ${blog['timestamp']}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            final blogId = blog['_id'];
                            if (blogId != null) {
                              _deleteBlog(blogId);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Invalid blog ID')));
                            }
                          },
                        ),
                        // onTap: () {
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => AddBlogPage(blog: blog),
                        //     ),
                        //   ).then((value) => _fetchBlogs());
                        // },
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddBlogPage(),
            ),
          ).then((value) => _fetchBlogs());
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.teal,
      ),
    );
  }
}

