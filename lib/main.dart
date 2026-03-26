import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_spend/constants/cons_values.dart';
import 'package:smart_spend/constants/notifier.dart';
import 'package:smart_spend/functions/background.dart';
import 'package:smart_spend/functions/manage_user.dart';
import 'package:smart_spend/widget_tree.dart';
import 'package:hive/hive.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox(AppDatabase.box_name);
  await Hive.openBox(AppDatabase.memo_box_name);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    get_dark_mode();
    check_user_sign_in();
    super.initState();
  }

  void get_dark_mode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? temp = prefs.getBool(Settings.dark_mode);
    dark_mode.value = temp ?? false;
    container_colors.value = dark_mode.value
        ? BoxDecoration(
            color: ColorContainer.main_containers_dark,
            borderRadius: BorderRadius.circular(20),
          )
        : BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          );
  }

  void check_user_sign_in() async {
    user_data.value = await UserManagement.load_user_data();
    switch (user_data.value) {
      case null:
        user_signed_in.value = false;
        break;
      default:
        user_signed_in.value = true;
        break;
    }
  }

  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: dark_mode,
      builder: (context, value, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: false,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Color.fromRGBO(103, 80, 164, 1),
              brightness: value ? Brightness.dark : Brightness.light,
            ),
          ),
          home: WidgetTree(),
        );
      },
    );
  }
}
