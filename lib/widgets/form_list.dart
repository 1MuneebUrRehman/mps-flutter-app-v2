import 'package:flutter/material.dart';
import 'package:mps_app/utils/requests/getOrderList.dart';
import 'package:mps_app/widgets/bottom_navigation.dart';
import 'package:mps_app/widgets/navigation_drawer.dart';
import 'package:mps_app/widgets/reuseable_widgets.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class FormListWidget extends StatefulWidget {
  const FormListWidget({Key? key}) : super(key: key);

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
          title: const Text(
            "Production",
            style: TextStyle(color: Colors.black, fontSize: 15),
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
                    onPressed: () {},
                    icon: const Icon(
                      Icons.add_circle_outline,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              body: FutureBuilder(
                future: getOrderDataList('productProduction'),
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
                                print("Add");
                              },
                              child: Container(
                                  color: Colors.greenAccent,
                                  child: const Center(
                                    child: Icon(Icons.add),
                                  )));
                        },
                        endSwipeActionsBuilder: (BuildContext context,
                            DataGridRow row, int rowIndex) {
                          return GestureDetector(
                              onTap: () {
                                print("Remove");
                                print(rowIndex);
                              },
                              child: Container(
                                  color: Colors.redAccent,
                                  child: const Center(
                                    child: Icon(Icons.delete),
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
