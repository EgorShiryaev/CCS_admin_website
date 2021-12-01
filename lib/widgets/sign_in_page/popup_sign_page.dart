import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../providers/sign_in/sign_in_cubit.dart';
import '../../providers/sign_in/sign_in_state.dart';

class PopupSignPage extends StatelessWidget {
  final TextEditingController loginController;
  final TextEditingController passController;
  const PopupSignPage({
    Key? key,
    required this.loginController,
    required this.passController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(
      builder: (context, state) {
        if (state is Empty) {
          return const SizedBox();
        }
        return Center(
          child: Container(
            width: 350,
            height: 500,
            color: const Color.fromRGBO(255, 255, 255, 0),
            child: Center(
              child: state is Loading
                  ? const CircularProgressIndicator(color: Colors.grey)
                  : Center(
                      child: Container(
                        height: 200,
                        padding: const EdgeInsets.all(25),
                        decoration: LocalStyles.messageDecoration,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              state is Error
                                  ? state.message
                                  : state is Loaded
                                      ? 'Вы успешно авторизованы!\nС возвращением, ${state.user.name}!'
                                      : '',
                              style: LocalStyles.message,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            OutlinedButton(
                              style: LocalStyles.buttonStyle,
                              onPressed: () {
                                if (state is Loaded) {
                                  Navigator.pushNamed(
                                    context,
                                    '/console',
                                    arguments: {'user': state.user},
                                  );
                                }
                                loginController.clear();
                                passController.clear();
                                BlocProvider.of<SignInCubit>(context).resignIn();
                              },
                              child: SizedBox(
                                width: 300,
                                child: Center(
                                  child: Text(
                                    state is Error ? 'Вернуться на страницу авторизации' : 'Перейти в консоль',
                                    style: LocalStyles.message,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}

class LocalStyles {
  static const color = Colors.grey;
  static const message = TextStyle(fontSize: 20, color: color);
  static final messagePopUpContainerColor = Colors.grey.shade800;
  static final messageDecoration = BoxDecoration(
    color: messagePopUpContainerColor,
    borderRadius: const BorderRadius.all(Radius.circular(25)),
  );
  static const buttonColor = Colors.white;
  static final buttonStyle = OutlinedButton.styleFrom(
    side: const BorderSide(width: 1, color: color),
    padding: const EdgeInsets.all(10),
    primary: color,
  );
}
