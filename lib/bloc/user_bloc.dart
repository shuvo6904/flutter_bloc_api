import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_api/api/api_repository.dart';
import 'package:flutter_bloc_api/bloc/user_event.dart';
import 'package:flutter_bloc_api/bloc/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final APIRepository apiRepository;

  UserBloc({required this.apiRepository}) : super(UserInitial()) {
    on<FetchUsers>((event, emit) async {
      emit(UserLoading());
      try {
        final users = await apiRepository.getUsers();
        emit(UserLoaded(users));
      } catch (e) {
        emit(UserError('Failed to load users: $e'));
      }
    });
  }
}
