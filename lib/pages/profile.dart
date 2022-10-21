import 'dart:convert';

import 'package:citysight_app/network/network.dart';
import 'package:citysight_app/utils/system_prefs.dart';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final SystemPrefs _prefs = SystemPrefs();
  var dio = Dio();
  Widget fragment = Positioned.fill(child: Align(alignment: Alignment.bottomCenter, child: LinearProgressIndicator(color: Colors.indigo.shade800),),);

  TextEditingController login = TextEditingController();
  TextEditingController pass = TextEditingController();

  String? error;

  bool isHidden = true;

  void checkAuth() async {
    if(await _prefs.getAuthToken() == ""){
      setState(() {
        fragment = AutofillGroup(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 0,
                child: Container(
                  margin: const EdgeInsets.only(top: 30, left: 40, right: 40),
                  child: Image.asset("images/full_logo.png",)
                )
              ),
              const SizedBox(height: 16,),
              Expanded(
                flex: 0,
                child: Container(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  child: TextFormField(
                    controller: login,
                    textInputAction: TextInputAction.next,
                    style: TextStyle(color: Colors.black87),
                    decoration: InputDecoration(
                      errorText: error,
                      labelStyle: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).colorScheme.inversePrimary),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFE5E1E1)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Почта или логин',
                      hintText: 'Почта или логин'
                    ),
                    autofillHints: const [AutofillHints.email],
                    // onEditingComplete: () => TextInput.finishAutofillContext(),
                  ),
                )
              ),
              const SizedBox(height: 16,),
              Expanded(
                flex: 0,
                child: Container(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  child: TextFormField(
                    controller: pass,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: isHidden,
                    style: TextStyle(color: Colors.black87),
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).colorScheme.inversePrimary),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFE5E1E1)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Пароль',
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: (){setState(() => isHidden = !isHidden);}, icon: isHidden ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility)
                      )
                    ),
                    autofillHints: const [AutofillHints.password],
                    // onEditingComplete: () => TextInput.finishAutofillContext(),
                  ),
                ),
              ),
              Expanded(
                flex: 0,
                child: Container(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  child: ElevatedButton(
                    onPressed: () async {
                      final response = await http.post(
                          Uri.parse('${Network.defaultUrl}/api/v1/auth/login'),
                          headers: <String, String>{
                            'Content-Type': 'application/json',
                            'Accept': 'application/json',
                            'Access-Control_Allow_Origin': '*'
                          },
                          body: jsonEncode(<String, String>{
                            'username': login.text,
                            'password': pass.text
                          }),
                        );
                      if (response.statusCode == 200) {
                        setState(() async {
                          await _prefs.setAuthToken("cisi_${jsonDecode(response.body)["token"]}");
                          checkAuth();
                        });
                      // } else if(response.statusCode == 400) {
                      } else {
                        setState(() {
                          error = "Неверный логин или пароль";
                        });
                      }
                    }, 
                    child: Text("Войти"), 
                    style: ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(200),
                        ),
                      ),
                    ),
                  ),
                )
              )
            ],
          )
        );
      });
    }else{
      setState(() {
        fragment = Center(
          child: Column(
            children: [
              const Expanded(
                flex: 0,
                child: Text("Profile")
              ),
              Expanded(
                flex: 0,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() async {
                      await _prefs.clearAuthToken();
                      checkAuth();
                    });
                  },
                  child: const Text("Exit"),
                )
              )
            ],
          ),
        );
      });
    }
  }

  @override
  void initState() {
    checkAuth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: fragment,
      )
    );
  }
}