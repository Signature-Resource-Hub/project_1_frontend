


// import 'package:flutter/material.dart';
// import 'package:project_1_frontend/models/blog.dart';

// import 'package:project_1_frontend/pages/blog_view_page.dart';
// import 'package:project_1_frontend/services/blogservice.dart';

// class GuidePage extends StatefulWidget {
//   @override
//   _GuidePageState createState() => _GuidePageState();
// }

// class _GuidePageState extends State<GuidePage> {
//   late Future<List<Blog>> data;

//   @override
//   void initState() {
//     super.initState();
//     data = BlogService.getblogs();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.lightBlueAccent,
//         title: Text('Bloggers List', style: TextStyle(fontSize: 24)),
//       ),
//       body: FutureBuilder<List<Blog>>(
//         future: data,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
//             return ListView.builder(
//               itemCount: snapshot.data!.length,
//               itemBuilder: (context, index) {
//                 Blog blog = snapshot.data![index];
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => BlogDetailsPage(content: blog.content, blog: blog),
//                       ),
//                     );
//                   },
//                   child: Card(
//                     elevation: 4,
//                     margin: EdgeInsets.all(16),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "${blog.userid.username}",
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.blueAccent,
//                             ),
//                           ),
//                           SizedBox(height: 8),
//                           // Text(
//                           //   "${blog.content}",
//                           //   maxLines: 2,
//                           //   overflow: TextOverflow.ellipsis,
//                           //   style: TextStyle(
//                           //     fontSize: 16,
//                           //     color: Colors.black87,
//                           //   ),
//                           // ),
//                           SizedBox(height: 8),
//                           Text(
//                             "Posted at: ${blog.timestamp}",
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Colors.grey,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             );
//           } else {
//             return Center(child: Text('No bloggers found.'));
//           }
//         },
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_1_frontend/models/blog.dart';
import 'package:project_1_frontend/pages/blog_view_page.dart';
import 'package:project_1_frontend/services/blogservice.dart';
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
    ///data = ();
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
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Blog blog = snapshot.data![index];
                String formattedTimestamp = DateFormat('dd MMM yyyy, hh:mm a').format(blog.timestamp);
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlogDetailsPage(content: blog.content, timestamp: blog.timestamp),
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
                          SizedBox(height: 16,),
                          Text("Location: ${blog.location}", style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          
                          SizedBox(height: 8),
                          
                          Row(
                            children: [
                              Icon(Icons.access_time, size: 16, color: Colors.grey), // Add an icon
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

