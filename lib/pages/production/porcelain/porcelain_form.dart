import 'package:flutter/material.dart';
import 'package:mps_app/pages/production/porcelain/porcelain_form_list.dart';
import 'package:mps_app/utils/requests/AllRequests.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:mps_app/widgets/bottom_navigation.dart';
import 'package:mps_app/widgets/navigation_drawer.dart';
import 'package:mps_app/widgets/reuseable_widgets.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class ProductionForm extends StatefulWidget {
  final String title;
  final String dataId;
  const ProductionForm({Key? key, required this.title, required this.dataId})
      : super(key: key);

  @override
  _ProductionFormState createState() => _ProductionFormState();
}

class _ProductionFormState extends State<ProductionForm> {
  final _formKey = GlobalKey<FormState>();
  final _lastName = TextEditingController();
  final _sizeOfPhoto = TextEditingController();
  final _dateinput = TextEditingController();
  final _weekOf = TextEditingController();
  final _initials = TextEditingController();
  DateTime dateTime = DateTime.now();

  int? _complete = 1;
  int _id = 0;
  String? _orderId;
  List<dynamic> orderList = [];
  String? orderListId;
  Map? editData;
  final String showUrl =
      "http://127.0.0.1:8000/api/jwt/productionPicture/show/";

  editDataFunc() async {
    var data = await AllRequests.showData(showUrl + widget.dataId);
    setState(() {
      editData = data;
    });
    setDataFunc();
  }

  setDataFunc() {
    _id = editData!['id'];
    _lastName.text =
        editData!['picture_list'][0]['order']['family']['name_on_stone'];
    _sizeOfPhoto.text = editData!['picture_list'][0]['size_of_photo'];
    _dateinput.text = editData!['date'];
    _weekOf.text = editData!['week_of'];
    _initials.text = editData!['picture_list'][0]['initials'];
    _complete = (editData!['picture_list'][0]['complete'] == 'YES') ? 1 : 2;
    _orderId = editData!['picture_list'][0]['order_id'].toString();

    if (_id != 0) {
      List selectedList;
      orderListId = _orderId.toString();
      selectedList = orderList
          .where((element) => element['id'].toString() == _orderId.toString())
          .toList();
      _orderId = selectedList[0]['id'].toString();
      _lastName.text = selectedList[0]['lastName'];
    }
  }

  getOrders() async {
    var orders = await AllRequests.getOrderSource();
    setState(() {
      orderList = orders;
    });
  }

  postData(data) async {
    int statusCode = await AllRequests.postData(
        "http://127.0.0.1:8000/api/jwt/productionPicture/store", data);
    if (statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PorcelainFormList()),
      );
    } else {
      AlertDialog(
        title: const Text("Error...!"),
        content: const Text("Please Fill your Form Correctly...!"),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK")),
        ],
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getOrders();
    if (widget.dataId != "0") {
      editDataFunc();
    }
  }

  @override
  void dispose() {
    _sizeOfPhoto.dispose();
    _lastName.dispose();
    _dateinput.dispose();
    _weekOf.dispose();
    _initials.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ReusableWidgets.getAppBar(),
        drawer: const NavigationDrawerWidget(),
        body: Scaffold(
            appBar: ReusableWidgets.getAppBarForm(widget.title),
            bottomNavigationBar: const BottomNavigationWidget(),
            body: Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  backgroundColor: const Color.fromRGBO(51, 103, 153, 1),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton(
                          onPressed: () {}, child: const Text('Save')),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text(
                          'Delete',
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: const Color.fromRGBO(
                              215, 193, 13, 1), // background
                          onPrimary: Colors.black, // foreground
                        ),
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    IconButton(
                      icon: const Icon(
                        Icons.add_circle_outline,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        //
                      },
                    )
                  ],
                ),
                body: orderList.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                        ),
                      )
                    : SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  const Text(
                                    "Week of: ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  SizedBox(
                                      width: 200,
                                      child: TextFormField(
                                        controller: _weekOf,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: '0',
                                          isDense: true,
                                          contentPadding: EdgeInsets.all(10),
                                        ),
                                        keyboardType: TextInputType.number,
                                        textInputAction: TextInputAction.done,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter week';
                                          }
                                          return null;
                                        },
                                      )),
                                ],
                              ),

                              const SizedBox(height: 15),
                              const Divider(height: 10),
                              const SizedBox(height: 15),
                              ElevatedButton(
                                  onPressed: () {},
                                  child: const Text("Add new Entry")),
                              const SizedBox(height: 15),
                              const Divider(height: 10),
                              const SizedBox(height: 20),

                              SizedBox(
                                width: 340,
                                child: FormHelper.dropDownWidget(
                                  context,
                                  "Select Invoice No.",
                                  orderListId,
                                  orderList,
                                  (onChangedVal) {
                                    List<dynamic> selectedList = [];
                                    orderListId = onChangedVal;
                                    selectedList = orderList
                                        .where((element) =>
                                            element['id'].toString() ==
                                            onChangedVal.toString())
                                        .toList();
                                    _orderId = selectedList[0]['id'].toString();
                                    _lastName.text =
                                        selectedList[0]['lastName'];
                                  },
                                  (onValidateVal) {
                                    if (onValidateVal == null) {
                                      return "Please Select Invoice No...!";
                                    }
                                    return null;
                                  },
                                  borderColor: Colors.black,
                                  borderFocusColor: Colors.black,
                                  borderRadius: 2,
                                  optionValue: "id",
                                  optionLabel: "invoice",
                                ),
                              ),

                              const SizedBox(height: 15),
                              SizedBox(
                                  width: 300,
                                  child: TextFormField(
                                    controller: _lastName,
                                    readOnly: true,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Last Name',
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(20),
                                    ),
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.done,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please Select Invoice Number for Last Name';
                                      }
                                      return null;
                                    },
                                  )),
                              const SizedBox(height: 15),

                              SizedBox(
                                  width: 300,
                                  child: TextFormField(
                                    controller: _sizeOfPhoto,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Size of Photo',
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(20),
                                    ),
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.done,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter Size of Photo';
                                      }
                                      return null;
                                    },
                                  )),
                              const SizedBox(height: 15),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const Text(
                                    "Complete",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Radio<int>(
                                      value: 1,
                                      groupValue: _complete,
                                      onChanged: (value) {
                                        setState(() {
                                          _complete = value;
                                        });
                                      }),
                                  const Text('Yes'),
                                  Radio<int>(
                                      value: 2,
                                      groupValue: _complete,
                                      onChanged: (value) {
                                        setState(() {
                                          _complete = value;
                                        });
                                      }),
                                  const Text('No'),
                                ],
                              ),
                              const SizedBox(height: 15),
                              // Date
                              SizedBox(
                                  width: 300,
                                  child: TextFormField(
                                    readOnly: true,
                                    controller: _dateinput,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Date',
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(20),
                                    ),
                                    onTap: () async {
                                      DateTime? pickedDate =
                                          await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(1800),
                                              lastDate: DateTime(2201));
                                      DatePickerEntryMode.input;

                                      if (pickedDate != null) {
                                        String formattedDate =
                                            DateFormat('yyyy-MM-dd')
                                                .format(pickedDate);

                                        setState(() {
                                          _dateinput.text = formattedDate;
                                        });
                                      }
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please Select Date';
                                      }
                                      return null;
                                    },
                                  )),
                              const SizedBox(height: 15),

                              SizedBox(
                                  width: 300,
                                  child: TextFormField(
                                    controller: _initials,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Initials',
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(20),
                                    ),
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.done,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter some value';
                                      }
                                      return null;
                                    },
                                  )),
                              const SizedBox(height: 15),

                              ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Processing Data')),
                                    );
                                    Map<String, String?> data = {
                                      "id": _id.toString(),
                                      "week_of": _weekOf.text,
                                      "order_id": _orderId,
                                      "size_of_photo": _sizeOfPhoto.text,
                                      "complete":
                                          (_complete == 1) ? "YES" : "NO",
                                      "date": _dateinput.text,
                                      "initials": _initials.text,
                                      "total_entries": "1",
                                    };
                                    postData(data);
                                  }
                                },
                                child: const Text('Submit'),
                              ),
                            ],
                          ),
                        ),
                      ))));
  }

  // Date Picker Widget
  Widget buildDatePicker() => CupertinoDatePicker(
        initialDateTime: dateTime,
        mode: CupertinoDatePickerMode.date,
        onDateTimeChanged: (dateTime) {
          setState(() => dateTime = dateTime);
        },
      );
}
