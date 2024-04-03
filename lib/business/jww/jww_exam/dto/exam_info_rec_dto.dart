// To parse this JSON data, do
//
//     final examRec = examRecFromJson(jsonString);
class ExamInfoRecDTO {
  ExamInfoRecDTO({
    required this.courseId,
    required this.courseName,
    required this.studentName,
    required this.examTime,
    required this.examTimeStart,
    required this.examTimeEnd,
    required this.examLocation,
    required this.examForm,
    required this.seatNumber,
    required this.examSchool,
  });

  String courseId;
  String courseName;
  String studentName;
  String? examTime;
  String? examTimeStart;
  String? examTimeEnd;
  String examLocation;
  String examForm;
  String seatNumber;
  String examSchool;

  factory ExamInfoRecDTO.fromJson(Map<String, dynamic> json) => ExamInfoRecDTO(
        courseId: json["courseId"],
        courseName: json["courseName"],
        studentName: json["studentName"],
        examTime: json["examTime"],
        examTimeStart: json["examTimeStart"],
        examTimeEnd: json["examTimeEnd"],
        examLocation: json["examLocation"],
        examForm: json["examForm"],
        seatNumber: json["seatNumber"],
        examSchool: json["examSchool"],
      );

  Map<String, dynamic> toJson() => {
        "courseId": courseId,
        "courseName": courseName,
        "studentName": studentName,
        "examTime": examTime,
        "examTimeStart": examTimeStart,
        "examTimeEnd": examTimeEnd,
        "examLocation": examLocation,
        "examForm": examForm,
        "seatNumber": seatNumber,
        "examSchool": examSchool,
      };
}
