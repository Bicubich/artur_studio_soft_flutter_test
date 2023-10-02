import 'package:artur_studio_soft_flutter_test/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'providers/validation_provider.dart';
import 'widgets/my_button.dart';
import 'widgets/my_text_field.dart';

class AuthorizationPage extends StatefulWidget {
  AuthorizationPage({super.key});

  @override
  State<AuthorizationPage> createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  final _dateOfBirthdayController = TextEditingController();
  final _uidController = TextEditingController();

  List<TextEditingController> emptyTextFieldList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 24.0, left: 21, right: 21.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Добро пожаловать!",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.w700),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 4.0),
                        child: Text(
                          "Авторизация в приложении",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: MyTextField(
                          hintText: 'Логин',
                          controller: _loginController,
                          keyboardType: TextInputType.name,
                          maxLength: 15,
                          isEmpty:
                              emptyTextFieldList.contains(_loginController),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: MyTextField(
                          hintText: 'Пароль',
                          controller: _passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          maxLength: 25,
                          isEmpty:
                              emptyTextFieldList.contains(_passwordController),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: MyTextField(
                          hintText: 'Дата рождения',
                          controller: _dateOfBirthdayController,
                          keyboardType: TextInputType.datetime,
                          onTap: () async {
                            clictOnDateField(context);
                          },
                          isEmpty: emptyTextFieldList
                              .contains(_dateOfBirthdayController),
                          readOnly: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: MyTextField(
                          hintText: 'UID в игре',
                          controller: _uidController,
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                          isEmpty: emptyTextFieldList.contains(_uidController),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: MyButton(
                          text: 'Зарегистрироваться',
                          textColor: Colors.black,
                          fillColor: Colors.green,
                          borderColor: Colors.green,
                          onTab: () {
                            signUp(context);
                          },
                          textHorizontalPading: 50.0,
                          textVerticalPading: 20.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
      ),
    );
  }

  Future<void> clictOnDateField(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        _dateOfBirthdayController.text = formattedDate;
      });
    } else {
      print("Date is not selected");
    }
  }

  void signUp(BuildContext context) {
    emptyTextFieldList = [];
    String login = _loginController.text;
    String password = _passwordController.text;
    String date = _dateOfBirthdayController.text;
    String uid = _uidController.text;
    setState(() {
      if (login.isEmpty || password.isEmpty || date.isEmpty || uid.isEmpty) {
        showScaffoldMessenge(context, 'Не все поля заполнены');

        login.isEmpty ? emptyTextFieldList.add(_loginController) : null;
        password.isEmpty ? emptyTextFieldList.add(_passwordController) : null;
        date.isEmpty ? emptyTextFieldList.add(_dateOfBirthdayController) : null;
        uid.isEmpty ? emptyTextFieldList.add(_uidController) : null;
      } else if (!ValidationProvider().isLoginValid(login)) {
        login.isEmpty ? emptyTextFieldList.add(_loginController) : null;
        showScaffoldMessenge(
            context, 'Логин не должен содержать цифр. Минимум 5 символов');
      } else if (!ValidationProvider().isPasswordValid(password)) {
        password.isEmpty ? emptyTextFieldList.add(_passwordController) : null;
        showScaffoldMessenge(context,
            'Пароль должен содержать строчные и прописные буквы, цифры, спецсимволы. Минимум 8 символов');
      } else if (!ValidationProvider().isUIDValid(uid)) {
        uid.isEmpty ? emptyTextFieldList.add(_uidController) : null;
        showScaffoldMessenge(context, 'UID должен иметь 10-значное значение');
      } else {
        showScaffoldMessenge(context, 'Удачная регистрация!');
        _dateOfBirthdayController.text = '';
        _loginController.text = '';
        _passwordController.text = '';
        _uidController.text = '';
      }
    });
  }

  void showScaffoldMessenge(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
  }
}
