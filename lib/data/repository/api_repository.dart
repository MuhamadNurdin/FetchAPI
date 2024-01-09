import 'dart:convert';


import 'package:assesment/data/model/post.dart';
import 'package:assesment/service/data_service.dart';

class ApiRepository {
  final DataService dataService;
  ApiRepository({
    required this.dataService,
  });

  Future<List<Post>> getPostsList() async {
    final response = await dataService.getPosts();
    if (response!.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      final posts = json.map((e) => Post.fromJson(e)).toList();
      return posts;
    } else {
      throw Exception('Failed to load Posts');
    }
  }
}