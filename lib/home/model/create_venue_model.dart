// To parse this JSON data, do
//
//     final createVenueModel = createVenueModelFromJson(jsonString);

import 'dart:convert';

CreateVenueModel createVenueModelFromJson(String str) => CreateVenueModel.fromJson(json.decode(str));

String createVenueModelToJson(CreateVenueModel data) => json.encode(data.toJson());

class CreateVenueModel {
    CreateVenueModel({
        this.venueName,
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
        this.lng,
    });

    String? venueName;
    int? mobile;
    String? district;
    String? place;
    int? actualPrice;
    int? discountPercentage;
    String? description;
    String? image;
    String? document;
    List<Slot>? slots;
    List<SportFacility>? sportFacility;
    double? lat;
    double? lng;

    factory CreateVenueModel.fromJson(Map<String, dynamic> json) => CreateVenueModel(
        venueName: json["venueName"],
        mobile: json["mobile"],
        district: json["district"],
        place: json["place"],
        actualPrice: json["actualPrice"],
        discountPercentage: json["discountPercentage"],
        description: json["description"],
        image: json["image"],
        document: json["document"],
        slots: json["slots"] == null ? [] : List<Slot>.from(json["slots"]!.map((x) => Slot.fromJson(x))),
        sportFacility: json["sportFacility"] == null ? [] : List<SportFacility>.from(json["sportFacility"]!.map((x) => SportFacility.fromJson(x))),
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "venueName": venueName,
        "mobile": mobile,
        "district": district,
        "place": place,
        "actualPrice": actualPrice,
        "discountPercentage": discountPercentage,
        "description": description,
        "image": image,
        "document": document,
        "slots": slots == null ? [] : List<dynamic>.from(slots!.map((x) => x.toJson())),
        "sportFacility": sportFacility == null ? [] : List<dynamic>.from(sportFacility!.map((x) => x.toJson())),
        "lat": lat,
        "lng": lng,
    };
}

class Slot {
    Slot({
        this.day,
        this.slots,
    });

    String? day;
    List<String>? slots;

    factory Slot.fromJson(Map<String, dynamic> json) => Slot(
        day: json["day"],
        slots: json["slots"] == null ? [] : List<String>.from(json["slots"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "day": day,
        "slots": slots == null ? [] : List<dynamic>.from(slots!.map((x) => x)),
    };
}

class SportFacility {
    SportFacility({
        this.sportId,
        this.sport,
        this.facility,
    });

    String? sportId;
    String? sport;
    String? facility;

    factory SportFacility.fromJson(Map<String, dynamic> json) => SportFacility(
        sportId: json["sportId"],
        sport: json["sport"],
        facility: json["facility"],
    );

    Map<String, dynamic> toJson() => {
        "sportId": sportId,
        "sport": sport,
        "facility": facility,
    };
}
