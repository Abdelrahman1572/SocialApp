class MessageModel{
  String? senderId;
  String? receviverId;
  String? dateTime;
  String? text;
  MessageModel({
    this.senderId,
    this.receviverId,
    this.dateTime,
    this.text,
  });
  MessageModel.fromJson(Map<String,dynamic> json){
    senderId = json['senderId'];
    receviverId = json['receviverId'];
    dateTime = json['dateTime'];
    text = json['text'];
  }
  Map<String,dynamic> toMap(){
    return {
      'senderId' : senderId,
      'receviverId' : receviverId,
      'dateTime' : dateTime,
      'text' : text,
    };
  }
}