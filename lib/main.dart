import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_restaurant_app/pages/home/splash_screen.dart';
import 'package:my_restaurant_app/provider/loading_widget.dart';
import 'package:my_restaurant_app/utils/my_colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  ).then((value) async {
    await GetStorage.init();
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: MyColors.darkPrimaryColor,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: MyColors.accentColor,
        ),
      ),
      builder: LoadingScreen.init(),
      home: const SplashScreen(),
    );
  }
}
