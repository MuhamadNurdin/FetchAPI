import 'package:assesment/data/model/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:assesment/bloc/post_bloc.dart';
import 'package:assesment/data/repository/api_repository.dart';
import 'package:assesment/service/data_service.dart';

import 'bloc/post_event.dart';
import 'bloc/post_state.dart';
import 'screen/create_source_scren.dart';

void main() {
  runApp(MyApp(
    dataService: DataService(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.dataService}) : super(key: key);
  final DataService dataService;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Bloc Api',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Test Assessment CRUD'),
        ),
        body: BlocProvider(
          create: (context) =>
          PostBloc(apiRepository: ApiRepository(dataService: dataService))
            ..add(LoadEvent()),
          child:  _HomeScreen(),
        ),
      ),
    );
  }
}

class _HomeScreen extends StatefulWidget {
  @override
  State<_HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<_HomeScreen> {

  List<bool> isExpandedList = [];
  List<bool> isMinimizedList = [];
  String? _submittedDataName;
  String? _submittedDataDescription;

  // Method to show the submitted data card at the bottom
  void _showSubmittedDataCard(String name, String description) {
    setState(() {
      _submittedDataName = name;
      _submittedDataDescription = description;
    });
  }

  // Method to hide the submitted data card
  void _hideSubmittedDataCard() {
    setState(() {
      _submittedDataName = null;
      _submittedDataDescription = null;
    });
  }

  Future<void> _showEditPostDialog(BuildContext context, Post post) async {
    TextEditingController titleController = TextEditingController(text: post.title);
    TextEditingController bodyController = TextEditingController(text: post.body);

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Post'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: bodyController,
                decoration: InputDecoration(labelText: 'Body'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context.read<PostBloc>().add(
                  UpdatePostEvent(
                    postId: post.id,
                    newTitle: titleController.text,
                    newBody: bodyController.text,
                  ),
                );
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showDeletePostDialog(BuildContext context, Post post) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Post'),
          content: Text('Are you sure you want to delete this post?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context.read<PostBloc>().add(DeletePostEvent(postId: post.id));
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        if (state is LoadedState) {
          final displayedPosts = state.posts.take(3).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Posts'),
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                context.read<PostBloc>().add(PullToRefreshEvent());
              },
              child: ListView.builder(
                itemBuilder: (context, index) {
                  if (index < displayedPosts.length) {
                    final posts = displayedPosts[index];
                    final isExpanded =
                        isExpandedList.length > index && isExpandedList[index];
                    final isMinimized =
                        isMinimizedList.length > index && isMinimizedList[index];

                    return Card(
                      margin: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              child: Text(posts.id.toString()),
                            ),
                            title: Text(posts.title),
                            subtitle: Text(posts.body),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    _showEditPostDialog(context, posts);
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    _showDeletePostDialog(context, posts);
                                  },
                                ),
                              ],
                            ),
                          ),
                          if (isExpanded)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.minimize),
                                  onPressed: () {
                                    setState(() {
                                      isExpandedList[index] = false;
                                      isMinimizedList[index] = true;
                                    });
                                  },
                                ),
                              ],
                            ),
                          if (isMinimized)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.maximize),
                                  onPressed: () {
                                    setState(() {
                                      isExpandedList[index] = true;
                                      isMinimizedList[index] = false;
                                    });
                                  },
                                ),
                              ],
                            ),
                        ],
                      ),
                    );
                  } else if (index == displayedPosts.length) {
                    return ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateSourceScreen(),
                          ),
                        ).then((value) {
                          context.read<PostBloc>().add(LoadEvent());
                        });
                      },
                      child: Text('Create Source'),
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
                itemCount: displayedPosts.length + 1,
              ),
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
