// To parse this JSON data, do
//
//     final vendorLoginModel = vendorLoginModelFromJson(jsonString);

import 'dart:convert';

VendorLoginModel vendorLoginModelFromJson(Map<String, dynamic> str) => VendorLoginModel.fromJson(str);

String vendorLoginModelToJson(VendorLoginModel data) => json.encode(data.toJson());

class VendorLoginModel {
    VendorLoginModel({
        this.mobile,
        this.password,
        this.accessToken,
        this.name,
        this.document,
        this.status,
        this.reason,
    });

    String? mobile;
    String? password;
    String? accessToken;
    String? name;
    String? document;
    String? status;
    String? reason;

    factory VendorLoginModel.fromJson(Map<String, dynamic> json) => VendorLoginModel(
        mobile: json["mobile"],
        password: json["password"],
        accessToken: json["accessToken"],
        name: json["name"],
        document: json["document"],
        status: json["status"],
        reason: json["reason"],
    );

    Map<String, dynamic> toJson() => {
        "mobile": mobile,
        "password": password,
    };
}
