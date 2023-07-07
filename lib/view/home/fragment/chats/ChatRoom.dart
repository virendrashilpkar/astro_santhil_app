import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shadiapp/CommonMethod/CommonColors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shadiapp/Models/user_detail_model.dart';
import 'package:shadiapp/Services/Services.dart';
import 'package:shadiapp/ShadiApp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ChatRoom extends StatefulWidget {

  String image = "";
  String user_id;
  String room_id;
  String user_name;
  ChatRoom(this.image,this.user_id,this.room_id,this.user_name);

  @override
  State<ChatRoom> createState() => _ChatRoom();

}

class _ChatRoom extends State<ChatRoom> {

  TextEditingController _message = TextEditingController();

  var messageList = ["Hi","How are you",];
  var reciveList = ["Hello", "Fine"];


  @override
  void initState() {
    userDetail();
  }

  String firstName = "";
  String lastName = "";
  String luser_id = "";
  String userimage = "";
  late UserDetailModel _userDetailModel;
  late SharedPreferences _preferences;
  Future<void> userDetail() async {
    _preferences = await SharedPreferences.getInstance();
    _userDetailModel = await Services.UserDetailMethod("${_preferences?.getString(ShadiApp.userId)}");
    if(_userDetailModel.status == 1){
      firstName = _userDetailModel.data![0].firstName.toString();
      lastName = _userDetailModel.data![0].lastName.toString();
      luser_id = _userDetailModel.data![0].id.toString();
      setState((){});
    }
  }


  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future uploadImage(String user_name,File imageFile) async {
    String fileName = const Uuid().v1();
    int status = 1;

    await _firestore
        .collection('chatroom')
        .doc(widget.room_id)//roomid
        .collection('chats')
        .doc(fileName)
        .set({
      "uid": luser_id,
      "sendby": user_name,
      "message": "",
      "type": "img",
      "time": FieldValue.serverTimestamp(),
    });

    var ref =
    FirebaseStorage.instance.ref().child('images').child("$fileName.jpg");

    var uploadTask = await ref.putFile(imageFile!).catchError((error) async {
      await _firestore
          .collection('chatroom')
          .doc(widget.room_id)//roomid
          .collection('chats')
          .doc(fileName)
          .delete();

      status = 0;
      // _scrollController.animateTo(_scrollController.position.maxScrollExtent,
      //     duration: const Duration(milliseconds: 300), curve: Curves.easeOut);

    });

    if (status == 1) {
      String imageUrl = await uploadTask.ref.getDownloadURL();

      await _firestore
          .collection('chatroom')
          .doc(widget.room_id)//roomid
          .collection('chats')
          .doc(fileName)
          .update({"message": imageUrl});

      print(imageUrl);

      // _scrollController.animateTo(_scrollController.position.maxScrollExtent,
      //     duration: const Duration(milliseconds: 300), curve: Curves.easeOut);

    }
  }

  void onSendMessage(String user_id,user_name) async {
    if (_message.text.isNotEmpty) {
      Map<String, dynamic> messages = {
        "uid": luser_id,
        "sendby": user_name,
        "message": _message.text,
        "type": "text",
        "time": FieldValue.serverTimestamp(),
      };

      _message.clear();
      await _firestore
          .collection('chatroom')
          .doc(widget.room_id)//roomid
          .collection('chats')
          .add(messages);
      await _firestore
          .collection('chatroom')
          .doc(widget.room_id)//roomid
          .set({
        "user1":user_name,
        "user2":widget.user_name,
        "uid1":luser_id,
        "uid2":user_id,
        'id':widget.room_id,
        'image1':widget.image,
        'image2':userimage,
      });
      // _scrollController.animateTo(_scrollController.position.maxScrollExtent,
      //     duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      print("Enter Some Text");
    }
  }



  /* Delete chat on block of user */
  Future<void> deletePrivateChat() async {

    final collectionOnly = FirebaseFirestore.instance.collection('chatroom');
    collectionOnly
        .doc(widget.room_id) // <-- Doc ID to be deleted.
        .delete() // <-- Delete
        .then((_) => print('>>>>>>>>>>>>>>>>Deleted'))
        .catchError((error) => print('>>>>>>>>>>>>>>>>Deleted failed: $error'));

    final collection = await FirebaseFirestore.instance
        .collection("chatroom")
        .doc(widget.room_id)
        .collection('chats')
        .get();

    final batch = FirebaseFirestore.instance.batch();

    for (final doc in collection.docs) {
      batch.delete(doc.reference);
    }

    return batch.commit();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.themeblack,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: IntrinsicHeight(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 40.0),
                height: 50,
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(widget.image),
                  backgroundColor: CommonColors.bottomgrey,
                ),
              ),

              Container(
                padding: const EdgeInsets.only(),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 18.5),
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: (){
                          Navigator.of(context).pop();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset(
                            'assets/back_icon.png',
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(right: 55, bottom: 10.0),
                          child:  Text(
                            "${widget.user_name}",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),
                          )
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                    child: Stack(
                      children: [
                        Positioned(
                          top: 10,
                          bottom: 100,
                          left: 0,
                          right: 0,
                          child: Container(
                            color: Color(0xffE3E3E3),
                            alignment: Alignment.bottomCenter,
                            margin: const EdgeInsets.only(),
                            child:

                            StreamBuilder<QuerySnapshot>(
                              stream: _firestore
                                  .collection('chatroom')
                                  .doc("${widget.room_id}")
                                  .collection('chats')
                                  .orderBy("time", descending: false)
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.data != null && luser_id!="") {
                                  return ListView.builder(
                                    // controller: _scrollController,
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      Map<String, dynamic> map = snapshot.data!.docs[index]
                                          .data() as Map<String, dynamic>;
                                      return Container(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            map['uid'] == luser_id ? Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Spacer(),
                                                Expanded(
                                                  child: Container(
                                                    alignment: Alignment.centerRight,
                                                    margin: const EdgeInsets.only(
                                                        right: 10, top: 10),
                                                    padding: const EdgeInsets.only(left: 10, top: 5, right: 20, bottom: 5),
                                                    decoration: const BoxDecoration(
                                                      color: Color(0xffFCFDFF),
                                                      borderRadius: BorderRadius.only(
                                                          topLeft: Radius.circular(25),
                                                          bottomRight:
                                                          Radius.circular(25),
                                                          bottomLeft:
                                                          Radius.circular(25)),
                                                    ),
                                                    child: Container(
                                                      alignment: Alignment.centerLeft,
                                                      child: Text(
                                                        map['message'],
                                                        textAlign: TextAlign.start,
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                              ],
                                            ):
                                            Row(
                                              mainAxisAlignment:  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(top: 20.0),
                                                  height: 50,
                                                  child: CircleAvatar(
                                                    radius: 30,
                                                    backgroundImage: NetworkImage(widget.image),
                                                    backgroundColor: CommonColors.bottomgrey,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    margin: const EdgeInsets.only( right: 10, top: 10),
                                                    padding: const EdgeInsets.only(left: 10, top: 5, right: 20, bottom: 5),
                                                    decoration: const BoxDecoration(
                                                      color: Color(0xffFCFCFC),
                                                      borderRadius: BorderRadius.only(
                                                          topLeft: Radius.circular(20),
                                                          bottomRight: Radius.circular(20),
                                                          topRight: Radius.circular(20)),
                                                    ),
                                                    child: Container(
                                                      alignment: Alignment.centerLeft,
                                                      child: Text(map['message']),
                                                    ),
                                                  ),
                                                ),
                                                Spacer(),
                                                // Container(
                                                //   margin: EdgeInsets.only(right: 20.0),
                                                //   child: Icon(
                                                //     CupertinoIcons.heart_fill,
                                                //     color: Colors.white,
                                                //   ),
                                                // ),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),

                            // ListView.builder(
                            //     shrinkWrap: false,
                            //     scrollDirection: Axis.vertical,
                            //     itemCount: messageList.length,
                            //     physics: AlwaysScrollableScrollPhysics(),
                            //     itemBuilder: (context, index){
                            //       return Container(
                            //         child: Column(
                            //           crossAxisAlignment: CrossAxisAlignment.end,
                            //           children: [
                            //             Row(
                            //               mainAxisAlignment: MainAxisAlignment.start,
                            //               children: [
                            //                 Container(
                            //                   margin: EdgeInsets.only(top: 20.0),
                            //                   height: 50,
                            //                   child: CircleAvatar(
                            //                     radius: 30,
                            //                     backgroundImage: NetworkImage(widget.image),
                            //                     backgroundColor: CommonColors.bottomgrey,
                            //                   ),
                            //                 ),
                            //                 Container(
                            //                   margin: const EdgeInsets.only( right: 10, top: 10),
                            //                   padding: const EdgeInsets.only(left: 10, top: 5, right: 20, bottom: 5),
                            //                   decoration: const BoxDecoration(
                            //                     color: Color(0xffFCFCFC),
                            //                     borderRadius: BorderRadius.only(
                            //                         topLeft: Radius.circular(20),
                            //                         bottomRight: Radius.circular(20),
                            //                         topRight: Radius.circular(20)),
                            //                   ),
                            //                   child: Container(
                            //                     alignment: Alignment.centerLeft,
                            //                     child: Text(messageList[index]),
                            //                   ),
                            //                 ),
                            //                 Spacer(),
                            //                 Container(
                            //                   margin: EdgeInsets.only(right: 20.0),
                            //                   child: Icon(
                            //                     CupertinoIcons.heart_fill,
                            //                     color: Colors.white,
                            //                   ),
                            //                 ),
                            //               ],
                            //             ),
                            //             Row(
                            //               mainAxisAlignment: MainAxisAlignment.end,
                            //               children: [
                            //                 Container(
                            //                   alignment: Alignment.centerRight,
                            //                   margin: const EdgeInsets.only(
                            //                       right: 10, top: 10),
                            //                   padding: const EdgeInsets.only(left: 10, top: 5, right: 20, bottom: 5),
                            //                   decoration: const BoxDecoration(
                            //                     color: Color(0xffFCFDFF),
                            //                     borderRadius: BorderRadius.only(
                            //                         topLeft: Radius.circular(25),
                            //                         bottomRight:
                            //                         Radius.circular(25),
                            //                         bottomLeft:
                            //                         Radius.circular(25)),
                            //                   ),
                            //                   child: Container(
                            //                     alignment: Alignment.centerLeft,
                            //                     child: Text(
                            //                       reciveList[index],
                            //                       textAlign: TextAlign.start,
                            //                     ),
                            //                   ),
                            //                 ),
                            //               ],
                            //             )
                            //           ],
                            //         ),
                            //       );
                            //     }),
                          ),
                        ),
                        Positioned(
                          right: 20,
                          left: 30,
                          bottom: 25,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  // width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffFFFFFF),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    alignment: Alignment.topLeft,
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  top: 0, right: 20, left: 20),
                                              child: TextField(
                                                controller: _message,
                                                keyboardType: TextInputType.text,
                                                maxLines: 1,
                                                decoration: InputDecoration(
                                                  hintStyle: TextStyle(
                                                      fontSize: 13, fontWeight: FontWeight.w400,
                                                      color: Colors.black),
                                                  hintText: 'Type a message',
                                                  border: InputBorder.none,
                                                  // contentPadding:
                                                  // const EdgeInsets.all(20),
                                                ),
                                              ),
                                            )
                                        ),
                                        InkWell(
                                          onTap:(){
                                            onSendMessage(widget.user_id,"${firstName} ${lastName}");
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(right: 10.0),
                                            child: Text("Send",
                                              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400,
                                                  color: Colors.black),),
                                          ),
                                        ),

                                        // SizedBox(
                                        //   width: 10,
                                        // )
                                      ],
                                    )),
                              ),
                              Container(

                                margin: EdgeInsets.only(right: 0.0, left: 20.0),
                                child: SizedBox(
                                    height: 28,
                                    width: 20,
                                    child: Image.asset("assets/chat_mic.png"))
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }


  Widget messages(Size size, Map<String, dynamic> map, BuildContext context) {
    return map['type'] == "text"
        ? Container(
      width: size.width,
      alignment: map['uid'] == widget.user_id
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: map['uid'] == widget.user_id ?
      Container(
        width: size.width / 2,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(0),
            topRight: Radius.circular(0),
            topLeft: Radius.circular(10),
          ),
          color: Colors.white,
        ),
        child: SizedBox(
          width: size.width / 2,
          child: Text(
            map['message'],
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ) :
      Container(
        width: size.width / 2,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(10),
            topRight: Radius.circular(10),
            topLeft: Radius.circular(0),
          ),
          color: Color(0xffc4c4d0),
        ),
        child: SizedBox(
          width: size.width / 2,
          child: Text(
            map['message'],
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
      ),
    )
        : Container(
      width: size.width,
      height: size.height / 4,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      alignment: map['uid'] == widget.user_id
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ShowImage(
              imageUrl: map['message'],
            ),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(border: Border.all()),
          alignment: map['message'] != "" ? null : Alignment.center,
          child: map['message'] != ""
              ? Image.network(
            map['message'],
            fit: BoxFit.fitHeight,
          )
              : const CircularProgressIndicator(),
        ),
      ),
    );
  }

}


class ShowImage extends StatelessWidget {
  final String imageUrl;

  const ShowImage({required this.imageUrl, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.black,
        child: Image.network(imageUrl),
      ),
    );
  }
}