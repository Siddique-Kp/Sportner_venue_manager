import 'dart:convert';

VendorSignupModel vendorSignupModelFromJson(Map<String, dynamic> str) =>
    VendorSignupModel.fromJson(str);

String vendorSignupModelToJson(VendorSignupModel data) =>
    json.encode(data.toJson());

class VendorSignupModel {
  VendorSignupModel({
    this.mobile,
    this.name,
    this.password,
    this.image,
    this.accessToken,
  });

  String? mobile;
  String? name;
  String? password;
  String? image;
  String? accessToken;

  factory VendorSignupModel.fromJson(Map<String, dynamic> json) =>
      VendorSignupModel(
        mobile: json["mobile"],
        name: json["name"],
        password: json["password"],
        image: json["image"],
        accessToken: json["accessToken"],
      );

  Map<String, dynamic> toJson() => {
        "mobile": mobile,
        "name": name,
        "password": password,
        "image": image,
      };
}
