class ClassModel {
  String className;
  String classTime;
  String day;

  ClassModel({
    required this.className,
    required this.classTime,
    required this.day,
  });

  Map<String, dynamic> toMap() {
    return {
      'className': className,
      'classTime': classTime,
      'day': day,
    };
  }

  factory ClassModel.fromMap(Map<String, dynamic> map) {
    return ClassModel(
      className: map['className'],
      classTime: map['classTime'],
      day: map['day'],
    );
  }
}
