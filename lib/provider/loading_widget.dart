import 'package:flutter/material.dart';
import 'package:my_restaurant_app/provider/loading_provider.dart';
import 'package:my_restaurant_app/utils/my_colors.dart';
import 'package:my_restaurant_app/utils/responsive.dart';
import 'package:provider/provider.dart';

class LoadingScreen {
  static TransitionBuilder init({TransitionBuilder? builder}) {
    return (BuildContext context, Widget? child) {
      if (builder != null) {
        return builder(context, LoadingCustom(child: child!));
      } else {
        return LoadingCustom(child: child!);
      }
    };
  }
}

class LoadingCustom extends StatelessWidget {
  final Widget child;

  const LoadingCustom({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Scaffold(
      body: ChangeNotifierProvider<LoadingProvider>(
        create: (context) => LoadingProvider(),
        builder: (context, _) {
          return Stack(
            children: [
              child,
              Consumer<LoadingProvider>(
                builder: (context, provider, child) {
                  if (provider.loading) {
                    return Container(
                      color: Colors.white12,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: responsive.wp(35),
                            height: responsive.hp(5),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Loading...",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: responsive.dp(2),
                                    ),
                                  ),
                                ),
                                const CircularProgressIndicator(
                                  color: MyColors.accentColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              )
            ],
          );
        },
      ),
    );
  }
}
