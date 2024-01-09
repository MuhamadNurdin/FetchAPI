import 'package:assesment/bloc/post_state.dart';
import 'package:bloc/bloc.dart';
import '../data/repository/api_repository.dart';
import 'post_event.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final ApiRepository apiRepository;

  PostBloc({required this.apiRepository}) : super(PostInitial()) {
    on<PostEvent>((event, emit) async {
      if (event is LoadEvent || event is PullToRefreshEvent) {
        emit(LoadingState());
        try {
          final posts = await apiRepository.getPostsList();
          emit(LoadedState(posts: posts));
        } catch (e) {
          emit(FailureLoadState(message: e.toString()));
        }
      } else {
        // Handle other events if needed
      }
    });
  }
}
