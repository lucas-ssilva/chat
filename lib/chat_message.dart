import 'dart:io';
import 'package:chat/text_component.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:chat/main.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ChatMessage extends StatelessWidget {

  ChatMessage(this.data, this.quem); 

  final Map<String, dynamic> data;
  final bool quem; 


  @override 
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        children: <Widget>[
          !quem ?
          Padding(padding: const EdgeInsets.only(right: 16),
          child: CircleAvatar(
            backgroundImage: NetworkImage(data["SenderPhoto"]),
          ),) : Container(),
          Expanded(child: Column(
            crossAxisAlignment: quem ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: <Widget>[
            data["imgUrl"] != null ?
            Image.network(data["imgUrl"], width: 150) : Text(data["text"],textAlign: quem ? TextAlign.end : TextAlign.start,
            style: TextStyle(fontSize: 16),),
            Text(data["senderName"],style: TextStyle(fontSize:13, fontWeight: FontWeight.w500),
            ),
          ],)),
          quem ?
          Padding(padding: const EdgeInsets.only(left: 16),
          child: CircleAvatar(
            backgroundImage: NetworkImage(data["SenderPhoto"]),
          ),) : Container(),
        ]
      ),
    );
  }
}