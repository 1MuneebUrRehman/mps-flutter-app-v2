import 'package:flutter/material.dart';
import 'package:mps_app/utils/requests/getOrderList.dart';
import 'package:mps_app/widgets/bottom_navigation.dart';
import 'package:mps_app/widgets/deleteDialog.dart';
import 'package:mps_app/widgets/navigation_drawer.dart';
import 'package:mps_app/widgets/reuseable_widgets.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class FormListWidget extends StatefulWidget {
  final String title;
  final String url;
  final String urlRoute;
  final String urlAdd;
  
  const FormListWidget(
      {Key? key,
      required this.title,
      required this.url,
      required this.urlRoute,
      required this.urlAdd})
      : super(key: key);

  @override
  _FormListWidgetState createState() => _FormListWidgetState();
}

class _FormListWidgetState extends State<FormListWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableWidgets.getAppBar(),
      drawer: const NavigationDrawerWidget(),
      body: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            widget.title,
            style: const TextStyle(color: Colors.black, fontSize: 15),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white38,
        ),
        body: Scaffold(
          body: SafeArea(
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: const Color.fromRGBO(51, 103, 153, 1),
                actions: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, widget.urlAdd);
                    },
                    icon: const Icon(
                      Icons.add_circle_outline,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              body: FutureBuilder(
                future: getOrderDataList(widget.url),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    return SfDataGrid(
                        allowSwiping: true,
                        onSwipeStart: (details) {
                          if (details.swipeDirection ==
                              DataGridRowSwipeDirection.startToEnd) {
                            details.setSwipeMaxOffset(100);
                          } else if (details.swipeDirection ==
                              DataGridRowSwipeDirection.endToStart) {
                            details.setSwipeMaxOffset(100);
                          }
                          return true;
                        },
                        startSwipeActionsBuilder: (BuildContext context,
                            DataGridRow row, int rowIndex) {
                          return GestureDetector(
                              onTap: () {
                                var id = row.getCells()[0].value.toString();
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return const DeleteAlertDialog();
                                    });
                              },
                              child: Container(
                                  color: Colors.redAccent,
                                  child: const Center(
                                    child: Icon(Icons.delete),
                                  )));
                        },
                        endSwipeActionsBuilder: (BuildContext context,
                            DataGridRow row, int rowIndex) {
                          return GestureDetector(
                              onTap: () {
                                print("Add");
                              },
                              child: Container(
                                  color: Colors.greenAccent,
                                  child: const Center(
                                    child: Icon(Icons.add),
                                  )));
                        },
                        source: snapshot.data,
                        columns: getColumns());
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
