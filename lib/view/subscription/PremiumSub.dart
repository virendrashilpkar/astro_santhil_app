
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shadiapp/CommonMethod/CommonColors.dart';
import 'package:shadiapp/Models/plan_list_model.dart';
import 'package:shadiapp/Models/update_setting_model.dart';
import 'package:shadiapp/Services/Services.dart';
import 'package:shadiapp/view/home/Home.dart';
import 'package:shadiapp/view/subscription/custom/Customcheck.dart';
import 'package:http/http.dart' as http;

class PremiumSub extends StatefulWidget {
  String name = "";
  String userId = "";
  String planId = "";
  String packName = "";
  Color color;
  int price = 0;
  List<Feauture> list = [];
  PremiumSub(this.color,this.planId,this.name,this.userId,this.packName, this.price, this.list);

  @override
  State<PremiumSub> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<PremiumSub> {

  bool ActiveConnection = false;
  String T = "";
  Future CheckUserConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          ActiveConnection = true;
          T = "Turn off the data and repress again";
        });
      }
    } catch (Error) {
      // setState(() {
      ActiveConnection = false;
      T = "Turn On the data and repress again";
      // });
    }
  }
  @override
  void initState() {
    CheckUserConnection();
    super.initState();
  }



  String clientSecret = '';
  Map<String, dynamic>? paymentIntent;

  Future<void> makePayment() async {
    try {
      //STEP 1: Create Payment Intent
      paymentIntent = await createPaymentIntent('${widget.price}', 'INR');

      //STEP 2: Initialize Payment Sheet
      print(">>>>${paymentIntent!["client_secret"]}");
      print(">>>>${paymentIntent!["status"]}");

      await Stripe.instance
          .initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent!['client_secret'], //Gotten from payment intent
              style: ThemeMode.light,
              merchantDisplayName: 'ShaadiApp',
              // customFlow: true,
          ))
          .then((value) {
      });

      // await Stripe.instance.confirmPayment(paymentIntentClientSecret: paymentIntent!["client_secret"]);


      //STEP 3: Display Payment sheet
      displayPaymentSheet(paymentIntent!["id"]);
    } catch (err) {
      throw Exception(">>>>??${err}");
    }
  }


  createPaymentIntent(String amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        // "payment_method":"{{CARD_ID}}",
        // "payment_method_types[]":"card",
        // "customer":"123123"
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer sk_test_51Neuj5SC5priZjFLk3rLiKEJFPV5B70o4rfldd8bJkHtEnlvWKCJgLNJabToKxzDElBwC2Q6uOA2rnR8BYJftqYK00pQquLVF7',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );


      print(">>>>><<<<<${response.body}");
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }



  calculateAmount(String amount) {
    final calculatedAmout = (int.parse(amount)) * 100;
    return calculatedAmout.toString();
  }

  void _redirectAfterDelay() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => Home(), // Replace 'HomePage' with your actual home page widget
        ),
      );
    });
  }

  displayPaymentSheet(String payment_id) async {
    try {
      final paymentSheetResponse = await Stripe.instance.presentPaymentSheet().then((value) async {
        // completpayment(paymen t_id);
        // print(">>>>>${payment_id}");
        UpdateSettingModel update = await Services.SubscribePlan({"payment_id":"${payment_id}","planId":"${widget.planId}","userId":"${widget.userId}"});
        Fluttertoast.showToast(msg: update.message ?? "");
        _redirectAfterDelay();

        if(update.status==1){
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children:  [
                    Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 100.0,
                    ),
                    SizedBox(height: 10.0),
                    Text("Payment Successful!"),
                  ],
                ),
              ));
        }
        paymentIntent = null;
      }).onError((error, stackTrace) {
        if (error is StripeException) {
          if (error.error.localizedMessage ==
              "The payment flow has been canceled") {
            // Handle cancellation gracefully
            _redirectAfterDelay();
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                content: Text("Payment canceled."),
              ),
            );
          }
        }
        throw Exception(">>>>${error}");
      });

      print(">>>><<<<${paymentSheetResponse.status}");

    } on StripeException catch (e) {
      print('Error is:---> $e');
      _redirectAfterDelay();
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: const [
                Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                Text("Payment Failed"),
              ],
            ),
          ],
        ),
      );
    } catch (e) {
      print('$e');
    }
  }


  void completpayment(String payment_id)async{
    // https://api.stripe.com/v1/payment_intents/pi_1GszsE2eZvKYlo2C3d7AiGJV/confirm
    try {
      //Request body
      // Map<String, dynamic> body = {
      //   'amount': calculateAmount(amount),
      //   'currency': currency,
      //   'automatic_payment_methods[enabled]':true.toString()
      // };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents/${payment_id}/confirm'),
        headers: {
          'Authorization': 'Bearer sk_test_51Neuj5SC5priZjFLk3rLiKEJFPV5B70o4rfldd8bJkHtEnlvWKCJgLNJabToKxzDElBwC2Q6uOA2rnR8BYJftqYK00pQquLVF7',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        // body: body,
      );


      print(">>>>><<<<<${response.body}");
      // return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: CommonColors.themeblack,
      body: SafeArea(
        child:
        new Container(
          height:MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: widget.color,
              // border: Border.all(width: 1,color: Colors.white),
              borderRadius: BorderRadius.circular(10)
          ),
          // color: CommonColors.bluepro,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(20),
          alignment: Alignment.center,
          child: Column(
            children: [
              InkWell(
                onTap:(){
                  Navigator.of(context).pop();
                },
                child: new Container(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1,color: Colors.black),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        padding: const EdgeInsets.all(5),
                        child: Image.asset("assets/home_close.png",color: Colors.black,)),),
                ),
              ),
              new Container(
                child: Text("Plan Comparison",style: new TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),),
              ),
              new Container(
                child: Text("Choose the best plan for you",style: new TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w400),),
              ),
              new Container(
                width: double.infinity,
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: CommonColors.freegrey,
                    // border: Border.all(width: 1,color: Colors.white),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  children: [
                    new SizedBox(height: 20,),
                    new Container(
                      child: Text(widget.name,style: new TextStyle(color:Colors.black,fontSize: 20,fontWeight: FontWeight.w600),),
                    ),
                    new SizedBox(height: 5,),
                    new Container(
                      child: Text("Unlock ${widget.name} features to be in\ncontrol of your experience",style: new TextStyle(color:Colors.black,fontSize: 12,fontWeight: FontWeight.w400),textAlign: TextAlign.center,),
                    ),
                    new SizedBox(height: 5,),


                    InkWell(
                      onTap: ()async{
                        await makePayment();

                        },
                      child: new Container(
                        // margin: const EdgeInsets.all(15),
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(vertical: 15,horizontal: 48),
                        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 0),
                        decoration: BoxDecoration(
                            color:widget.color,
                            // border: Border.all(width: 1,color: Colors.white),
                            borderRadius: BorderRadius.circular(54)
                        ),
                        child: Column(
                          children: [
                            new Container(
                              child: Text("Upgrade form ₹ ${widget.price}",style: new TextStyle(color: CommonColors.black,fontSize: 16,fontWeight: FontWeight.w600),),
                            ),
                          ],
                        ),
                      ),
                    ),

                    new SizedBox(height: 20,),


                  ],
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for(int i = 0; i < 3; i++)
                      Container(
                          height: 8, width: 8,
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          decoration: BoxDecoration(
                              color: i == 0 ?  CommonColors.buttonorg:Colors.white,
                              borderRadius: BorderRadius.circular(4)
                          )
                      )
                  ]
              ),
              Expanded(child: ListView.builder(
                itemCount: widget.list.length,
                  itemBuilder: (context, index){
                return Customcheck(tittle: widget.list[index].feature.toString(), color: CommonColors.black.withOpacity(0.2), textcolor: CommonColors.black);
              }))
            ],
          ),
        )
      ),
    );
  }
}

