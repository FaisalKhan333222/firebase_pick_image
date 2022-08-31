class Modal {
  String? uid;
  String? name;
  String? email;
  Modal({this.uid, this.name, this.email});
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'uid': uid,
    };
  }

  Modal.fromMap(map)
      : name = map['name'],
        email = map['email'],
        uid = map['uid'];
}
