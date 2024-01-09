import 'source_model.dart';

class Post {
  final int id;
  final String title;
  final String body;
  final int userId;
  Post({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
  });

  factory Post.fromJson(Map<String, dynamic> map) {
    return Post(
      id: map['id'] as int,
      title: map['title'] as String,
      body: map['body'] as String,
      userId: map['userId'] as int,
    );
    
    
  }
}
Post convertSourceToPost(Source source) {
  return Post(
    id: 0, // Set an appropriate value for the id
    title: source.name,
    body: source.description,
    userId: 1, // Set a valid user id based on your application logic
  );
}