class User{
  int id;
  String username;
  String email;
  String jwt;
  String phoneNumber;

  User({this.id,this.email,this.username,this.jwt,this.phoneNumber});

  User.fromJson(Map<String, dynamic> json) {
    id= json['user']['id'];
    username = json['user']['username'];
    email =json['user']['email'];
    jwt = json['jwt'];
    phoneNumber = json['phoneNumber'];
  }
  User.ProfilefromJson(Map<String, dynamic> json) {
    id= json['id'];
    username = json['username'];
    email =json['email'];
    phoneNumber= json['phoneNumber'];
  }
}