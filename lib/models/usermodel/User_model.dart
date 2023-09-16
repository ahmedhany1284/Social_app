class UserModel {
  String ?name;
  String ?email;
  String ?phone;
  String ?uId;
  bool ?isEmailVerified;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    this.uId,
    this.isEmailVerified,
  });


  UserModel.fromJson(Map<String,dynamic>json){
    name=json['name'];
    email=json['enail'];
    phone=json['phone'];
    uId=json['uId'];
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
