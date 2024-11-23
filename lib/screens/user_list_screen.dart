import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_api/api/api_provider.dart';
import 'package:flutter_bloc_api/api/api_repository.dart';
import 'package:flutter_bloc_api/bloc/user_bloc.dart';
import 'package:flutter_bloc_api/bloc/user_event.dart';
import 'package:flutter_bloc_api/bloc/user_state.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final APIProvider apiProvider = APIProvider(baseUrl: 'https://api.github.com/users');
    final APIRepository apiRepository = APIRepository(apiProvider: apiProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Github Users'),
      ),
      body: BlocProvider(create: (context) =>
      UserBloc(apiRepository: apiRepository)
      ..add(FetchUsers()), child: const UserList(),),
    );
  }
}

class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      if(state is UserLoading) {
        return const Center(child: CircularProgressIndicator(),);
      } else if(state is UserLoaded) {
        return ListView.builder(
          itemCount: state.users.length,
          itemBuilder: (context, index) {
            final user = state.users[index];
            return ListTile(
              leading: Image.network(user.avatarUrl),
              title: Text(user.login),
              subtitle: Text(user.htmlUrl),
            );
          },
        );
      } else if(state is UserError) {
        return Center(child: Text(state.message),);
      } else {
        return const Center(child: Text('Press the button to fetch users'),);
      }
    });
  }
}
