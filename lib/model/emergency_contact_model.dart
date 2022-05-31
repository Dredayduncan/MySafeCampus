class EmergencyContact {
  final String? userID;
  final String? name;
  final String? pushToken;
  final String? contact;

  EmergencyContact({
    this.userID,
    this.name,
    this.pushToken,
    this.contact,
  });

  factory EmergencyContact.fromJson(Map<String, dynamic> json) {
    return EmergencyContact(
      userID: json['user_id'],
      name: json["name"],
      pushToken: json["email"],
      contact: json["contact"],
    );
  }

  Map<String, dynamic> toJson() => {
    'userID': userID.toString(),
    'name': name,
    'emailAddress': pushToken,
    'contact': contact
  };
}