import 'package:equatable/equatable.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object?> get props => [];
}

class LoadEvent extends PostEvent {}

class PullToRefreshEvent extends PostEvent {}

class UpdatePostEvent extends PostEvent {
  final int postId;
  final String newTitle;
  final String newBody;

  const UpdatePostEvent({
    required this.postId,
    required this.newTitle,
    required this.newBody,
  });

  @override
  List<Object?> get props => [postId, newTitle, newBody];
}

class DeletePostEvent extends PostEvent {
  final int postId;

  const DeletePostEvent({required this.postId});

  @override
  List<Object> get props => [postId];
}