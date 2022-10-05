import 'dart:convert';

class ExampleUseCaseModel {
  final int id;
  final String pool;
  final int ph;

  static String topicId = "0.0.48513396";

  static String pool1 = "L-1";
  static String pool2 = "L-2";
  static String pool3 = "L-3";
  static List<String> poolList = [
    pool1,
    pool2,
    pool3,
  ];

  ExampleUseCaseModel({
    required this.id,
    required this.pool,
    required this.ph,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pool': pool,
      'ph': ph,
    };
  }

  factory ExampleUseCaseModel.fromMap(Map<String, dynamic> map) {
    return ExampleUseCaseModel(
      id: map['id']?.toInt() ?? 0,
      pool: map['pool'] ?? '',
      ph: map['ph']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExampleUseCaseModel.fromJson(String source) =>
      ExampleUseCaseModel.fromMap(json.decode(source));
}
