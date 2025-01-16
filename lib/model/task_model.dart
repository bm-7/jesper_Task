class TaskModel {
  final int organizationId;
  final int branchId;
  final String branchCode;
  final String branchName;
  final String branchImage;
  final String mobileNumber;
  final String alterMobileNumber;
  final String minimumOrderValue;
  final String deliveryDistance;
  final String latitude;
  final String longitude;
  final String openingFromTime1;
  final String openingToTime1;
  final String openingFromTime2;
  final String openingToTime2;
  final String openingFromTime3;
  final String openingToTime3;
  final String mapLocation;
  final String organizationName;
  final String email;
  final String locationName;
  final String taxNumber;
  final int totalRatingCount;
  final String averageRating;

  TaskModel({
    required this.organizationId,
    required this.branchId,
    required this.branchCode,
    required this.branchName,
    required this.branchImage,
    required this.mobileNumber,
    required this.alterMobileNumber,
    required this.minimumOrderValue,
    required this.deliveryDistance,
    required this.latitude,
    required this.longitude,
    required this.openingFromTime1,
    required this.openingToTime1,
    required this.openingFromTime2,
    required this.openingToTime2,
    required this.openingFromTime3,
    required this.openingToTime3,
    required this.mapLocation,
    required this.organizationName,
    required this.email,
    required this.locationName,
    required this.taxNumber,
    required this.totalRatingCount,
    required this.averageRating,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      organizationId: json['organizationId'],
      branchId: json['branchId'],
      branchCode: json['branchCode'],
      branchName: json['branchName'],
      branchImage: json['branchImage'],
      mobileNumber: json['mobileNumber'],
      alterMobileNumber: json['alterMobileNumber'] ?? "",
      minimumOrderValue: json['minimumOrderValue'],
      deliveryDistance: json['deliveryDistance'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      openingFromTime1: json['openingFromTime_1'],
      openingToTime1: json['openingToTime_1'],
      openingFromTime2: json['openingFromTime_2'],
      openingToTime2: json['openingToTime_2'],
      openingFromTime3: json['openingFromTime_3'],
      openingToTime3: json['openingToTime_3'],
      mapLocation: json['mapLocation'],
      organizationName: json['organizationName'],
      email: json['email'] ?? "",
      locationName: json['locationName'],
      taxNumber: json['taxNumber'] ?? "",
      totalRatingCount: json['totalRatingCount'],
      averageRating: json['averageRating'],
    );
  }
}

class TaskResponse {
  final int httpCode;
  final int status;
  final String message;
  final List<TaskModel> branches;

  TaskResponse({
    required this.httpCode,
    required this.status,
    required this.message,
    required this.branches,
  });

  factory TaskResponse.fromJson(Map<String, dynamic> json) {
    return TaskResponse(
      httpCode: json['httpCode'],
      status: json['status'],
      message: json['message'],
      branches: List<TaskModel>.from(
          json['data'].map((json) => TaskModel.fromJson(json))),
    );
  }
}
