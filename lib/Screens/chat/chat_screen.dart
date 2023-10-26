import 'package:HackathonApp/Screens/chat/chat_service.dart';
import 'package:HackathonApp/Wigdets/chatbubble.dart';
import 'package:HackathonApp/conStants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class CustomChatScreen extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserID;
  final String receiverName;
  const CustomChatScreen(
      {super.key,
      required this.receiverUserEmail,
      required this.receiverUserID,
      required this.receiverName});

  @override
  State<CustomChatScreen> createState() => _CustomChatScreenState();
}

class _CustomChatScreenState extends State<CustomChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final chatService _chatService = chatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_messageController.text.toString().trim().isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverUserID, _messageController.text.toString().trim());
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkthemecolor,
        title: Text(widget.receiverName),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
        stream: _chatService.getMessage(
            widget.receiverUserID, _firebaseAuth.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error" + snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          return ListView(
            children: snapshot.data!.docs
                .map((document) => _buildMessageItem(document))
                .toList(),
          );
        });
  }

  // Widget _buildMessageItem(DocumentSnapshot document) {
  //   Map<String, dynamic> data = document.data() as Map<String, dynamic>;

  //   var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
  //       ? Alignment.centerRight
  //       : Alignment.centerLeft;
  //   return Container(
  //     alignment: alignment,
  //     child: Column(
  //       children: [
  //         Text(data["senderEmail"]),
  //         Text(data["message"]),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    var alignment = (data["senderId"] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      // margin: EdgeInsets.only(left: 20),

      // decoration: const BoxDecoration(
      //   color: Color(0xffDCF8C6),
      //   borderRadius: BorderRadius.only(
      //     topRight: Radius.circular(18),
      //     bottomLeft: Radius.circular(18),
      //     bottomRight: Radius.circular(18),
      //   ),
      // ),
      alignment: alignment,
      child: Column(
        crossAxisAlignment: (data["senderId"] == _firebaseAuth.currentUser!.uid)
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        mainAxisAlignment: (data["senderId"] == _firebaseAuth.currentUser!.uid)
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          ChatBubble(
              message: data["message"],
              color: (data["senderId"] == _firebaseAuth.currentUser!.uid)
                  ? AppColors.ChatBlockforSender
                  : AppColors.ChatBlockforReceiver)
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _messageController,
            obscureText: false,
          ),
        ),
        IconButton(onPressed: sendMessage, icon: const Icon(Icons.arrow_back))
      ],
    );
  }
}



// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:whatsapp_clone/Widgets/chatbubble.dart';
// import 'package:whatsapp_clone/Widgets/chatservice.dart';
// import 'package:whatsapp_clone/Widgets/colors.dart';

// class ChatScreen extends StatefulWidget {
//   const ChatScreen({
//     required this.receiverUserEmail,
//     required this.receiverUserID,
//     required this.receiverName,
//   });

//   final String receiverUserEmail;
//   final String receiverUserID;
//   final String receiverName;

//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final TextEditingController _messageController = TextEditingController();
//   final ChatService _chatService = ChatService();
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

//   void sendMessage() async {
    
//     if (_messageController.text.trim().isNotEmpty) {
//       await _chatService.sendMessage(
//         widget.receiverUserID, _messageController.text.trim());
//       _messageController.clear();
//   }
//     }

    

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xffECE5DD),
//       appBar: AppBar(
//         backgroundColor: const Color(0xff008069),
//         title: Text(widget.receiverName),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: _buildMessageList(),
//           ),
//           _buildMessageInput(),
//         ],
//       ),
//     );
//   }

//   Widget _buildMessageList() {
//     return StreamBuilder(
//       stream: _chatService.getMessages(
//           widget.receiverUserID, _firebaseAuth.currentUser!.uid),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error.toString()}');
//         }
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Text("Loading");
//         }
//         return ListView(
//           children: snapshot.data!.docs
//               .map((document) => _buildMessageItem(document))
//               .toList(),
//         );
//       },
//     );
//   }

//   Widget _buildMessageItem(DocumentSnapshot document) {
//     Map<String, dynamic> data = document.data() as Map<String, dynamic>;

//     var alignment = (data["senderId"] == _firebaseAuth.currentUser!.uid)
//         ? Alignment.centerRight
//         : Alignment.centerLeft;

//     return Container(
//       // margin: EdgeInsets.only(left: 20),

//       // decoration: const BoxDecoration(
//       //   color: Color(0xffDCF8C6),
//       //   borderRadius: BorderRadius.only(
//       //     topRight: Radius.circular(18),
//       //     bottomLeft: Radius.circular(18),
//       //     bottomRight: Radius.circular(18),
//       //   ),
//       // ),
//       alignment: alignment,
//       child: Column(
//         crossAxisAlignment: (data["senderId"] == _firebaseAuth.currentUser!.uid)
//             ? CrossAxisAlignment.end
//             : CrossAxisAlignment.start,
//         mainAxisAlignment: (data["senderId"] == _firebaseAuth.currentUser!.uid)
//             ? MainAxisAlignment.end
//             : MainAxisAlignment.start,
//         children: [
//           ChatBubble(
//               message: data["message"],
//               color: (data["senderId"] == _firebaseAuth.currentUser!.uid)
//                   ? AppColors.ChatBlockforSender
//                   : AppColors.ChatBlockforReceiver)
//         ],
//       ),
//     );
//   }

//   Widget _buildMessageInput() {
//     return Row(
//       children: [
//         Expanded(
//           child: TextField(
//             controller: _messageController,
//             decoration: const InputDecoration(labelText: 'Enter message'),
//             obscureText: false,
//           ),
//         ),
//         IconButton(
//           onPressed: sendMessage,
//           icon: const Icon(
//             Icons.send,
//             size: 40,
//           ),
//         )
//       ],
//     );
//   }
// }
