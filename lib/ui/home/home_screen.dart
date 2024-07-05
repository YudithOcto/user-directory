import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_directory/domain/model/user.dart';
import 'package:user_directory/ui/home/bloc/home_bloc.dart';
import 'package:user_directory/ui/home/bloc/home_event.dart';
import 'package:user_directory/ui/home/bloc/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(const LoadDataEvent(nextPage: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Beranda'),
        automaticallyImplyLeading: false,
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {},
        builder: (buildContext, state) {
          if (state is LoadedHomeState) {
            return _buildListView(
                buildContext, state.userData, state.isLastPage, onTap: () {
              context
                  .read<HomeBloc>()
                  .add(LoadDataEvent(nextPage: state.currentPage + 1));
            });
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _buildListView(
      BuildContext context, List<User> users, bool isLastIndex,
      {required VoidCallback onTap}) {
    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      separatorBuilder: (_, __) => const Divider(),
      itemCount: users.length + (!isLastIndex ? 1 : 0),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        if (!isLastIndex && index == users.length) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                onTap();
              },
              child: Text("load More"),
            ),
          );
        }
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
