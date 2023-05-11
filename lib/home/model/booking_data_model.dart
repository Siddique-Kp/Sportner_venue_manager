// To parse this JSON data, do
//
//     final bookingDataModel = bookingDataModelFromJson(jsonString);

import 'dart:convert';

List<BookingDataModel> bookingDataModelFromJson(List<dynamic> str) =>
    List<BookingDataModel>.from(str.map((x) => BookingDataModel.fromJson(x)));

String bookingDataModelToJson(List<BookingDataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookingDataModel {
  BookingDataModel({
    this.id,
    this.slotTime,
    this.sport,
    this.facility,
    this.slotDate,
    this.price,
    this.paymentType,
    this.venueId,
    this.venueName,
    this.name,
    this.mobile,
    this.refund,
  });

  String? id;
  String? slotTime;
  String? sport;
  String? facility;
  String? slotDate;
  int? price;
  String? paymentType;
  String? venueId;
  String? venueName;
  String? name;
  String? mobile;
  String? refund;

  factory BookingDataModel.fromJson(Map<String, dynamic> json) =>
      BookingDataModel(
        id: json["_id"],
        slotTime: json["slotTime"],
        sport: json["sport"],
        facility: json["facility"],
        slotDate: json["slotDate"],
        price: json["price"],
        paymentType: json["paymentType"],
        venueId: json["venueId"],
        venueName: json["venueName"],
        name: json["name"],
        mobile: json["mobile"],
        refund: json["refund"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "slotTime": slotTime,
        "sport": sport,
        "facility": facility,
        "slotDate": slotDate,
        "price": price,
        "paymentType": paymentType,
        "venueId": venueId,
        "venueName": venueName,
        "name": name,
        "mobile": mobile,
        "refund": refund,
      };
}
