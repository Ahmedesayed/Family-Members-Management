
class User {
  String id;
  String name;
  int points;
  String mobileNumber;

  User({
    this.id,
    this.name,
    this.points,
    this.mobileNumber,
  });

  User.fromJson(Map<String, Object> json)
      : this(
          id: json['id'] as String,
          name: json['name'] as String,
          mobileNumber: json['mobileNumber'] as String,
          points: json['points'] as int,
        );

  Map<String, Object> toJson() {
    return {
      'name': name,
      'points': points,
      'mobileNumber': mobileNumber,
    };
  }
}
