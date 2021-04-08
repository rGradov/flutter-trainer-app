import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workout_app/const/const.dart';

Future list() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final String token = sharedPreferences.getString("token");
  // print(token);
  final resp = await http.get(
    Uri.http(ApiUrl, 'api/user'),
    headers: <String, String>{
      HttpHeaders.authorizationHeader: "Bearer ${token}",
    },
  );
  print('Response status: ${resp.statusCode}');
  print('Response body: ${resp.body}');
  // print(resp.body);
  return json.decode(resp.body);
}

Future falseInvite(String name, bool accept) async {
  print(name);
  String trainer = name;
  bool st = accept;
  print('status:${st}');
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final String token = sharedPreferences.getString("token");
  final resp = await http.put(
    Uri.http(ApiUrl, 'api/invite/action'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: "Bearer ${token}",
    },
    body: jsonEncode({'username': trainer, 'accept': false}),
  );
  print('Response status: ${resp.statusCode}');
  print('Response body: ${resp.body}');
  return resp.statusCode;
}

Future TrueInvite(String name, bool accept) async {
  print(name);
  String trainer = name;
  bool st = accept;
  print('status:${st}');
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final String token = sharedPreferences.getString("token");
  final resp = await http.put(
    Uri.http(ApiUrl, 'api/invite/action'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: "Bearer ${token}",
    },
    body: jsonEncode({'username': trainer, 'accept': true}),
  );
  print('Response status: ${resp.statusCode}');
  print('Response body: ${resp.body}');
  return resp.statusCode;
}

class NontificBody extends StatefulWidget {
  @override
  _NontificBodyState createState() => _NontificBodyState();
}

class _NontificBodyState extends State<NontificBody> {
  List _items = [];
  List _acceptedInvitesFrom = [];
  List _declinedInvitesFrom = [];
  var _ShowHistory = false;
  var _UnshowCircle = false;
  @override
  void initState() {
    list().then((value) => {
          setState(() {
            _items = value['invitesFrom'];
            _acceptedInvitesFrom = value['acceptedInvitesFrom'];
            _declinedInvitesFrom = value['declinedInvitesFrom'];
            _UnshowCircle = true;
          }),

          print(_acceptedInvitesFrom),
          print(_declinedInvitesFrom.length),
          if (_declinedInvitesFrom.length == 0)
            {
              _ShowHistory = true,
            },

          // print(_acceptInvite)
        });
    // _insertSingleItem();
    super.initState();
  }

  void _insertSingleItem() {
    String newItem = "Planet";
    // Arbitrary location for demonstration purposes
    int insertIndex = _acceptedInvitesFrom.length;
    // Add the item to the data list.
    for (int i = 0; i < _acceptedInvitesFrom.length; i++) {
      _acceptedInvitesFrom.insert(i, newItem);
    }
    // _acceptedInvitesFrom.insert( insertIndex,newItem);
    // Add the item visually to the AnimatedList.
    // _items.currentState.insertItem(insertIndex);
  }

  Widget buildListBody(BuildContext ctxt, int index, Color cl, List array) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 8),
      child: Container(
        width: MediaQuery.of(context).size.width,
        // height: ,
        decoration: BoxDecoration(
            color: cl,
            border: Border.all(
              color: cl,
            )),
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(array[index],
                  style: TextStyle(color: Colors.white, fontSize: 15)),
              Text('')
            ],
          ),
        ),
      ),
    );
  }

  Widget slideRightBackground() {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Container(
        color: Colors.green,
        child: Align(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.edit,
                color: Colors.white,
              ),
              Text(
                "apply-btn".tr().toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          alignment: Alignment.centerLeft,
        ),
      ),
    );
  }

  Widget slideLeftBackground() {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Container(
        color: Colors.red,
        child: Align(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Icon(
                Icons.delete,
                color: Colors.white,
              ),
              Text(
                "delete-btn".tr().toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.right,
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          alignment: Alignment.centerRight,
        ),
      ),
    );
  }

  Widget buildBody(BuildContext ctxt, int index) {
    return Dismissible(
      key: Key(_items[index]),
      background: slideRightBackground(),
      secondaryBackground: slideLeftBackground(),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          final bool res = await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content:
                      Text("${"cancel".tr().toString()} ${_items[index]}?"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text(
                        "cancel-btn".tr().toString(),
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    FlatButton(
                      child: Text(
                        "delete-btn".tr().toString(),
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {
                        // TODO: Delete the item from DB etc..
                        falseInvite(_items[index], false);
                        setState(() {
                          _items.removeAt(index);
                          list().then(
                            (value) => setState(() {
                              // _items = value['invitesFrom'];
                              // _acceptedInvitesFrom =
                              // value['acceptedInvitesFrom'];
                              _declinedInvitesFrom =
                                  value['declinedInvitesFrom'];
                              // _UnshowCircle = true;
                            }),
                          );
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              });
          return res;
        } else {
          final bool res = await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Text("${"apply".tr().toString()} ${_items[index]}?"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text(
                        "cancel-btn".tr().toString(),
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    FlatButton(
                      child: Text(
                        "apply-btn".tr().toString(),
                        style: TextStyle(color: MainColor),
                      ),
                      onPressed: () async {
                        // TODO: Delete the item from DB etc..
                        TrueInvite(_items[index], true);
                        setState(() {
                          _items.removeAt(index);
                          list().then(
                            (value) => setState(() {
                              // _items = value['invitesFrom'];
                              _acceptedInvitesFrom =
                                  value['acceptedInvitesFrom'];
                              // _declinedInvitesFrom = value['declinedInvitesFrom'];
                              _UnshowCircle = true;
                            }),
                          );
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              });
        }
      },
      child: InkWell(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Container(
            width: MediaQuery.of(context).size.width,
            // height: 50,
            decoration: BoxDecoration(
                color: MainColor,
                border: Border.all(
                  color: MainColor,
                )),
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_items[index],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      )),
                  Text('')
                ],
              ),
            ),
          ),
        ),
        onTap: () {
          print('${index} tap');
        },
      ),
    );
  }

  Widget _history(styleHeader) {
    return Text(
      'history'.tr().toString(),
      style: styleHeader,
    );
  }

  Widget build(BuildContext context) {
    var styleHeader = TextStyle(
      color: Colors.white,
      fontSize: 30,
    );
    if (_UnshowCircle) {
      return _items.isNotEmpty
          ? Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "invite-field".tr().toString(),
                      style: styleHeader,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      flex: 3,
                      child: ListView.builder(
                        itemCount: _items.length,
                        itemBuilder: (BuildContext ctxt, int index) =>
                            buildBody(ctxt, index),
                      ),
                    ),
                    //impliment to this
                    Expanded(
                      flex: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _history(styleHeader),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: Dismissible(
                              key: UniqueKey(),
                              onDismissed: (direction) {
                                print('swipe');
                                setState(() {
                                  if (_declinedInvitesFrom.length != 0) {
                                    _ShowHistory = !_ShowHistory;
                                  } else {
                                    _ShowHistory = _ShowHistory;
                                  }
                                });
                              },
                              child: _ShowHistory
                                  ? Column(
                                    children: [
                                      Expanded(
                                          child: ListView.builder(
                                            itemCount: _acceptedInvitesFrom.length,
                                            itemBuilder:
                                                (BuildContext ctxt, int index) =>
                                                    buildListBody(
                                                        ctxt,
                                                        index,
                                                        MainColor,
                                                        _acceptedInvitesFrom),
                                          ),
                                        ),
                                    ],
                                  )
                                  : Column(
                                    children: [
                                      Expanded(
                                          // flex: 1,
                                          child: ListView.builder(
                                            itemCount: _acceptedInvitesFrom.length,
                                            itemBuilder:
                                                (BuildContext ctxt, int index) =>
                                                    buildListBody(
                                                        ctxt,
                                                        index,
                                                        Colors.red,
                                                        _declinedInvitesFrom),
                                          ),
                                        ),
                                    ],
                                  ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          //when null nontific
          : Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "invite-field".tr().toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        "empty-field".tr().toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    //this
                    Expanded(
                      flex: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _history(styleHeader),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: Dismissible(
                              key: UniqueKey(),
                              onDismissed: (direction) {
                                setState(() {
                                  if (_declinedInvitesFrom.length != 0) {
                                    _ShowHistory = !_ShowHistory;
                                  } else {
                                    _ShowHistory = _ShowHistory;
                                  }
                                  // if(_acceptedInvitesFrom.length !=0){}
                                });
                              },
                              child: _ShowHistory
                                  ? Column(
                                    children: [
                                      Expanded(
                                          child: ListView.builder(
                                            itemCount: _acceptedInvitesFrom.length,
                                            itemBuilder:
                                                (BuildContext ctxt, int index) =>
                                                    buildListBody(
                                                        ctxt,
                                                        index,
                                                        MainColor,
                                                        _acceptedInvitesFrom),
                                          ),
                                        ),
                                    ],
                                  )
                                  : Column(
                                    children: [
                                      Expanded(
                                          // flex: 1,
                                          child: ListView.builder(
                                            itemCount: _acceptedInvitesFrom.length,
                                            itemBuilder:
                                                (BuildContext ctxt, int index) =>
                                                    buildListBody(
                                                        ctxt,
                                                        index,
                                                        Colors.red,
                                                        _declinedInvitesFrom),
                                          ),
                                        ),
                                    ],
                                  ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
    } else {
      //work with this
      return Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "invite-field".tr().toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: CircularProgressIndicator(),
              ),
            ],
          ),
        ),
      );
    }
  }
}
