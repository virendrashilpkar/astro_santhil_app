import 'package:astro_santhil_app/models/login_model.dart';
import 'package:astro_santhil_app/networking/services.dart';
import 'package:astro_santhil_app/view/home.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  late SharedPreferences _prefs;
  bool _boxValue = false;
  late LoginModel _loginModel;
  bool clickLoad = false;
  bool _isHidden = true;

  Future<void> loginMethod() async{
    _prefs = await SharedPreferences.getInstance();

    setState(() {
      clickLoad = true;
    });
    _loginModel = await Services.loginApi(userName.text.trim(), password.text.trim());
    if(_loginModel.status == true){
      _prefs.setBool("_login", true);
      Fluttertoast.showToast(msg: "${_loginModel.msg}",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Home()));
    }else{
      Fluttertoast.showToast(msg: "${_loginModel.msg}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR);
    }
    setState(() {
      clickLoad = false;
    });
  }
  void navigate() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    bool? status  = _preferences.getBool("_login");

    if(status == true){
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Home()));
    }
  }

  void _togglePasswordView(){
    setState((){
      _isHidden = !_isHidden;
    });
  }

  @override
  void initState() {
    navigate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     // resizeToAvoidBottomInset: false,
     body: SingleChildScrollView(
       child: Container(
         decoration: BoxDecoration(
           image: DecorationImage(
               image: AssetImage("assets/background.png"),
           fit: BoxFit.fitWidth)
         ),
         child: Container(
           height: MediaQuery.of(context).size.height,
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               Container(
                 child: Text("ASTRO SENTHIL",
                   style: TextStyle(fontSize: 34.09, color: Colors.white, fontWeight: FontWeight.w700),),
               ),
               Container(
                 child: Text("log in to continue",
                   style: TextStyle(fontSize: 16, color: Colors.white),),
               ),
               Container(
                 margin: EdgeInsets.only(top: 70.0),
                 child: CircleAvatar(
                   radius: 70.0,
                   backgroundColor: Colors.white,
                   child: Container(
                     padding: EdgeInsets.only(top: 12.0),
                       child: Image.asset("assets/green text-01.png",
                       width: 120,)),
                 ),
               ),
               Container(
                 margin: EdgeInsets.only(left: 40.0, top: 20.0, right: 40.0),
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.all(
                     Radius.circular(10.0)
                   )
                 ),
                 child: TextField(
                   controller: userName,
                   textAlignVertical: TextAlignVertical.center,
                   textAlign: TextAlign.left,
                   keyboardType: TextInputType.text,
                   decoration: InputDecoration(
                     isDense: true,
                     hintText: 'Username',
                     hintStyle: const TextStyle(
                       fontSize: 14.0,
                       color: Colors.black26,
                     ),
                     border: InputBorder.none,
                     prefixIcon: Container(
                       margin: EdgeInsets.only(right: 16.0),
                       decoration: BoxDecoration(
                         color: Colors.black,
                           borderRadius: BorderRadius.all(
                               Radius.circular(5.0)
                           )
                       ),
                       child: IconButton(
                         icon: Image.asset("assets/user_ic_white.png", width: 20, height: 20,), onPressed: () { },
                       ),
                     ),
                   ),
                 ),
               ),
               Container(
                 margin: EdgeInsets.only(left: 40.0, top: 20.0, right: 40.0),
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.all(
                     Radius.circular(10.0)
                   )
                 ),
                 child: Row(
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     Container(
                       margin: EdgeInsets.only(right: 16.0),
                       decoration: BoxDecoration(
                           color: Colors.black,
                           borderRadius: BorderRadius.all(
                               Radius.circular(5.0)
                           )
                       ),
                       child: IconButton(
                         icon: Image.asset("assets/pass_ic.png", width: 20, height: 20,), onPressed: () { },
                       ),
                     ),
                     Expanded(
                       child: TextField(
                         controller: password,
                         obscureText: _isHidden,
                         textAlignVertical: TextAlignVertical.center,
                         textAlign: TextAlign.left,
                         keyboardType: TextInputType.text,
                         decoration: InputDecoration(
                           contentPadding: EdgeInsets.only(bottom: 0.0),
                           isDense: true,
                           hintText: 'Password',
                           hintStyle: const TextStyle(
                             fontSize: 14.0,
                             color: Colors.black26,
                           ),
                           border: InputBorder.none,
                         ),
                       ),
                     ),
                     InkWell(
                       onTap: _togglePasswordView,
                       child: Container(
                         margin: EdgeInsets.only(right: 8.0),
                         child: Icon(
                           _isHidden
                               ? Icons.visibility
                               : Icons.visibility_off,
                         ),
                       ),
                     ),
                   ],
                 ),
               ),
               Container(
                 margin: EdgeInsets.only(left: 30.0),
                 child: Row(
                   children: [
                     Checkbox(
                         value: this._boxValue,
                         focusColor: Colors.white,
                         side: BorderSide(
                           color: Colors.white
                         ),
                         onChanged: (bool? value) {
                           setState(() {
                             this._boxValue = value!;
                           });
                         }
                     ),
                     Container(
                       child: Text("Remember Me", style: TextStyle(color: Colors.white),),
                     )
                   ],
                 ),
               ),
               Container(
                 margin: EdgeInsets.only(top: 20.0),
                 child: ElevatedButton(
                   style: ButtonStyle(
                     backgroundColor: MaterialStateProperty.all(Color(0xff303030))
                   ),
                     onPressed: () {
                     if(userName.text.isEmpty){
                       Fluttertoast.showToast(msg: "Please Enter User Name");
                     }else if(password.text.isEmpty){
                       Fluttertoast.showToast(msg: "Please Enter Password");
                     }else{
                       loginMethod();
                     }
                     },
                     child: Container(
                       margin: EdgeInsets.symmetric(horizontal: 20.44),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             clickLoad ? Container(
                               width: 24,
                               height: 24,
                               padding: EdgeInsets.all(2.0),
                               child: const CircularProgressIndicator(
                                 color: Colors.white,
                                 strokeWidth: 3.0,
                               ),
                             ):
                             Text("Log in", style: TextStyle(color: Colors.white, fontSize: 19.37, fontWeight: FontWeight.w700),),
                           ],
                         ))),
               ),
             ],
           ),
         ),
       ),
     )
   );
  }


}
