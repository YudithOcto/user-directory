import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_directory/domain/model/user.dart';
import 'package:user_directory/ui/home/bloc/home_bloc.dart';
import 'package:user_directory/ui/home/bloc/home_event.dart';
import 'package:user_directory/ui/home/bloc/home_state.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final List<User> users = [
    User(
        firstName: 'John',
        lastName: 'Doe',
        avatar: 'https://i.pravatar.cc/150?img=1',
        email: 'john.doe@example.com',
        id: 0),
    User(
        firstName: 'Jane',
        lastName: 'Smith',
        avatar: 'https://i.pravatar.cc/150?img=2',
        email: 'jane.smith@example.com',
        id: 0),
    User(
        firstName: 'Robert',
        lastName: 'Johnson',
        avatar: 'https://i.pravatar.cc/150?img=3',
        email: 'robert.johnson@example.com',
        id: 0),
    // Add more users here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.swap_vert),
            onPressed: () {
              context.read<HomeBloc>().add(ToggleView());
            },
          ),
        ],
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {},
        builder: (buildContext, state) {
          return _buildListView();
        },
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(users[index].avatar),
          ),
          title: Text('${users[index].firstName} ${users[index].lastName}'),
          subtitle: Text(users[index].email),
        );
      },
    );
  }
}
