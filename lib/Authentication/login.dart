import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:std_ass/Authentication/function/auth_fn.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String fullname = '';
  bool login = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Join us',
          style: GoogleFonts.lato(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 229, 229, 229),
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10.0,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ======== Full Name ========
                login
                    ? Container()
                    : TextFormField(
                        key: ValueKey('Fullname'),
                        decoration: InputDecoration(
                          hintText: 'Enter Full Name',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Full Name';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          setState(() {
                            fullname = value!;
                          });
                        },
                      ),

                // ======== Email ========
                TextFormField(
                  key: ValueKey('email'),
                  decoration: InputDecoration(
                    hintText: 'Enter Email',
                  ),
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Please Enter valid Email';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    setState(() {
                      email = value!;
                    });
                  },
                ),
                // ======== Password ========
                TextFormField(
                  key: ValueKey('password'),
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Enter Password',
                  ),
                  validator: (value) {
                    if (value!.length < 6) {
                      return 'Please Enter Password of min length 6';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    setState(() {
                      password = value!;
                    });
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 55,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          login
                              ? AuthServices.signinUser(
                                  email, password, context)
                              : AuthServices.signupUser(
                                  email, password, fullname, context);
                        }
                      },
                      child: Text(login ? 'Login' : 'Signup')),
                ),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {
                      setState(() {
                        login = !login;
                      });
                    },
                    child: Text(login
                        ? "Don't have an account? Signup"
                        : "Already have an account? Login"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
