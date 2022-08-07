import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:my_restaurant_app/class/complement.dart';
import 'package:my_restaurant_app/services/services.dart';
import 'package:my_restaurant_app/utils/my_colors.dart';
import 'package:my_restaurant_app/utils/parse_data.dart';
import 'package:my_restaurant_app/utils/responsive.dart';
import 'package:my_restaurant_app/widgets/dialogs/dialog_add_complement.dart';
import 'package:my_restaurant_app/widgets/list/list_complements.dart';
import 'package:my_restaurant_app/widgets/screen/screen_options_admin.dart';

class RegisterComplementPage extends StatefulWidget {
  const RegisterComplementPage({Key? key}) : super(key: key);

  @override
  State<RegisterComplementPage> createState() => _RegisterComplementPageState();
}

class _RegisterComplementPageState extends State<RegisterComplementPage> {
  bool reloadList = false;
  final ApiProvider _api = ApiProvider();
  final _session = SessionManager();

  Future<List<Complement>> _getComplements() async {
    dynamic token = await _session.get("token");
    var response = await _api.get("api_admin/complement/", token);
    return parseComplements(response.data);
  }

  Future<void> displayDialogAddComplement(BuildContext context) async {
    final result = await showDialog(
        context: context,
        builder: (context) {
          return WillPopScope(
            child: const SizedBox(
              width: 300,
              height: 300,
              child: DialogAddComplement(),
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
      title: "Complements List",
      child: ListComplements(
        responsive: responsive,
        getComplements: _getComplements(),
        reload: reloadList,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          displayDialogAddComplement(context);
        },
        child: const Icon(Icons.add),
        backgroundColor: MyColors.accentColor,
      ),
    );
  }
}
