import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessageModel {
  int senderID;
  int receiverID;
  String message;
  DateTime timestamp;
  MessageModel(this.senderID, this.receiverID, this.message, this.timestamp);
}
final countMessageProvider = StateProvider<int>((ref){
  return 0;
});