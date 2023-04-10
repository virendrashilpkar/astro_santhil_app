import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shadiapp/CommonMethod/CommonColors.dart';
import 'package:shadiapp/CommonMethod/ConnectivityProvider.dart';
import 'package:shadiapp/CommonMethod/CustomRoute.dart';
import 'package:shadiapp/view/ChooseReg/ChooseReg.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:(context) => ConnectivityProvider(),
        child:  MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primarySwatch: Colors.blue,
              fontFamily: 'opensans'
          ),
          onGenerateRoute: CustomRoute.allRoutes,
          home: const MyHomePage(),
    ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  void initState() {
    // CheckUserConnection();
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      navigateUser(context);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: CommonColors.themeblack,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/logo_name.png",height: 62,width: 215,)
          ],
        ),
      ),
    );
  }
}
void navigateUser(BuildContext context) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? status = prefs.getBool('true');
  if (status == true) {

    // Navigator.of(context).pushNamed('ChooseReg');
  }else{

    Navigator.of(context).pushNamed('Home');
    // Navigator.of(context).pushNamed('ChooseReg');
  }
}