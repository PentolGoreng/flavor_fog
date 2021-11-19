import 'package:cloud_firestore/cloud_firestore.dart';

enum ChatMessageType { text, audio, image, video }
enum MessageStatus { not_sent, not_view, viewed }
final db = FirebaseFirestore.instance;
DocumentReference docRef = db.collection("forum").doc("chats");
Source source = Source.server;

class ChatMessage {
  final String text;
  final ChatMessageType messageType;
  final MessageStatus messageStatus;
  final bool isSender;
  final String sender;

  ChatMessage({
    this.text = '',
    required this.messageType,
    required this.messageStatus,
    required this.isSender,
    required this.sender,
  });
}

List demeChatMessages = [
  ChatMessage(
    text: "Hi Sajol,",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: false,
    sender: 'asu',
  ),
  ChatMessage(
      text: "Hello, How are you?",
      messageType: ChatMessageType.text,
      messageStatus: MessageStatus.viewed,
      isSender: true,
      sender: 'Alex'),
  // ChatMessage(
  //   text: "",
  //   messageType: ChatMessageType.audio,
  //   messageStatus: MessageStatus.viewed,
  //   isSender: false,
  //   sender: 'orang',
  // ),
  // ChatMessage(
  //   text: "",
  //   messageType: ChatMessageType.video,
  //   messageStatus: MessageStatus.viewed,
  //   isSender: true,
  //   sender: 'siapa'
  // ),
  // ChatMessage(
  //   text: "Error happend",
  //   messageType: ChatMessageType.text,
  //   messageStatus: MessageStatus.not_sent,
  //   isSender: true,
  // ),
  // ChatMessage(
  //   text: "This looks great man!!",
  //   messageType: ChatMessageType.text,
  //   messageStatus: MessageStatus.viewed,
  //   isSender: false,
  // ),
  // ChatMessage(
  //   text: "Glad you like it",
  //   messageType: ChatMessageType.text,
  //   messageStatus: MessageStatus.not_view,
  //   isSender: true,
  // ),
];
