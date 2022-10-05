class SiloPrepareRequestModel {
  final Map<String, dynamic> data;

  SiloPrepareRequestModel({
    required this.data,
  });

  factory SiloPrepareRequestModel.empty() {
    return SiloPrepareRequestModel(data: {});
  }

  SiloPrepareRequestModel copyWith({
    Map<String, dynamic>? data,
  }) {
    return SiloPrepareRequestModel(
      data: data ?? this.data,
    );
  }
}

class SiloPrepareResponseModel {
  final bool status;
  final String message;
  final Map<String, dynamic> data;

  SiloPrepareResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SiloPrepareResponseModel.empty() {
    return SiloPrepareResponseModel(
      data: {},
      message: "",
      status: false,
    );
  }

  SiloPrepareResponseModel copyWith({
    bool? status,
    String? message,
    Map<String, dynamic>? data,
  }) {
    return SiloPrepareResponseModel(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }
}

class SiloExecuteRequestModel {
  final Map<String, dynamic> data;

  SiloExecuteRequestModel({
    required this.data,
  });

  factory SiloExecuteRequestModel.empty() {
    return SiloExecuteRequestModel(data: {});
  }

  SiloExecuteRequestModel copyWith({
    Map<String, dynamic>? data,
  }) {
    return SiloExecuteRequestModel(
      data: data ?? this.data,
    );
  }
}

class SiloExecuteResponseModel {
  final bool status;
  final String message;
  final Map<String, dynamic> data;

  SiloExecuteResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SiloExecuteResponseModel.empty() {
    return SiloExecuteResponseModel(
      data: {},
      message: "",
      status: false,
    );
  }

  SiloExecuteResponseModel copyWith({
    bool? status,
    String? message,
    Map<String, dynamic>? data,
  }) {
    return SiloExecuteResponseModel(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }
}

class SiloCloseRequestModel {
  final Map<String, dynamic> data;

  SiloCloseRequestModel({
    required this.data,
  });

  factory SiloCloseRequestModel.empty() {
    return SiloCloseRequestModel(data: {});
  }

  SiloCloseRequestModel copyWith({
    Map<String, dynamic>? data,
  }) {
    return SiloCloseRequestModel(
      data: data ?? this.data,
    );
  }
}

class SiloCloseResponseModel {
  final bool status;
  final String message;
  final Map<String, dynamic> data;

  SiloCloseResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SiloCloseResponseModel.empty() {
    return SiloCloseResponseModel(
      data: {},
      message: "",
      status: false,
    );
  }

  SiloCloseResponseModel copyWith({
    bool? status,
    String? message,
    Map<String, dynamic>? data,
  }) {
    return SiloCloseResponseModel(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }
}
