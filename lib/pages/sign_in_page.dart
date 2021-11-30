import 'package:admin_website/providers/sign_in/sign_in_cubit.dart';
import 'package:admin_website/providers/sign_in/sign_in_state.dart';
import 'package:admin_website/widgets/sign_in_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Welcome to Admin console Cinema Control System', style: Styles.header1),
                Text('Please enter your login and password', style: Styles.header2),
                SizedBox(height: 50),
                SizedBox(width: 300, child: SignInForm()),
                SizedBox(height: 300)
              ],
            ),
          ),
          Center(
            child: BlocBuilder<SignInCubit, SignInState>(
              builder: (context, state) {
                if (state is Empty) {
                  return const SizedBox();
                }

                return Container(
                  width: 350,
                  height: 500,
                  color: const Color.fromRGBO(255, 255, 255, 0),
                  child: Center(
                    child: state is Loading
                        ? const Padding(
                            padding: EdgeInsets.only(bottom: 170),
                            child: CircularProgressIndicator(color: Colors.grey),
                          )
                        : Container(
                            height: 200,
                            padding: const EdgeInsets.all(25),
                            margin: const EdgeInsets.only(bottom: 150),
                            decoration: Styles.messageDecoration,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  state is Error ? state.message : 'Вы успешно авторизованы!',
                                  style: Styles.message,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 10),
                                OutlinedButton(
                                  style: Styles.buttonStyle,
                                  onPressed: state is Loaded
                                      ? () {
                                          Navigator.pushNamed(context, '/console', arguments: {'user': state.user});
                                        }
                                      : () {
                                          BlocProvider.of<SignInCubit>(context).resignIn();
                                        },
                                  child: SizedBox(
                                    width: 300,
                                    child: Center(
                                      child: Text(
                                        state is Error ? 'Вернуться на страницу авторизации' : 'Перейти в консоль',
                                        style: Styles.message,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class Styles {
  static const color = Colors.grey;
  static const header1 = TextStyle(fontSize: 36, color: color);
  static const header2 = TextStyle(fontSize: 28, color: color);
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
