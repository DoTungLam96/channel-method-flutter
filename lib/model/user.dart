// ignore_for_file: public_member_api_docs, sort_constructors_first

class User {
  String? nickName;

  int? id;

  User({
    this.nickName,
    this.id,
  });

  User.fromJson(Map<String, dynamic> json) {
    nickName = json['nickName'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nickName'] = nickName;
    data['id'] = id;
    return data;
  }
}
