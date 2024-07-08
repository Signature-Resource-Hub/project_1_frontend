

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_1_frontend/models/blogs.dart';
import 'package:project_1_frontend/pages/blog_view.dart';
import 'package:project_1_frontend/services/blogsservice.dart';

class BlogPage extends StatefulWidget {
  final List<dynamic>? travelblog;
  
  BlogPage({Key? key, this.travelblog}) : super(key: key);
  
  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  late Future<List<Blog>> data;
  
  @override 
  void initState() {
    super.initState();
    data = BlogService.getblogs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text('Bloggers List', style: TextStyle(fontSize: 24)),
      ),
      body: FutureBuilder<List<Blog>>(
        future: data,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            // Sort the blogs by timestamp in descending order
            List<Blog> sortedBlogs = snapshot.data!;
            sortedBlogs.sort((a, b) => b.timestamp.compareTo(a.timestamp));

            return ListView.builder(
              itemCount: sortedBlogs.length,
              itemBuilder: (context, index) {
                Blog blog = sortedBlogs[index];
                String formattedTimestamp = DateFormat('dd MMM yyyy, hh:mm a').format(blog.timestamp);
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlogDetailsPage(content: blog.content, timestamp: blog.timestamp,username: blog.userid.username,
      location: blog.location,),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 4,
                    margin: EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${blog.userid.username}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text("Location: ${blog.location}", style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.access_time, size: 16, color: Colors.grey),
                              SizedBox(width: 4),
                              Text(
                                "Posted at: ",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                formattedTimestamp,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[600], 
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No bloggers found.'));
          }
        },
      ),
    );
  }
}
