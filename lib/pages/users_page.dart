import 'package:admin_website/providers/cubit_constructor.dart';
import 'package:admin_website/widgets/state_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../classes/user.dart';
import '../providers/users_cubit.dart';
import '../widgets/users_page/body_users_page.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UsersCubit, StateCubit>(builder: (context, state) {
        if (state is Loading) {
          return StateBuilder.loading();
        }
        if (state is Error) {
          return StateBuilder.error(state.message);
        }
        if (state is Loaded) {
          return BodyUsersPage(users: state.data as List<User>);
        }
        return StateBuilder.error('Неизвестный state');
      }),
    );
  }
}
