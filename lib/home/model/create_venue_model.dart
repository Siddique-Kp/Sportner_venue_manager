// To parse this JSON data, do
//
//     final createVenueModel = createVenueModelFromJson(jsonString);

import 'dart:convert';

CreateVenueModel createVenueModelFromJson(Map<String,dynamic> str) => CreateVenueModel.fromJson(str);

String createVenueModelToJson(CreateVenueModel data) => json.encode(data.toJson());

class CreateVenueModel {
  String? venueName;
  String? mobile;
  String? district;
  String? place;
  String? actualPrice;
  String? discountPercentage;
  String? description;
  String? image;
  String? document;
  List<Slots>? slots;
  List<SportFacility>? sportFacility;
  String? lat;
  String? lng;

  CreateVenueModel(
      {this.venueName,
      this.mobile,
      this.district,
      this.place,
      this.actualPrice,
      this.discountPercentage,
      this.description,
      this.image,
      this.document,
      this.slots,
      this.sportFacility,
      this.lat,
      this.lng});

  CreateVenueModel.fromJson(Map<String, dynamic> json) {
    venueName = json['venueName'];
    mobile = json['mobile'];
    district = json['district'];
    place = json['place'];
    actualPrice = json['actualPrice'];
    discountPercentage = json['discountPercentage'];
    description = json['description'];
    image = json['image'];
    document = json['document'];
    if (json['slots'] != null) {
      slots = <Slots>[];
      json['slots'].forEach((v) {
        slots!.add( Slots.fromJson(v));
      });
    }
    if (json['sportFacility'] != null) {
      sportFacility = <SportFacility>[];
      json['sportFacility'].forEach((v) {
        sportFacility!.add( SportFacility.fromJson(v));
      });
    }
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['venueName'] =venueName;
    data['mobile'] =mobile;
    data['district'] =district;
    data['place'] =place;
    data['actualPrice'] =actualPrice;
    data['discountPercentage'] =discountPercentage;
    data['description'] =description;
    data['image'] =image;
    data['document'] =document;
    if (slots != null) {
      data['slots'] =slots!.map((v) => v.toJson()).toList();
    }
    if (sportFacility != null) {
      data['sportFacility'] =
         sportFacility!.map((v) => v.toJson()).toList();
    }
    data['lat'] =lat;
    data['lng'] =lng;
    return data;
  }
}

class Slots {
  String? day;
  List<String>? slots;

  Slots({this.day, this.slots});

  Slots.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    slots = json['slots'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  {};
    data['day'] = day;
    data['slots'] = slots;
    return data;
  }
}

class SportFacility {
  String? sportId;
  String? sport;
  String? facility;

  SportFacility({this.sportId, this.sport, this.facility});

  SportFacility.fromJson(Map<String, dynamic> json) {
    sportId = json['sportId'];
    sport = json['sport'];
    facility = json['facility'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['sportId'] = sportId;
    data['sport'] = sport;
    data['facility'] = facility;
    return data;
  }
}
