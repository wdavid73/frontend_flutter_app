import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:my_restaurant_app/class/table.dart';
import 'package:my_restaurant_app/services/services.dart';
import 'package:my_restaurant_app/utils/my_colors.dart';
import 'package:my_restaurant_app/utils/parse_data.dart';
import 'package:my_restaurant_app/utils/responsive.dart';
import 'package:my_restaurant_app/widgets/dialogs/dialog_add_table.dart';
import 'package:my_restaurant_app/widgets/list/list_tables.dart';
import 'package:my_restaurant_app/widgets/screen/screen_options_admin.dart';

class RegisterTablePage extends StatefulWidget {
  const RegisterTablePage({Key? key}) : super(key: key);

  @override
  State<RegisterTablePage> createState() => _RegisterTablePageState();
}

class _RegisterTablePageState extends State<RegisterTablePage> {
  bool reloadList = false;
  final ApiProvider _api = ApiProvider();
  final _session = SessionManager();

  Future<List<TableApp>> _getTables() async {
    dynamic token = await _session.get("token");
    var response = await _api.get(
      "api_admin/tables/tables_by_restaurant",
      token,
    );
    return parseTables(response.data);
  }

  Future<void> displayDialogAddTable(BuildContext context) async {
    final result = await showDialog(
        context: context,
        builder: (context) {
          return WillPopScope(
            child: const SizedBox(
              width: 300,
              height: 300,
              child: DialogAddTable(),
            ),
            onWillPop: () => Future.value(false),
          );
        });
    setState(() {
      reloadList = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return ScreenOptionsAdmin(
      title: "Table List",
      child: ListTables(
        responsive: responsive,
        getTables: _getTables(),
        reload: reloadList,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          displayDialogAddTable(context);
        },
        child: const Icon(Icons.add),
        backgroundColor: MyColors.accentColor,
      ),
    );
  }
}
