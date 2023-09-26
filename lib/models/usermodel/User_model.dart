class UserModel {
  String ?name;
  String ?email;
  String ?phone;
  String ?uId;
  String ?image;
  String ?cover;
  String ?bio;
  bool ?isEmailVerified;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    this.uId,
    this.image,
    this.cover,
    this.bio,
    this.isEmailVerified,
  });


  UserModel.fromJson(Map<String,dynamic>json){
    name=json['name'];
    email=json['enail'];
    phone=json['phone'];
    uId=json['uId'];
    image=json['image'];
    cover=json['cover'];
    bio=json['bio'];
    isEmailVerified=json['isEmailVerified'];
  }

  Map<String,dynamic>toMap(){
    return {
      'name':name,
      'email':email,
      'phone':phone,
      'uId':uId,
      'image':image,
      'cover':cover,
      'bio':bio,
      'isEmailVerified':isEmailVerified,
    };
  }
}
