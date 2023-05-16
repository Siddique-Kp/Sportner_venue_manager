import 'dart:convert';

List<SlotAvailabilityModel> slotAvailabilityModelFromJson(List<dynamic> str) =>
    List<SlotAvailabilityModel>.from(
        str.map((x) => SlotAvailabilityModel.fromJson(x)));

String slotAvailabilityModelToJson(SlotAvailabilityModel data) =>
    json.encode(data.toJson());

class SlotAvailabilityModel {
  String? turfId;
  String? slotDate;
  String? slotTime;

  SlotAvailabilityModel({
    this.turfId,
    this.slotDate,
    this.slotTime,
  });

  factory SlotAvailabilityModel.fromJson(Map<String, dynamic> json) =>
      SlotAvailabilityModel(
        slotTime: json["slotTime"],
      );

  Map<String, dynamic> toJson() => {
        "turfId": turfId,
        "slotDate": slotDate,
      };
}
