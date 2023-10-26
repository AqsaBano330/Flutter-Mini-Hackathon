import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;

  final Color color;
  const ChatBubble({super.key, required this.message, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.only(left:20, right:20,top:10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(

        borderRadius: BorderRadius.only(
          topRight: Radius.circular(18),
          bottomLeft: Radius.circular(18),
          bottomRight: Radius.circular(18),
        ),
        color: color,
      ),
      child:Text("    ${message}    "),
      
    );
  }
}
