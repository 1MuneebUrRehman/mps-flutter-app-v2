import 'package:flutter/material.dart';
import 'package:mps_app/pages/production/laser/laser_form.dart';
import 'package:mps_app/pages/production/porcelain/porcelain_form.dart';
import 'package:mps_app/pages/production/sandblasting/sandblasting_form.dart';
import 'package:mps_app/utils/requests/allRequests.dart';
import 'package:mps_app/utils/requests/getOrderList.dart';
import 'package:mps_app/widgets/bottom_navigation.dart';
import 'package:mps_app/widgets/navigation_drawer.dart';
import 'package:mps_app/widgets/reuseable_widgets.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class FormListWidget extends StatefulWidget {
  final String title;
  final String url;
  final String urlRoute;
  final String urlAdd;
  final String removeUrl;
  const FormListWidget({
    Key? key,
    required this.title,
    required this.url,
    required this.urlRoute,
    required this.urlAdd,
    required this.removeUrl,
  }) : super(key: key);

  @override
  _FormListWidgetState createState() => _FormListWidgetState();
}

class _FormListWidgetState extends State<FormListWidget> {
  destroyData(destroyUrl) async {
    var responseStatusCode = await allRequests.deleteData(destroyUrl);
    if (responseStatusCode == 200) {
      setState(() {});
    }
  }

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
                        columnWidthMode: ColumnWidthMode.fill,
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
                                var destroyUrl = widget.removeUrl + id;
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: AlertDialog(
                                          title: const Text("Delete...!"),
                                          content: const Text(
                                              "Are You Sure you want to Delete ...!"),
                                          actions: [
                                            ElevatedButton(
                                                onPressed: () {
                                                  destroyData(destroyUrl);
                                                  Navigator.pop(context, true);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    primary: Colors.red),
                                                child: const Text("Yes")),
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context, true);
                                                },
                                                child: const Text("No"))
                                          ],
                                        ),
                                      );

                                      // return DeleteAlertDialog(url: destroyUrl);
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
                              onTap: () async {
                                var id = row.getCells()[0].value.toString();
                                String urlName = widget.urlRoute.split("/")[1];
                                switch (urlName) {
                                  case "productionPicture":
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProductionForm(
                                                title: widget.title,
                                                dataId: id,
                                              )),
                                    );
                                    break;
                                  case "productionLaser":
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LaserForm(
                                                title: widget.title,
                                                dataId: id,
                                              )),
                                    );
                                    break;
                                  case "productionSandblasting":
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SandBlastingForm(
                                                title: widget.title,
                                                dataId: id,
                                              )),
                                    );
                                    break;
                                  default:
                                }
                              },
                              child: Container(
                                  color: Colors.blue,
                                  child: const Center(
                                    child: Icon(Icons.edit),
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
