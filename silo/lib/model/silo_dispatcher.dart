class SiloDispatcherModel {
  final Map<String, dynamic> data;
  final String type;

  static String exampleUseCaseType = "ExampleUseCase";

  bool isExampleUseCaseType() => type == exampleUseCaseType;

  SiloDispatcherModel({
    required this.data,
    required this.type,
  });
}
