import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_coba_api/network_http.dart';

class NetworkingHttp extends StatefulWidget {
  NetworkingHttp({super.key});

  @override
  State<NetworkingHttp> createState() => _NetworkingHttpState();
}

class _NetworkingHttpState extends State<NetworkingHttp> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final nama = TextEditingController();
    final email = TextEditingController();
    final gender = TextEditingController();

    // Future<http.Response> getData() async {
    //   var result = await http
    //       .get(Uri.parse("http://192.168.0.123:8082/api/user/getAll"));
    //   print(result.body);
    //   setState(() {
    //     result;
    //   });
    //   return result;
    // }

    // var data = getData();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Dashboard"),
          actions: const [],
        ),
        body: Container(
          child: UsingTheData(),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            // postData();
            showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      title: Center(
                        child: Text("Tambah data"),
                      ),
                      content: Container(
                        padding: const EdgeInsets.all(10),
                        // width: 20,
                        // height: 200,

                        child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  controller: nama,
                                  validator: ((value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter some name";
                                    }
                                    return null;
                                  }),
                                  decoration: InputDecoration(
                                    labelText: "Name",
                                    icon: const Icon(
                                      Icons.person_add,
                                      size: 24.0,
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  controller: email,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please input your email";
                                    }
                                    if (!EmailValidator.validate(value)) {
                                      return "Please enter valid your email";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Gmail",
                                    icon: const Icon(
                                      Icons.email,
                                      size: 24.0,
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  controller: gender,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please input your gender";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Gander",
                                    icon: const Icon(
                                      Icons.male_outlined,
                                      size: 24.0,
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                      actions: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.greenAccent),
                          onPressed: (() {
                            if (_formKey.currentState!.validate())
                              setState(() {
                                postData({
                                  "nama": nama.text,
                                  "email": email.text,
                                  "gender": gender.text
                                });
                                nama.clear();
                                email.clear();
                                gender.clear();
                                Navigator.of(context).pop();
                              });
                          }),
                          child: Text("Tambah"),
                        )
                      ],
                    ));
          },
        ),
      ),
    );
  }
}

class UsingTheData extends StatefulWidget {
  const UsingTheData({super.key});

  @override
  State<UsingTheData> createState() => _UsingTheDataState();
}

class _UsingTheDataState extends State<UsingTheData> {
  Future<http.Response> getData() async {
    var result =
        await http.get(Uri.parse("http://192.168.0.123:8082/api/user/getAll"));
    print(result.body);
    setState(() {
      result;
    });
    return result;
  }

  // var data = getData();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final namaEdit = TextEditingController();
    final emailEdit = TextEditingController();
    final genderEdit = TextEditingController();
    return FutureBuilder(
      future: getData().then((value) => value.body),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<dynamic> decoded = jsonDecode(snapshot.data!);
          return ListView.builder(
            itemCount: decoded.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  child: Text("${decoded[index]["nama"]}"),
                ),
                title: Text("${decoded[index]["nama"]}"),
                subtitle: Text("${decoded[index]["email"]}"),
                onTap: () {},
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        namaEdit.text = decoded[index]["nama"];
                        emailEdit.text = decoded[index]["email"];
                        genderEdit.text = decoded[index]["gender"];
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  title: Center(
                                    child: Text("Edit Data"),
                                  ),
                                  content: Container(
                                    padding: const EdgeInsets.all(10),
                                    // width: 20,
                                    // height: 200,
                                    child: Form(
                                        key: _formKey,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextFormField(
                                              controller: namaEdit,
                                              validator: ((value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "Please enter some name";
                                                }
                                                return null;
                                              }),
                                              decoration: InputDecoration(
                                                labelText: "Nama",
                                                icon: const Icon(
                                                  Icons.person_add,
                                                  size: 24.0,
                                                ),
                                              ),
                                            ),
                                            TextFormField(
                                              controller: emailEdit,
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "Please input your email";
                                                }
                                                if (!EmailValidator.validate(
                                                    value)) {
                                                  return "Please enter valid your email";
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                labelText: "Email",
                                                icon: const Icon(
                                                  Icons.email,
                                                  size: 24.0,
                                                ),
                                              ),
                                            ),
                                            TextFormField(
                                              controller: genderEdit,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "Please input your gender";
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                labelText: "Gender",
                                                icon: const Icon(
                                                  Icons.male,
                                                  size: 24.0,
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.greenAccent),
                                      onPressed: (() {
                                        setState(() {
                                          updateData(decoded[index]["id"], {
                                            "nama": namaEdit.text,
                                            "email": emailEdit.text,
                                            "gender": genderEdit
                                          });
                                          namaEdit.clear();
                                          emailEdit.clear();
                                          genderEdit.clear();
                                          Navigator.of(context).pop();
                                        });
                                      }),
                                      child: Text("Simpan Perubahan"),
                                    ),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.redAccent),
                                        onPressed: (() =>
                                            Navigator.pop(context, "Cancel")),
                                        child: Text("Cancel")),
                                  ],
                                ));
                        // updateData(decoded[index]["id"], {"name": "jhon"});
                      },
                      icon: const Icon(
                        Icons.edit,
                        size: 24.0,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        deleteData(decoded[index]["id"]);
                      },
                      icon: const Icon(
                        Icons.delete,
                        size: 24.0,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
