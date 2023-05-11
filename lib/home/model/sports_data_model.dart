import 'dart:convert';

SportsDataModel sportsDataModelFromJson(Map<String, dynamic> str) =>
    SportsDataModel.fromJson(str);

String sportsDataModelToJson(SportsDataModel data) =>
    json.encode(data.toJson());

class SportsDataModel {
  SportsDataModel({
    this.response,
  });

  List<Response>? response;

  factory SportsDataModel.fromJson(Map<String, dynamic> json) =>
      SportsDataModel(
        response: json["response"] == null
            ? []
            : List<Response>.from(
                json["response"]!.map((x) => Response.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "response": response == null
            ? []
            : List<dynamic>.from(response!.map((x) => x.toJson())),
      };
}

class Response {
  Response({
    this.id,
    this.sport,
    this.facilityDetails,
  });

  String? id;
  String? sport;
  List<FacilityDetail>? facilityDetails;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        id: json["_id"],
        sport: json["sport"],
        facilityDetails: json["facilityDetails"] == null
            ? []
            : List<FacilityDetail>.from(json["facilityDetails"]!
                .map((x) => FacilityDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "sport": sport,
        "facilityDetails": facilityDetails == null
            ? []
            : List<dynamic>.from(facilityDetails!.map((x) => x.toJson())),
      };
}

class FacilityDetail {
  FacilityDetail({
    this.facility,
    this.count,
    this.status,
  });

  String? facility;
  int? count;
  bool? status;

  factory FacilityDetail.fromJson(Map<String, dynamic> json) => FacilityDetail(
        facility: json["facility"],
        count: json["count"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "facility": facility,
        "count": count,
        "status": status,
      };
}
