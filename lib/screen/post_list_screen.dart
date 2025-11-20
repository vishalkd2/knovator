import 'package:flutter/material.dart';
import 'package:knovator/models/post_model.dart';
import 'package:knovator/screen/post_details_screen.dart';
import 'package:knovator/services/api_services.dart';
import 'package:knovator/utils/read_status_helper.dart';
import 'package:knovator/widget/counter_widget.dart';


class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final ApiService apiService = ApiService();
  late Future<List<PostModel>> futurePosts;
  final Map<int, bool> readStatus = {};

  @override
  void initState() {
    super.initState();
    futurePosts = apiService.fetchPosts();
  }

  Future<void> _checkReadStatus(List<PostModel> posts) async {
    for (var post in posts) {
      bool isRead = await ReadStatusHelper.isRead(post.id);
      readStatus[post.id] = isRead;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("posts",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.teal],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<PostModel>>(
        future: futurePosts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No posts found"));
          }

          final posts = snapshot.data!;
          _checkReadStatus(posts);

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              final isRead = readStatus[post.id] ?? false;

              return Card(
                elevation: 4,
                shadowColor: Colors.black26,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                color: isRead ? Colors.white : Colors.yellow[100],
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(contentPadding: const EdgeInsets.all(16),
                  leading: CircleAvatar(
                    backgroundColor: isRead ? Colors.teal : Colors.deepPurple,
                    child: Text(post.id.toString(),style: const TextStyle(color: Colors.white))),
                  title: Text(post.title,maxLines: 1,overflow: TextOverflow.ellipsis,
                    style:TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: isRead ? Colors.black54 : Colors.black,),
                  ),
                  trailing: CountdownTimerWidget(postId: post.id),
                  onTap: () async {await Navigator.push(context,MaterialPageRoute(builder: (context) => PostDetailScreen(model: post)));
                    await ReadStatusHelper.markAsRead(post.id);
                    setState(() {
                      readStatus[post.id] = true;
                    });
                  }));
            });
        }));
  }
}
