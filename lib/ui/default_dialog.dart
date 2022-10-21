import 'package:citysight_app/pages/home.dart';
import 'package:flutter/material.dart';

class NeedAuth{
  NeedAuth(this.context);

  BuildContext context;
  
  void start(){
    showDialog(
      context: context, 
      builder: ((context) {
        return AlertDialog(
          title: Text("Вход"),
          content: Text("Чтобы совершить данное действие, вам нужно авторизоваться."),
          actions: [
            ElevatedButton(onPressed: (){
              Navigator.of(context).pop();
              Home.selectedIndex.value = 3;
            }, child: Text("Войти"),),
            ElevatedButton(onPressed: (){Navigator.of(context).pop();}, child: Text("Отмена"),)
          ],
        );
      }));
  }
}