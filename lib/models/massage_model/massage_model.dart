class MessageModel {
  String? senderID;
  String? reciverID;
  String? dateTime;
  String? text;

  MessageModel({
    this.senderID,
    this.reciverID,
    this.dateTime,
    this.text,
  });


  MessageModel.fromJson(Map<String,dynamic>json){
    senderID=json['senderID'];
    reciverID=json['reciverID'];
    dateTime=json['dateTime'];
    text=json['text'];
  }

  Map<String,dynamic>toMap(){
    return {
      'senderID':senderID,
      'reciverID':reciverID,
      'dateTime':dateTime,
      'text':text,

    };
  }
}
