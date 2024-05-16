// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:route_between_two_points/config/config.dart';
import 'package:route_between_two_points/config/data.dart';
import 'package:route_between_two_points/pages/admin/user_managment/widget.dart';
import 'package:http/http.dart' as http;
import 'package:route_between_two_points/pages/widget/toast.dart';
import '../../../../utils/style.dart';

class UserCreation extends StatefulWidget {
  const UserCreation({super.key});

  @override
  State<UserCreation> createState() => _UserCreationState();
}

class _UserCreationState extends State<UserCreation> {
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _Name = TextEditingController();
  final TextEditingController _Designation = TextEditingController();
  final TextEditingController _Password = TextEditingController();
  final TextEditingController _Email = TextEditingController();
  final TextEditingController _ConfirmPassword = TextEditingController();

  String? selectedRole;
  bool isUpdate = false;
  bool IsShow = true;
  bool isChecked = false;
  bool isLoading = false;
  // List<ValueItem> items = Data.stationNameswithId
  //     .map((e) => ValueItem(label: e['name'], value: e['id'].toString()))
  //     .toList();
  List<String> roles = [
    'PMANAGER',
    'CMANAGER',
    'ENGINEER',
    'USER',
    'QA/QC MANAGER'
  ];
  int? id;
  List<dynamic> Roles = Data.Roles;
  List<String> email = [];
  List<Map<String, dynamic>> table = [];

  @override
  void initState() {
    super.initState();
    isLoading = true;
    // // _roleController.getRoles();
    // isLoading = false;
    getUsers();
  }

  Future<void> DeleteUser(int uid) async {
    setState(() {
      table.clear();
      isLoading = true;
    });

    // Define your API key
    const String apiKey = config.apiKey;
    final String bearer = config.bearer_token;

    // Define your request headers
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': bearer,
      'apiKey': apiKey,
    };

    var response = await http.delete(
        Uri.parse('${config.baseUrl}/api/auth/delete-user/$uid'),
        headers: headers);
    if (response.statusCode == 200) {
      getUsers();
    }
  }

  Future<void> getUsers() async {
    table.clear();
    var response = await http
        .get(Uri.parse('${config.baseUrl}${config.userlist}'), headers: {
      'Content-Type': 'application/json',
      'Authorization': config.bearer_token,
      'apiKey': config.apiKey
    });
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<dynamic> users = data['users'];
      // print(users);
      for (var user in users) {
        int uId = user['userId'];
        String email = user['userEmail'];
        String name = user['name'];
        String uName = user['userName'];
        String designation = user['designation'];
        Map<String, dynamic> roles = user['role'];
        String roleName = roles['roleName'];
        int roleId = roles['roleId'];

        // print('Role: $roleName'); // for(var role in roles)

        table.add({
          'id': uId,
          'uName': uName,
          'name': name,
          'email': email,
          'role': roleName,
          'designation': designation,
          'roleId': roleId
        });
        // print(role);

        // print(uId);

        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> addUser() async {
    setState(() {
      isLoading = true;
    });
    // Define your base URL
    const String baseUrl = config.baseUrl;

    // Define your API key
    const String apiKey = config.apiKey;
    final String bearer = config.bearer_token;

    // Define your request headers
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': bearer,
      'apiKey': apiKey,
    };

    // Define your request body
    Map<String, dynamic> body = {
      "username": _userName.text,
      "email": _Email.text,
      "name": _Name.text,
      "password": _Password.text,
      "designation": _Designation.text,
      "roleId": selectedRole
    };

    // Encode the request body to JSON
    String requestBody = json.encode(body);

    try {
      // Make the POST request
      http.Response response = await http.post(
        Uri.parse('$baseUrl/api/auth/add-user'),
        headers: headers,
        body: requestBody,
      );

      // Check if the request was successful (status code 2xx)
      if (response.statusCode >= 200 && response.statusCode < 300) {
        clearFields();

        getUsers();
      } else {
        // Print error message if request fails
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      // Print any exceptions that occur during the request
    }
  }

  Future<void> updateUser(int id) async {
    setState(() {
      isLoading = true;
    });
    // Define your API key
    const String apiKey = config.apiKey;
    final String bearer = config.bearer_token;
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': bearer,
      'apiKey': apiKey,
    };
    Map<String, dynamic> body = {
      "username": _userName.text,
      "name": _Name.text,
      "designation": _Designation.text,
      "roleId": selectedRole
    };
    var response = await http.put(
      Uri.parse('${config.baseUrl}/api/auth/update-user/$id'),
      headers: headers,
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      clearFields();
      getUsers();
      setState(() {
        isUpdate = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: const Offset(0, 2),
                        blurRadius: 6.0)
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          isUpdate ? 'Update User' : 'Add New User',
                          style: GoogleFonts.ubuntu(fontSize: 20),
                        ),
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomeField(
                        read: false,
                        Controller: _userName,
                        Title: 'User Name*',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomeField(
                          read: false, Controller: _Name, Title: 'Name*'),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomeField(
                          read: false,
                          Controller: _Designation,
                          Title: 'Designation*'),
                      const SizedBox(
                        height: 10,
                      ),
                      Drop(selectedRole, Roles, 'User Role*', (value) {
                        setState(() {
                          selectedRole = value;
                        });
                      }),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomeField(
                          read: isUpdate, Controller: _Email, Title: 'Email*'),
                      const SizedBox(
                        height: 10,
                      ),
                      isUpdate
                          ? const SizedBox(
                              height: 2,
                            )
                          : passwordfield(
                              Controller: _Password,
                              show: IsShow,
                              Title: 'Password',
                            ),
                      const SizedBox(
                        height: 10,
                      ),
                      isUpdate
                          ? const SizedBox(
                              height: 2,
                            )
                          : passwordfield(
                              Controller: _ConfirmPassword,
                              show: IsShow,
                              Title: 'Confirm Password',
                            ),
                      const SizedBox(
                        height: 10,
                      ),
                      // isUpdate
                      //     ? SizedBox(
                      //         height: 2,
                      //       )
                      //     : CheckBox(),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // isUpdate
                      //     ? SizedBox(
                      //         height: 2,
                      //       )
                      //     : MultiSelectDropDown(
                      //         showClearIcon: true,
                      //         controller: _controller,
                      //         onOptionSelected: (options) {
                      //           debugPrint(options.toString());
                      //         },
                      //         options: items,
                      //         selectionType: SelectionType.multi,
                      //         chipConfig:
                      //             const ChipConfig(wrapType: WrapType.wrap),
                      //         dropdownHeight: 300,
                      //         // optionGoogleFonts.ubuntu: const GoogleFonts.ubuntu(fontSize: 16),
                      //         showChipInSingleSelectMode: true,
                      //         selectedOptions: isChecked ? items : [],
                      //         selectedOptionIcon: const Icon(Icons.check_circle),
                      //       ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          isUpdate
                              ? InkWell(
                                  onTap: () async {
                                    if (_userName.text.isNotEmpty &&
                                        _Name.text.isNotEmpty &&
                                        _Designation.text.isNotEmpty &&
                                        selectedRole != null) {
                                      await updateUser(id!);
                                    } else {
                                      toaster().showsToast(
                                          'Please fill all the fields',
                                          Colors.red,
                                          Colors.white);
                                    }
                                    // await CreateUser();
                                    //   Users.add(_userName.text);
                                    //   Names.add(_Name.text);
                                    //   Roles.add(selectedRole);
                                    //   email.add(_Email.text);
                                    // });
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 80,
                                    decoration: const BoxDecoration(
                                        color: Colors.lightBlue,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Center(
                                      child: Text(
                                        'update',
                                        style: GoogleFonts.ubuntu(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                )
                              : InkWell(
                                  onTap: () async {
                                    if (_ConfirmPassword.text !=
                                        _Password.text) {
                                      toaster().showsToast('password not match',
                                          Colors.red, Colors.white);
                                    } else {
                                      if (_userName.text.isNotEmpty &&
                                          _Name.text.isNotEmpty &&
                                          _Email.text.isNotEmpty &&
                                          _Designation.text.isNotEmpty &&
                                          selectedRole != null &&
                                          _Password.text.isNotEmpty) {
                                        await addUser();
                                      } else {
                                        toaster().showsToast(
                                            'Please fill all the fields',
                                            Colors.red,
                                            Colors.white);
                                      }
                                    }
                                    // await CreateUser();
                                    //   Users.add(_userName.text);
                                    //   Names.add(_Name.text);
                                    //   Roles.add(selectedRole);
                                    //   email.add(_Email.text);
                                    // });
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 80,
                                    decoration: const BoxDecoration(
                                        color: Colors.lightBlue,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Center(
                                      child: Text(
                                        'Add',
                                        style: GoogleFonts.ubuntu(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                          const SizedBox(
                            width: 8,
                          ),
                          InkWell(
                            onTap: () {
                              clearFields();
                            },
                            child: Container(
                              height: 40,
                              width: 80,
                              decoration: BoxDecoration(
                                  color:
                                      Colors.lightBlueAccent.withOpacity(0.8),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                              child: Center(
                                child: Text(
                                  'Clear',
                                  style:
                                      GoogleFonts.ubuntu(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : DataTable(
                                  columnSpacing: 10,
                                  columns: const [
                                    DataColumn(
                                        label: SizedBox(
                                            width: 60,
                                            child: Text(
                                              'User',
                                              softWrap: true,
                                            ))),
                                    DataColumn(
                                        label: SizedBox(
                                            width: 70,
                                            child: Text(
                                              'Name',
                                              softWrap: true,
                                            ))),
                                    DataColumn(
                                        label: SizedBox(
                                            width: 75,
                                            child: Text(
                                              'Role',
                                              softWrap: true,
                                            ))),
                                    DataColumn(label: Text('Email')),
                                    DataColumn(label: Text('action')),
                                  ],
                                  rows: List.generate(table.length, (index) {
                                    return DataRow(cells: [
                                      // DataCell(Text(name ?? "")),
                                      DataCell(Text(table[index]['uName'])),
                                      DataCell(Center(
                                          child: Text(table[index]['name']))),
                                      DataCell(Center(
                                          child: Text(table[index]['role']))),
                                      DataCell(Center(
                                          child: Text(table[index]['email']))),

                                      DataCell(Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                isUpdate = true;
                                              });
                                              editRow(table[index]);
                                            },
                                            icon: const Icon(
                                              Icons.edit,
                                              color: Colors.lightBlue,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              DeleteUser(table[index]['id']);
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      )),
                                    ]);
                                  })),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  void editRow(Map<String, dynamic> index) {
    setState(() {
      id = index['id'];
      _userName.text = index['uName'];
      _Name.text = index['name'];
      _Designation.text = index['designation'];
      _Email.text = index['email'];
      selectedRole = index['roleId'].toString();
    });
  }

  Widget CheckBox() {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          width: 15,
        ),
        InkWell(
          onTap: () {
            setState(() {
              isChecked = !isChecked;
            });
          },
          child: Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                border:
                    Border.all(color: isChecked ? AppColor.Blue : Colors.grey)),
            child: Center(
                child: isChecked ? const Icon(Icons.check) : const SizedBox()),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        const Text('All Stations')
      ],
    );
  }

  void clearFields() {
    setState(() {
      _userName.clear();
      _Name.clear();
      selectedRole = "1";
      _Designation.clear();
      _Email.clear();
      _Password.clear();
      _ConfirmPassword.clear();
      // Clear other relevant state variables and controllers here
    });
  }

  Widget Drop(
    String? selectedValue,
    List<dynamic> list,
    String title,
    void Function(String?)? onChanged,
  ) {
    return SizedBox(
      height: 70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          Padding(
            padding: const EdgeInsets.only(left: 0.0),
            child: DropdownButtonFormField<String>(
              value: selectedValue,
              items: list.map((dynamic value) {
                return DropdownMenuItem<String>(
                  value: value['id'].toString(),
                  child: Text(value['name']),
                );
              }).toList(),
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: '--Choose Role--',
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.grey)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.lightBlue),
                ),
              ),

              // borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ],
      ),
    );
  }
}
