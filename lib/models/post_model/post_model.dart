class PostModel {
  String ?name;
  String ?uId;
  String ?image;
  String ?dateTime;
  String ?text;
  String ?postImage;
  int? numLikes;

  PostModel({
    this.name,
    this.uId,
    this.image,
    this.dateTime,
    this.text,
    this.postImage,
    this.numLikes,


  });


  PostModel.fromJson(Map<String,dynamic>json){
    name=json['name'];
    uId=json['uId'];
    image=json['image'];
    dateTime=json['dateTime'];
    text=json['text'];
    postImage=json['postImage'];
    numLikes=json['numLikes'];
  }

  Map<String,dynamic>toMap(){
    return {
      'name':name,
      'uId':uId,
      'image':image,
      'dateTime':dateTime,
      'text':text,
      'postImage':postImage,
      'numLikes':numLikes,
    };
  }
}
