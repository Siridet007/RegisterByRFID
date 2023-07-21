// ignore_for_file: avoid_unnecessary_containers, unused_local_variable, unnecessary_new, non_constant_identifier_names, avoid_print, unnecessary_brace_in_string_interps, prefer_typing_uninitialized_variables, sized_box_for_whitespace, use_build_context_synchronously

import 'dart:async';

import 'package:duration_button/duration_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:personal_register/model/model.dart';
import 'package:dio/dio.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  List test = [];
  List<PersonnalRegister>? list = [];
  List<ListRegister>? myList = [];
  List<SerchByCardNew>? serchList = [];
  late FocusNode myscan = FocusNode();
  var img;

  final FocusNode _focusNode = FocusNode();
  // The message to display.
  var aaa = '';

  var RFID = "0000843023";
  List? info = [];
  String rfcode = '';
  late Timer _timer;

  //late Future<List<ListRegister>> regisList;

  TextEditingController textEditingController = new TextEditingController();

/*
  Future<List<ListRegister>> fetchRegister() async{
    final res = await http.get(Uri.parse("http://172.2.0.14/security/personal_register.php?select=register_list"));
    if(res.statusCode == 200){
      final List<dynamic> regisJsonlist = jsonDecode(res.body);
      return regisJsonlist.map((json) => ListRegister.fromJson(json)).toList();
    }else{
      throw Exception("Faild to fetch");
    }
  }
*/
  Future showCustomDialog(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: const Text('ไม่พบการ์ดนี้ในแฟ้มข้อมูล กรุณาตรวจสอบบัตรและรูดใหม่อีกครั้ง'),
          actions: [
            DurationButton(
              duration: const Duration(seconds: 3),
              onPressed: () => Navigator.of(context).pop(),
              backgroundColor: Color.fromARGB(255, 202, 83, 123),
              splashFactory: NoSplash.splashFactory,
              child: const Text("ใน 3 วินาที"),
            ),
          ],
        ),
      );
  //New Product
  Future<List<PersonnalRegister>?> getData(String detail) async {
    FormData formData = new FormData.fromMap(
      {"select": "cardcode", "cardcode": RFID},
    );

    String domain2 =
        "http://172.2.0.14/security/personal_register.php?select=cardcode&cardcode=$detail";

    String urlAPI = domain2;

    Response response = await Dio().post(urlAPI);
    //print('res ${response}');
    if (response.data == null) {
      //print('sdsd');
      showCustomDialog(context);
    } else {
      var result = PersonnalRegister.fromJsonList(response.data);
      //print(result);
      return result;
    }
  }

  Future<List<ListRegister>?> listData() async {
    FormData formData = new FormData.fromMap(
      {"select": "cardcode", "cardcode": RFID},
    );

    String domain2 =
        "http://172.2.0.14/security/personal_register.php?select=register_list";

    String urlAPI = domain2;

    Response response = await Dio().post(urlAPI);
    print('ddd ${response.data}');

    var result = ListRegister.fromJsonList(response.data);
    //print("fsdf $result");
    return result;
  }

  Future<List?> addData(String detail) async {
    String domain2 =
        "http://172.2.0.14/security/personal_register.php?select=add_data&cardcode=$detail";

    String urlAPI = domain2;

    Response response = await Dio().post(urlAPI);
    var result = PersonnalRegister.fromJsonList(response.data);
    //print(response.data);
    return result;
  }

  Future<List<SerchByCardNew>?> serchData(String num) async {
    FormData formData = new FormData.fromMap(
      {"select": "cardcode", "cardcode": RFID},
    );

    String domain2 =
        "http://172.2.0.14/security/personal_register.php?select=staff&code=$num";

    String urlAPI = domain2;

    Response response = await Dio().post(urlAPI);
    //print("fds ${response.data}");
    var result = SerchByCardNew.fromJsonList(response.data);
    return result;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    listData().then((value) {
      setState(() {
        myList = value;
      });
    });
    //regisList = fetchRegister();
  }

  void _onRawKeyEvent(RawKeyEvent event) {
    if (event.character != null) {
      if (event.character.toString() != "") {
        rfcode = rfcode + event.character.toString();
      }
      //print('fsdfd ${event.logicalKey.keyLabel}');
      if ((event.logicalKey.keyLabel == "Enter") ||
          ((event.logicalKey.keyLabel == "Select"))) {
        setState(() {
          rfcode = rfcode.replaceAll('\n', "");
          //checkProduct(rfcode);

          var sss = '${rfcode}s';
          //print(sss.toString());
          var a = sss.substring(0, 10);
          //print('aaa${a}');
          
          getData(a).then((value) {
            //addData(a);
            rfcode = "";
            if(value == null){
              
            }else{
              addData(a);
              //print('wewew');
            }
            list = value;
            //print('sdsd');
            var bbb = list!.last.code.toString();
            img = bbb;
            serchData(bbb).then((value) {
              setState(() {
                serchList = value;
                myscan.requestFocus();
                listData().then((value) {
                  setState(() {
                    myList = value;
                  });
                });
              });
            });
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    var formatTime = DateFormat('HH:mm').format(now);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              //decoration: BoxDecoration(border: Border.all(color: Colors.black)),
              width: 80,
              height: 10,
            ),
            Container(
              child: const Text(
                'Personnal Register',
                style: TextStyle(fontFamily: 'cm'),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 50),
              child: Text(
                formatTime,
                style: const TextStyle(fontFamily: 'cm'),
              ),
            ),
          ],
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 202, 83, 123),
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(top: 10),
        //decoration: BoxDecoration(border: Border.all(color: Colors.red)),
        alignment: Alignment.center,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.49,
                    height: MediaQuery.of(context).size.height * .92,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    child: myList!.isEmpty
                        ? Center(
                            child: LoadingAnimationWidget.inkDrop(
                                color: Colors.blue, size: 100),
                          )
                        : ListView.builder(
                            itemCount: myList!.length,
                            itemBuilder: (context, index) {
                              //String? time = myList![index].doctime;
                              DateTime tempDate =
                                  new DateFormat("yyyy-MM-dd hh:mm:ss")
                                      .parse(myList![index].doctime.toString());
                              var time = DateFormat('dd-MM-yyyy HH:mm')
                                  .format(tempDate);
                              var pic = "${myList![index].code}";

                              //bool con = pic.contains('p') || pic.contains("P");
                              /*
                              var infoPic;
                              if (con == true) {
                                print('dsas');
                                infoPic = Image.asset('assets/images/noPicture.png',fit: BoxFit.cover,);
                              } else {
                                infoPic = Image.network(
                                    'http://172.2.200.15/fos3/personpic/${pic}.jpg',fit: BoxFit.cover,);
                                  
                              }
                              print(infoPic);

                              var pic2 = "F00046";
                              */
                              //print(tempDate);
                              //print(tt);
                              return ListTile(
                                title: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  height: 55,
                                  child: Row(
                                    children: [
                                      const Padding(
                                          padding: EdgeInsets.only(left: 10)),
                                      Container(
                                        //decoration: BoxDecoration(border: Border.all(color: Colors.black)),

                                        width: 60,
                                        child: ClipOval(
                                          child: //infoPic,
                                              Image.network(
                                            'http://172.2.200.15/fos3/personpic/${pic}.jpg',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.only(left: 50)),
                                      Container(
                                        //decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                                        width: 70,
                                        child: Text(
                                          '${myList?[index].code}',
                                          style:
                                              const TextStyle(fontFamily: 'cm'),
                                        ),
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.only(left: 30)),
                                      Container(
                                        //decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                                        width: 70,
                                        child: Text(
                                          '${myList?[index].nameT}',
                                          style:
                                              const TextStyle(fontFamily: 'pg'),
                                        ),
                                      ),
                                      Container(
                                        //decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                                        width: 100,
                                        child: Text(
                                          '${myList?[index].lNameT}',
                                          style:
                                              const TextStyle(fontFamily: 'pg'),
                                        ),
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.only(left: 30)),
                                      Container(
                                        child: Text(time,
                                            style: const TextStyle(
                                                fontFamily: 'cm')),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height * .92,
                    width: MediaQuery.of(context).size.width * 0.49,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.red)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Column(
                        children: [
                          Container(
                            width: 100,
                            height: 20,
                            //decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                            child: RawKeyboardListener(
                              focusNode: myscan,
                              autofocus: true,
                              onKey: _onRawKeyEvent,
                              child: const Text(''),
                            ),
                          ),
                          /*
                          SizedBox(
                            width: 100,
                            child: TextField(
                              autofocus: true,
                              focusNode: myscan,
                              controller: textEditingController,
                              decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                              ),
                              onSubmitted: (value) {
                                setState(() {
                                  aaa = value;
                                  //print("sss==>" + aaa);
                                  addData(aaa);
                                  getData(aaa).then((value) {
                                    list = value;
                                    var bbb = list!.last.code.toString();
                                    img = bbb;
                                    //print('img===' + img);
                                    serchData(bbb).then((value) {
                                      setState(() {
                                        serchList = value;
                                        //print("HHH====>");
                                        myscan.requestFocus();
                                        listData().then((value) {
                                          setState(() {
                                            myList = value;
                                          });
                                        });
                                      });
                                    });
                                  });
                                });

                                textEditingController.clear();
                              },
                            ),
                          ),*/
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .85,
                                width: MediaQuery.of(context).size.width * .48,
                                child: serchList!.isEmpty
                                    ? Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .78,
                                            child: Column(
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              width: 300,
                                                              height: 300,
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .black)),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: const [
                                                                  Text(
                                                                      'ยังไม่มีข้อมูล'),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 100,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                width: 100,
                                                                child: const Text(
                                                                    'รหัส:',
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'pg')),
                                                              ),
                                                              const Text(
                                                                  'ยังไม่มีข้อมูล',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'pg')),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                width: 100,
                                                                child: const Text(
                                                                    'ชื่อ:',
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'pg')),
                                                              ),
                                                              const Text(
                                                                  'ยังไม่มีข้อมูล',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'pg')),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                width: 100,
                                                                child: const Text(
                                                                    'ฝ่าย:',
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'pg')),
                                                              ),
                                                              const Text(
                                                                  'ยังไม่มีข้อมูล',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'pg')),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    : ListView.builder(
                                        itemCount: serchList!.length,
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                            title: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                    child: Row(
                                                                      children: [
                                                                        Container(
                                                                          width:
                                                                              300,
                                                                          height:
                                                                              300,
                                                                          decoration: BoxDecoration(
                                                                              border: Border.all(color: Colors.black),
                                                                              borderRadius: const BorderRadius.all(Radius.circular(5))),
                                                                          child: Image.network(
                                                                              'http://172.2.200.15/fos3/personpic/${serchList![index].code}.jpg',
                                                                              fit: BoxFit.cover),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 100,
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Container(
                                                                child: Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Container(
                                                                      width:
                                                                          100,
                                                                      child: const Text(
                                                                          'รหัส:',
                                                                          style:
                                                                              TextStyle(fontFamily: 'pg',fontSize: 25)),
                                                                    ),
                                                                    Text(
                                                                        '${serchList![index].code}',
                                                                        style: const TextStyle(
                                                                            fontFamily:
                                                                                'cm',fontSize: 25)),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 20,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      width:
                                                                          100,
                                                                      child: const Text(
                                                                          'ชื่อ:',
                                                                          style:
                                                                              TextStyle(fontFamily: 'pg',fontSize: 25)),
                                                                    ),
                                                                    Text(
                                                                        '${serchList![index].name}',
                                                                        style: const TextStyle(
                                                                            fontFamily:
                                                                                'pg',fontSize: 25)),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 20,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      width:
                                                                          100,
                                                                      child: const Text(
                                                                          'ฝ่าย:',
                                                                          style:
                                                                              TextStyle(fontFamily: 'pg',fontSize: 25)),
                                                                    ),
                                                                    Text(
                                                                        '${serchList![index].deptName}',
                                                                        style: const TextStyle(
                                                                            fontFamily:
                                                                                'pg',fontSize: 25)),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
