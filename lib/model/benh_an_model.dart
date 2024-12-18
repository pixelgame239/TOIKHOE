import 'package:cloud_firestore/cloud_firestore.dart';

class BenhAnModel {
  String ten;
  String danToc;
  String ngaySinh;
  String gender;
  String ngayNhapVien;
  String ngayRaVien;
  String chanDoanVaoVien;
  String chanDoanRaVien;
  String soTheBHYT;
  String hinhAnh;

  // Constructor
  BenhAnModel({
    required this.ten,
    required this.danToc,
    required this.ngaySinh,
    required this.gender,
    required this.ngayNhapVien,
    required this.ngayRaVien,
    required this.chanDoanVaoVien,
    required this.chanDoanRaVien,
    required this.soTheBHYT,
    required this.hinhAnh,
  });

  // Convert a Firestore document into a BenhAnModel object
  // factory BenhAnModel.fromMap(Map<String, dynamic> data, String docId) {
  //   return BenhAnModel(
  //     id: docId,
  //     patientName: data['patientName'] ?? '',
  //     age: data['age'] ?? 0,
  //     gender: data['gender'] ?? '',
  //     diagnosis: data['diagnosis'] ?? '',
  //     admissionDate: (data['admissionDate'] as Timestamp).toDate(),
  //     dischargeDate: data['dischargeDate'] != null
  //         ? (data['dischargeDate'] as Timestamp).toDate()
  //         : null,
  //     doctorName: data['doctorName'] ?? '',
  //     notes: data['notes'] ?? '',
  //   );
  // }

  // Convert a BenhAnModel object to a map for Firestore storage
  // Chuyển đối tượng thành Map để lưu trữ
  Map<String, dynamic> toMap() {
    return {
      'ten': ten,
      'danToc': danToc,
      'ngaySinh': ngaySinh,
      'gender': gender,
      'ngayNhapVien': ngayNhapVien,
      'ngayRaVien': ngayRaVien,
      'chanDoanVaoVien': chanDoanVaoVien,
      'chanDoanRaVien': chanDoanRaVien,
      'soTheBHYT': soTheBHYT,
      'hinhAnh': hinhAnh,
    };
  }
}

// extension BenhAnModelCopyWith on BenhAnModel {
//   BenhAnModel copyWith({
//     String? id,
//     String? patientName,
//     int? age,
//     String? gender,
//     String? diagnosis,
//     DateTime? admissionDate,
//     DateTime? dischargeDate,
//     String? doctorName,
//     String? notes,
//   }) {
//     return BenhAnModel(
//       id: id ?? this.id,
//       patientName: patientName ?? this.patientName,
//       age: age ?? this.age,
//       gender: gender ?? this.gender,
//       diagnosis: diagnosis ?? this.diagnosis,
//       admissionDate: admissionDate ?? this.admissionDate,
//       dischargeDate: dischargeDate ?? this.dischargeDate,
//       doctorName: doctorName ?? this.doctorName,
//       notes: notes ?? this.notes,
//     );
//   }
// }
