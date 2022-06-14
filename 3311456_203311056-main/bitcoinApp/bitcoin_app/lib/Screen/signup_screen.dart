import 'package:bitcoin_app/Model/firebase_user_model.dart';
import 'package:bitcoin_app/services/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late UserModel newUser;
  late FireAuth _auth;
  @override
  void initState() {
    super.initState();
    _auth = FireAuth();
    newUser = UserModel.empty();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Create an account"),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "geçrli bir değer giriniz!!";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    newUser.name = value;
                  },
                  decoration: const InputDecoration(label: Text("Name")),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  onSaved: (value) {
                    newUser.surName = value;
                  },
                  decoration: const InputDecoration(label: Text("Sur Name")),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  onSaved: (value) {
                    newUser.birthDay = value;
                  },
                  decoration: const InputDecoration(label: Text("birth Day")),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  onSaved: (value) {
                    newUser.telphone = value;
                  },
                  decoration:
                      const InputDecoration(label: Text("Phone Number")),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  onSaved: (value) {
                    newUser.gmail = value;
                  },
                  decoration: const InputDecoration(label: Text("e-mail")),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  onSaved: (value) {
                    newUser.password = value;
                  },
                  decoration: const InputDecoration(label: Text("password")),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();

                      _auth.createPerson(newUser);
                    }
                  },
                  child: const Text("Sign up"))
            ]),
          ),
        ));
  }
}
