import 'dart:io';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:workout_app/const/const.dart';
import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workout_app/const/const.dart';
import 'package:http/http.dart' as http;

Future list() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final String token = sharedPreferences.getString("token");
  // print(token);
  final resp = await http.get(
    Uri.http(ApiUrl, 'api/user'),
    headers: <String, String>{
      HttpHeaders.authorizationHeader: "Bearer ${token}"
    },
  );
  print('Response status: ${resp.statusCode}');
  print('Response body: ${resp.body}');
  // print(resp.body);
  return json.decode(resp.body);
}

Future<String> postData(
  String userName,
) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final String token = sharedPreferences.getString("token");
  final resp = await http.put(
    Uri.http(ApiUrl, 'api/invite'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: "Bearer ${token}"
    },
    body: jsonEncode(<String, String>{
      'username': userName,
      'add': 'true',
    }),
  );
  print('Response status: ${resp.statusCode}');
  print('Response body: ${resp.body}');
  var jsonResponse = null;
  if (resp.statusCode == 200) {
    if (resp.body == 'Invite was sent') {
      jsonResponse = resp.body;
      return 'true';
    } else {
      return resp.body;
    }
  } else {
    return resp.body;
  }
}

class InviteBody extends StatefulWidget {
  @override
  _InviteBodyState createState() => _InviteBodyState();
}

class _InviteBodyState extends State<InviteBody> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController _userNameController = TextEditingController();
  List _items = ['', ''];
  bool status = true;
  Widget _inputUserName() {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: TextFormField(
        controller: _userNameController,
        obscureText: false,
        style: TextStyle(fontSize: 20, color: Colors.white),
        decoration: InputDecoration(
            hintStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white30),
            hintText: "hint-name".tr().toString(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MainColor, width: 3),
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MainColor30, width: 1)),
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: IconTheme(
                data: IconThemeData(color: Colors.white),
                child: Icon(Icons.account_circle),
              ),
            )),
        validator: MultiValidator([
          RequiredValidator(errorText: "erorr-req".tr().toString()),
          MinLengthValidator(2,
              errorText: "error-name-min-length".tr().toString()),
          MaxLengthValidator(15,
              errorText: "error-name-max-length".tr().toString())
        ]),
      ),
    );
  }

  Widget _ProgressButton() {
    return ProgressButton(
        defaultWidget: Text("invite-btn".tr().toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
            )),
        color: MainColor,
        progressWidget: const CircularProgressIndicator(
          backgroundColor: Colors.black,

          // valueColor: ,
        ),
        animate: true,
        // type: ProgressButtonType.Flat,
        onPressed: () async {
          if (formkey.currentState.validate()) {
            if (status == true) {
              setState(() {
                status = !status;
              });
              final body = await postData(
                _userNameController.text,
              );
              print(body);
              if (body == 'true') {
                setState(() {
                  status = !status;
                });
                list().then((value) => {
          setState(() {
            _items = value['invitesTo'];
          }),
          print(_items),
        });
              } else {
                setState(() {
                  status = !status;
                });
                final snackBar = SnackBar(
                  content: Text(body.toString().tr().toString()),
                  action: SnackBarAction(
                    label: 'ok'.tr().toString(),
                    onPressed: () {},
                    // formkey.currentState.reset();
                    // _pswdController.clear();
                  ),
                );

                // Find the ScaffoldMessenger in the widget tree
                // and use it to show a SnackBar.
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            } else {
              print('press');
            }
          }
        });
  }

  Widget _form() {
    return Form(
      key: formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Text('send-invite'.tr().toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20),),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20, top: 20),
            child: _inputUserName(),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Container(
              height: 50,
              // width: MediaQuery.of(context).size.width,
              child: _ProgressButton(),
            ),

          ),
          SizedBox(
            height: 20,
          ),
          Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  'history'.tr().toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    ),),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    list().then((value) => {
          setState(() {
            _items = value['invitesTo'];
          }),
          print(_items),
        });
    super.initState();
  }
Widget buildBody(BuildContext ctxt, int index) {
  return  Padding(
      padding: EdgeInsets.only(left: 20, right: 20,bottom: 8),
    child: Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
        color: MainColor,
        border: Border.all(
          color: MainColor,
        )
        
      ),
      child: Padding(
        padding: const EdgeInsets.only(top:10.0,left: 10,right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_items[index],style: TextStyle(color: Colors.white,fontSize: 15)),
            Text('')
          ],
        ),
      ),
    ),
  );
}
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _form(),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: _items.length,
                 itemBuilder: (BuildContext ctxt, int index) => buildBody(ctxt, index),
                  
                ),
          ),
        ],
      ),
    );
  }
}
