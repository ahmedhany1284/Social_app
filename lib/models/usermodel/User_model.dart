class UserModel {
  String ?name;
  String ?email;
  String ?phone;
  String ?uId;
  String ?image;
  String ?bio;
  bool ?isEmailVerified;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    this.uId,
    this.image,
    this.bio,
    this.isEmailVerified,
  });


  UserModel.fromJson(Map<String,dynamic>json){
    name=json['name'];
    email=json['enail'];
    phone=json['phone'];
    uId=json['uId'];
    image=json['image'];
    bio=json['bio'];
    isEmailVerified=json['isEmailVerified'];
  }

  Map<String,dynamic>toMap(){
    return {
      'name':name,
      'email':email,
      'phone':phone,
      'uId':uId,
      'isEmailVerified':isEmailVerified,
    };
  }
}
