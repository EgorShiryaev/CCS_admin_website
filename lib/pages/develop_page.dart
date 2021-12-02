import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../providers/users/users_cubit.dart';
import '../providers/users/users_state.dart';
import '../widgets/state_builder.dart';
import '../widgets/users_page/body_users_page.dart';

class DevelopPage extends StatelessWidget {
  const DevelopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UsersCubit>(context).read();
    return Scaffold(
      body: BlocBuilder<UsersCubit, UsersState>(builder: (context, state) {
        if (state is Loading) {
          return StateBuilder.loading();
        }
        if (state is Error) {
          return StateBuilder.error(state.message);
        }
        if (state is Loaded) {
          return BodyUsersPage(users: state.users);
        }
        return StateBuilder.error('Неизвестный state');
      }),
    );
  }
}
