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
        if (state is SignOut) {
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
                        decoration: LocalStyles.messageDecoration(state is Error ? 'error' : 'success'),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              state is Error
                                  ? state.message
                                  : state is SignIn
                                      ? 'Вы успешно авторизованы!\nС возвращением, ${state.user.name}!'
                                      : '',
                              style: LocalStyles.message,
                              textAlign: TextAlign.center,
                            ),
                            OutlinedButton(
                              style: LocalStyles.buttonStyle,
                              onPressed: () {
                                if (state is SignIn) {
                                  Navigator.pushNamed(
                                    context,
                                    '/mainMenu',
                                    arguments: {'user': state.user},
                                  );
                                  loginController.clear();
                                }
                                passController.clear();
                                BlocProvider.of<SignInCubit>(context).resignIn();
                              },
                              child: SizedBox(
                                width: 300,
                                height: 50,
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
  static const color = Colors.white;
  static const message = TextStyle(fontSize: 20, color: color);
  static const messagePopUpContainerColor = Colors.grey;
  static const errorColor = Colors.red;
  static const successColor = Colors.green;
  static messageDecoration(String state) => BoxDecoration(
        color: state == 'error' ? errorColor : successColor,
        borderRadius: const BorderRadius.all(Radius.circular(25)),
      );
  static const buttonColor = Colors.grey;
  static final buttonStyle = OutlinedButton.styleFrom(
    side: const BorderSide(width: 1, color: color),
    padding: const EdgeInsets.all(10),
    primary: color,
  );
}
