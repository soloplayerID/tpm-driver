class LoginResponse {
  bool status;
  Data data;

  LoginResponse({this.status, this.data});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String message;
  String idUser;
  String region;
  String username;
  String role;
  String roleName;
  String token;

  Data(
      {this.message,
      this.idUser,
      this.region,
      this.username,
      this.role,
      this.roleName,
      this.token});

  Data.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    idUser = json['id_user'];
    region = json['region'];
    username = json['username'];
    role = json['role'];
    roleName = json['role_name'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['id_user'] = this.idUser;
    data['region'] = this.region;
    data['username'] = this.username;
    data['role'] = this.role;
    data['role_name'] = this.roleName;
    data['token'] = this.token;
    return data;
  }
}
