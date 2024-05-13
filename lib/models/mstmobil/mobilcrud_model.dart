import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

class MobilCrudModel {
  String? insurerId;
  String? insurerNama;
  String mmobilId;
  String? mstsmobilId;
  String? statusNama;
  String? mtipeId;
  String? tipeNama;
  String? mwarnaId;
  String? warnaNama;
  String platNo;
  DateTime? polisAkhir;
  DateTime? polisMulai;
  String polisNo;
  String stnkNo;
  DateTime stnkTempo;
  int thnBuat;
  bool isAsuransi;

  MobilCrudModel(
      {this.insurerId,
      this.insurerNama,
      required this.mmobilId,
      this.mstsmobilId,
      this.statusNama,
      this.mtipeId,
      this.tipeNama,
      this.mwarnaId,
      this.warnaNama,
      required this.platNo,
      this.polisAkhir,
      this.polisMulai,
      required this.polisNo,
      required this.stnkNo,
      required this.stnkTempo,
      required this.thnBuat,
      required this.isAsuransi});

  factory MobilCrudModel.fromJson(Map<String, dynamic> data) {
    debugPrint("data['isAsuransi'] ${data['isAsuransi']}");
    try {
      toBoolean(data['isAsuransi'].toString());
    } catch (e) {
      debugPrint("Error : ${e.toString()}");
    }

    return MobilCrudModel(
        insurerId: data['insurerId'],
        insurerNama: data['insurerNama'],
        mmobilId: data['mmobilId'],
        mstsmobilId: data['mstsmobilId'],
        statusNama: data['statusNama'],
        mtipeId: data['mtipeId'],
        tipeNama: data['tipeNama'],
        mwarnaId: data['mwarnaId'],
        warnaNama: data['warnaNama'],
        platNo: data['platNo'],
        polisAkhir: data['polisAkhir'] == null
            ? null
            : DateTime.tryParse(data['polisAkhir']),
        polisMulai: data['polisMulai'] == null
            ? null
            : DateTime.tryParse(data['polisMulai']),
        polisNo: data['polisNo'],
        stnkNo: data['stnkNo'],
        stnkTempo: DateTime.tryParse(data['stnkTempo']) ?? DateTime.now(),
        thnBuat: int.tryParse(data['thnBuat'].toString()) ?? 0,
        isAsuransi: toBoolean(data['isAsuransi'].toString()));
  }

  Map<String, dynamic> toJson() => {
        'insurerId': insurerId,
        'insurerNama': insurerNama,
        'mmobilId': mmobilId,
        'mstsmobilId': mstsmobilId,
        'statusNama': statusNama,
        'mtipeId': mtipeId,
        'tipeNama': tipeNama,
        'mwarnaId': mwarnaId,
        'warnaNama': warnaNama,
        'platNo': platNo,
        'polisAkhir': polisAkhir?.toIso8601String(),
        'polisMulai': polisMulai?.toIso8601String(),
        'polisNo': polisNo,
        'stnkNo': stnkNo,
        'stnkTempo': stnkTempo.toIso8601String(),
        'thnBuat': thnBuat.toString(),
        'isAsuransi': isAsuransi.toString()
      };
}
