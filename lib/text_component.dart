import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chat/chat_screen.dart';
import 'package:image_picker/image_picker.dart';


class TextComposer extends StatefulWidget {
  
  TextComposer(this.sendMessage);

  final Function({String text, File imgFile}) sendMessage;

  @override 
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer>{

  final TextEditingController _controler =  TextEditingController();

  bool _isComposing = false;

  @override 
  Widget build(BuildContext context){
     return Container(margin: const EdgeInsets.symmetric(horizontal: 8 ),
       child: Row(children: <Widget>[
       IconButton(icon: Icon(Icons.photo_camera,color: Colors.deepOrange,), onPressed: () async {
         final File imgFile = await ImagePicker.pickImage(source: ImageSource.camera);
         if(imgFile == null ) return;
         widget.sendMessage(imgFile: imgFile);
       }
       ),
       Expanded(child: TextField(
         controller: _controler,
         decoration: InputDecoration.collapsed(hintText: "Enviar uma Mensagem"),
         onChanged: (text) {
           setState(() {
             _isComposing = text.isNotEmpty;
           });
         },
         onSubmitted: (text) {
           widget.sendMessage(text: text);
           _controler.clear();
           setState(() {
             _isComposing = false;
           });
         },
       )
       ),
       IconButton(icon: Icon(Icons.send,), onPressed: _isComposing ? () {
         widget.sendMessage(text: _controler.text);
         _controler.clear();
         setState(() {
             _isComposing = false;
           });
       } : null
       )
     ],
     ),
     );
  }}