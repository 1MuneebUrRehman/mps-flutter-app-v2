import 'package:flutter/material.dart';
import 'package:mps_app/pages/collaboration/collaboration_form.dart';
import 'package:mps_app/utils/requests/get_collaborations_list.dart';
import 'package:mps_app/utils/utility.dart';
import 'package:mps_app/widgets/bottom_navigation.dart';
import 'package:mps_app/widgets/navigation_drawer.dart';
import 'package:mps_app/widgets/reuseable_widgets.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class Collaborations extends StatefulWidget {
  const Collaborations({Key? key}) : super(key: key);

  @override
  _CollaborationsState createState() => _CollaborationsState();
}

class _CollaborationsState extends State<Collaborations> {

  final String url = "collaboration";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ReusableWidgets.getAppBar(),
        drawer: const NavigationDrawerWidget(),
        body: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "Collaborations",
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
                  backgroundColor: Utility.primaryColor,
                ),
                body: FutureBuilder(
                  future: getCollaborationsList(url),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      return SfDataGrid(
                          columnWidthMode: ColumnWidthMode.fill,
                          allowSwiping: true,
                          onSwipeStart: (details) {
                            if (details.swipeDirection ==
                                DataGridRowSwipeDirection.startToEnd) {
                              details.setSwipeMaxOffset(0);
                            } else if (details.swipeDirection ==
                                DataGridRowSwipeDirection.endToStart) {
                              details.setSwipeMaxOffset(100);
                            }
                            return true;
                          },
                          endSwipeActionsBuilder: (BuildContext context,
                              DataGridRow row, int rowIndex) {
                            return GestureDetector(
                                onTap: () async {
                                  var id = row.getCells()[1].value.toString();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CollaborationForm(
                                              dataId: id,
                                            )),
                                  );
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
          bottomNavigationBar: const BottomNavigationWidget(),
        ));
  }
}
