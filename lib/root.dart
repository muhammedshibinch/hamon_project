import 'package:flutter/material.dart';
import 'package:hamon_project/controllers/classroom_provider.dart';
import 'package:hamon_project/controllers/student_provider.dart';
import 'package:hamon_project/controllers/subject_provider.dart';
import 'package:hamon_project/utils/colors.dart';
import 'package:hamon_project/utils/textstyles.dart';
import 'package:provider/provider.dart';
import 'utils/routers.dart';
import 'views/home/homepage.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => StudentProvider()),
        ChangeNotifierProvider(create: (context) => SubjectProvider()),
        ChangeNotifierProvider(create: (context) => RoomProvider())
      ],
      child: MaterialApp(
        title: 'Hamon Project',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: AppBarTheme(
              centerTitle: true,
              titleTextStyle: appBarStyle,
              backgroundColor: appBarColor),
          iconTheme: const IconThemeData(color: white),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: primaryColor),
        ),
        home: const HomePage(),
        onGenerateRoute: Routers.generateRoute,
      ),
    );
  }
}
