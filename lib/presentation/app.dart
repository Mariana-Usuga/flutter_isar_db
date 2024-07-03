import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_isar_db/blocs/blocs.dart';
import 'package:flutter_isar_db/blocs/students_bloc/students_bloc.dart';
import 'package:flutter_isar_db/presentation/screens/screens.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TeachersBloc(),
        ),
        BlocProvider(
          create: (context) => CoursesBloc(),
        ),
        BlocProvider(
          create: (context) => StudentsBloc(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Isar DB',
        theme: ThemeData(
          primaryColor: const Color(0xFF33357E),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Color(0xFF33357E),
          ),
        ),
        initialRoute: HomeScreen.routeName,
        routes: {
          HomeScreen.routeName: (_) => const HomeScreen(),
          NewTeacherScreen.routeName: (_) => const NewTeacherScreen(),
          NewCourseScreen.routeName: (_) => const NewCourseScreen(),
          
        },
      ),
    );
  }
}
