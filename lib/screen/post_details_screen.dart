import 'package:flutter/material.dart';
import 'package:knovator/models/post_model.dart';

class PostDetailScreen extends StatelessWidget {
  final PostModel model;
  const PostDetailScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.grey[100],
      appBar: AppBar(title: const Text("Post Details",style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,elevation: 2,backgroundColor: Colors.deepPurple,foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(elevation: 4,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              color: Colors.deepPurple[50],child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Title",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.deepPurple)),
                    const SizedBox(height: 8),
                    Text(model.title,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black87)),
                  ]))),
            const SizedBox(height: 20),

            Card(elevation: 4,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              color: Colors.teal[50],
              child: Padding(padding: const EdgeInsets.all(20.0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [const Text("Description:",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.teal)),
                    const SizedBox(height: 8),
                    Text(model.body,style: const TextStyle(fontSize: 16,height: 1.5,color: Colors.black87)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
