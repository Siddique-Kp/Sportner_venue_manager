// To parse this JSON data, do
//
//     final quickBookModel = quickBookModelFromJson(jsonString);

import 'dart:convert';

QuickBookModel quickBookModelFromJson(String str) => QuickBookModel.fromJson(json.decode(str));

String quickBookModelToJson(QuickBookModel data) => json.encode(data.toJson());

class QuickBookModel {
    String? turfId;
    String? slotTime;
    String? slotDate;
    String? sport;
    String? facliity;

    QuickBookModel({
        this.turfId,
        this.slotTime,
        this.slotDate,
        this.sport,
        this.facliity,
    });

    factory QuickBookModel.fromJson(Map<String, dynamic> json) => QuickBookModel(
        turfId: json["turfId"],
        slotTime: json["slotTime"],
        slotDate: json["slotDate"],
        sport: json["sport"],
        facliity: json["facliity"],
    );

    Map<String, dynamic> toJson() => {
        "turfId": turfId,
        "slotTime": slotTime,
        "slotDate": slotDate,
        "sport": sport,
        "facliity": facliity,
    };
}
