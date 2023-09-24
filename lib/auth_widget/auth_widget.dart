import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import '../base/shared.dart';
import '../models/transactions_item.dart';
import '../redux/app_state.dart';
import '../redux/reducers.dart';
import '../redux/sharedPrefs_middleware.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({super.key});

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  @override
  Widget build(BuildContext context) {

    return const SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 237, 237, 237),
        body: _HeaderWidget(),
      ),
    );
  }
}

class _HeaderWidget extends StatefulWidget {
  const _HeaderWidget({Key? key}) : super(key: key);

  @override
  State<_HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<_HeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            height: 80,
            decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(20, 0, 0, 0),
                    blurRadius: 40,
                  ),
                ],
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            child: const Center(
                child: Text(
              "Позволь себе управлять своими транзакциями",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ))),
        _LoginField(),
      ],
    );
  }
}

class _LoginField extends StatefulWidget {
  const _LoginField({Key? key}) : super(key: key);

  @override
  _LoginFieldState createState() => _LoginFieldState();
}

class _LoginFieldState extends State<_LoginField> {

  String error = '';

  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 45, right: 45),
            child: Text(
              "Вход",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 15),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(left: 45, right: 45),
            child: TextFormField(
              style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 17),
              keyboardType: TextInputType.emailAddress,
              controller: loginController,
              decoration: const InputDecoration(
                labelText: "Логин",
                hintText: "admin",
                // isCollapsed: true,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 2),
                helperStyle: TextStyle(
                  letterSpacing: 0.4,
                  height: 0.7,
                ),
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Color.fromARGB(150, 0, 0, 0),
                  fontSize: 18,
                ),
                border: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(150, 0, 0, 0))),
                focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(150, 0, 0, 0))),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 45, right: 45),
            child: TextFormField(
              style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 17),
              keyboardType: TextInputType.emailAddress,
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: "Пароль",
                hintText: "1234",
                // isCollapsed: true,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 2),
                helperStyle: TextStyle(
                  letterSpacing: 0.4,
                  height: 0.7,
                ),
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Color.fromARGB(150, 0, 0, 0),
                  fontSize: 18,
                ),
                border: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(150, 0, 0, 0))),
                focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(150, 0, 0, 0))),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            error,
            style: TextStyle(color: Colors.red),
          ),
          const SizedBox(height: 80),
          Padding(
            padding: const EdgeInsets.only(bottom: 0.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () async {
                  var pass = await Shared.getPassword();
                  if (loginController.text.isEmpty ||
                      passwordController.text.isEmpty) {
                    error = "Заполните все поля";
                    setState(() {});
                  } else if (passwordController.text != pass) {
                    error = "Не верный пароль!";
                    setState(() {});
                  } else {
                    final Store<AppState> store = Store(
                      appStateReducers,
                      middleware: [SharedPrefsMiddleware()],
                      initialState: AppState(
                          const [TransactionsItem('', 0, 0, 0, 0, '')]),
                    );
                    Navigator.pushReplacementNamed(context, "/transaction");
                  }
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    backgroundColor: MaterialStateProperty.all(Colors.grey),
                    minimumSize:
                        MaterialStateProperty.all(const Size(314, 50))),
                child: const Text(
                  "Войти",
                  style: TextStyle(
                      letterSpacing: 0.25, fontSize: 17, color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(height: 7),
          Padding(
            padding: const EdgeInsets.only(left: 45, right: 45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Нет аккаунта? ",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
                  textAlign: TextAlign.center,
                ),
                InkWell(
                  child: const Text(
                    "Зарегистрироваться",
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                        color: Colors.blue,
                        decoration: TextDecoration.underline),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

// class _ErrorMessageWidget extends StatelessWidget {
//   const _ErrorMessageWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final errorMessage = context.select((AuthViewModel m) => m.errorMessage);
//     if (errorMessage == null) return const SizedBox.shrink();
//
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 20),
//       child: Text(
//         errorMessage,
//         style: const TextStyle(
//           fontSize: 14,
//           color: Colors.red,
//         ),
//       ),
//     );
//   }
// }
