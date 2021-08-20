class LoginModel {
  String id;
  String pw;

  LoginModel({id, pw});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pw'] = this.pw;
    return data;
  }
}
