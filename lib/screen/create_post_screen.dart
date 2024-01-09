// create_post_screen.dart
import 'package:flutter/material.dart';

class CreatePostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post'),
      ),
      body: CreatePostForm(),
    );
  }
}

class CreatePostForm extends StatefulWidget {
  @override
  _CreatePostFormState createState() => _CreatePostFormState();
}

class _CreatePostFormState extends State<CreatePostForm> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          SizedBox(height: 16),
          TextField(
            controller: bodyController,
            maxLines: 3,
            decoration: InputDecoration(labelText: 'Body'),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // TODO: Add logic to save post and update HomeScreen
              Navigator.pop(context);
            },
            child: Text('Create Post'),
          ),
        ],
      ),
    );
  }
}
