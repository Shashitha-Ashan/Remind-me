class BirthdayModel {
  final String name;
  final DateTime dateTime;

  BirthdayModel({required this.dateTime, required this.name});
  BirthdayModel.fromJson(Map<String, Object?> json)
      : this(
          name: json['name']! as String,
          dateTime: json['date']! as DateTime,
        );

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'age': dateTime,
    };
  }
}
