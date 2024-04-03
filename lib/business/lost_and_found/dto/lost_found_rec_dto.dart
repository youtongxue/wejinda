import 'dart:convert';

LostFoundRecDTO lostFoundRecFromJson(String str) =>
    LostFoundRecDTO.fromJson(json.decode(str));

String lostFoundRecToJson(LostFoundRecDTO data) => json.encode(data.toJson());

class LostFoundRecDTO {
  int id;
  String userId;
  String lostId;
  String type;
  String userContact;
  String userImage;
  String userName;
  String pickupTime;
  String pickupLocation;
  String shortDesc;
  String description;
  List<String> fileUrl;
  String checkStatus;
  String city;
  String imgCount;
  String imgWidth;
  String imgHeight;
  String upLoadTime;

  LostFoundRecDTO({
    required this.id,
    required this.userId,
    required this.lostId,
    required this.type,
    required this.userContact,
    required this.userImage,
    required this.userName,
    required this.pickupTime,
    required this.pickupLocation,
    required this.shortDesc,
    required this.description,
    required this.fileUrl,
    required this.checkStatus,
    required this.city,
    required this.imgCount,
    required this.imgWidth,
    required this.imgHeight,
    required this.upLoadTime,
  });

  factory LostFoundRecDTO.fromJson(Map<String, dynamic> json) =>
      LostFoundRecDTO(
        id: json["id"],
        userId: json["userId"],
        lostId: json["lostId"],
        type: json["type"],
        userContact: json["userContact"],
        userImage: json["userImage"],
        userName: json["userName"],
        pickupTime: json["pickupTime"],
        pickupLocation: json["pickupLocation"],
        shortDesc: json["shortDesc"],
        description: json["description"],
        fileUrl: List<String>.from(jsonDecode(json["fileUrl"]).map((x) => x)),
        checkStatus: json["checkStatus"],
        city: json["city"],
        imgCount: json["imgCount"],
        imgWidth: json["imgWidth"],
        imgHeight: json["imgHeight"],
        upLoadTime: json["upLoadTime"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "lostId": lostId,
        "type": type,
        "userContact": userContact,
        "userImage": userImage,
        "userName": userName,
        "pickupTime": pickupTime,
        "pickupLocation": pickupLocation,
        "shortDesc": shortDesc,
        "description": description,
        "fileUrl": jsonEncode(List<dynamic>.from(fileUrl.map((x) => x))),
        "checkStatus": checkStatus,
        "city": city,
        "imgCount": imgCount,
        "imgWidth": imgWidth,
        "imgHeight": imgHeight,
        "upLoadTime": upLoadTime,
      };
}
