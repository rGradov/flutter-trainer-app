import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:workout_app/const/const.dart';
import 'package:workout_app/shared/hamburgermenu.dart';
import 'package:easy_localization/easy_localization.dart';

class BodyEvent extends StatefulWidget {
  @override
  _BodyEventState createState() => _BodyEventState();
}

class _BodyEventState extends State<BodyEvent> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Widget _inputName() {
      return Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: TextFormField(
          controller: _nameController,
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

    Widget _button(void func()) {
      return RaisedButton(
          splashColor: Colors.white,
          highlightColor: Colors.white,
          color: MainColor,
          child: Text("${"login-btn-text".tr().toString()}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              )),
          onPressed: () async {
            print(_nameController.text);
          });
    }

    Widget _form(String lable) {
      return Form(
        // autovalidate: true,
        key: formkey,
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(bottom: 20, top: 10),
                child: _inputName()),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: _button(() {}),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            _form(
              'register',
            ),
          ],
        ),
      ),
    );
  }
}
