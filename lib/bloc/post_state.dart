// post_state.dart
import 'package:assesment/data/model/post.dart';
import 'package:assesment/data/model/source_model.dart';
import 'package:equatable/equatable.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object?> get props => [];
}

class LoadingState extends PostState {}

class LoadedState extends PostState {
  final List<Post> posts;

  const LoadedState({required this.posts});

  @override
  List<Object?> get props => [posts];
}

class FailureLoadState extends PostState {
  final String message;

  const FailureLoadState({required this.message});

  @override
  List<Object?> get props => [message];
}

class SourcesState extends PostState {
  final List<Source> sources;
  final List<Post> posts; // Assuming you want to display posts along with sources

  const SourcesState({required this.sources, required this.posts});

  @override
  List<Object?> get props => [sources, posts];
}

class PostInitial extends PostState {
  const PostInitial();

  @override
  List<Object?> get props => [];
}