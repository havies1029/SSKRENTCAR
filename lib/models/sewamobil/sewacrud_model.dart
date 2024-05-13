import 'package:flutter/cupertino.dart';
import 'package:rentcarapp/models/combobox/combocustomer_model.dart';
import 'package:rentcarapp/models/combobox/comboharga_model.dart';
import 'package:rentcarapp/models/combobox/combomasasewa_model.dart';
import 'package:rentcarapp/models/combobox/combomobil_model.dart';
import 'package:rentcarapp/models/combobox/combosupir_model.dart';
import 'package:rentcarapp/models/combobox/combowilayah_model.dart';
import 'package:string_validator/string_validator.dart';

class SewaCrudModel {
  double? biayaAntar;
  double? biayaJemput;
  double? biayaSewa;
  double? biayaTotal;
  String? customerId;
  double? harga;
  bool? isLepaskunci;
  String? keterangan;
  String? mhargaId;
  String? hargaDesc;
  //String? currId;
  String? mmasaId;
  String? mmobilId;
  String? platNo;
  String? mwilayahId;
  int? qty;
  DateTime? akhirTgl;
  DateTime? akhirJam;
  DateTime? mulaiTgl;
  DateTime? mulaiJam;
  String? sewa1Id;
  String? supirId;
  DateTime? tglTrx;
  String? statusSewa;
  bool? isAntarMobil;
  ComboWilayahModel? comboWilayah;
  ComboMasasewaModel? comboMasaSewa;
  ComboHargaModel? comboHarga;
  ComboCustomerModel? comboCustomer;
  ComboSupirModel? comboSupirKontrak;
  ComboMobilModel? comboMobil;

  SewaCrudModel(
      {this.biayaAntar,
      this.biayaJemput,
      this.biayaSewa,
      this.biayaTotal,
      this.customerId,
      this.harga,
      this.isLepaskunci,
      this.keterangan,
      this.mhargaId,
      //this.currId,
      this.mmasaId,
      this.mmobilId,
      this.mwilayahId,
      this.qty,
      this.akhirTgl,
      this.akhirJam,
      this.mulaiTgl,
      this.mulaiJam,
      this.sewa1Id,
      this.supirId,
      this.tglTrx,
      this.statusSewa,
      this.isAntarMobil,
      this.comboWilayah,
      this.comboCustomer,
      this.comboHarga,
      this.comboMasaSewa,
      this.comboMobil,
      this.comboSupirKontrak});

  factory SewaCrudModel.fromJson(Map<String, dynamic> data) {

    ComboWilayahModel? comboWilayah;
    if (data['comboWilayah'] != null) {
      comboWilayah = ComboWilayahModel.fromJson(data['comboWilayah']);
    }

    ComboMasasewaModel? comboMasaSewa;
    if (data['comboMasaSewa'] != null) {
      comboMasaSewa = ComboMasasewaModel.fromJson(data['comboMasaSewa']);
    }
    ComboCustomerModel? comboCustomer;
    if (data['comboCustomer'] != null) {
      comboCustomer = ComboCustomerModel.fromJson(data['comboCustomer']);
    }
    ComboSupirModel? comboSupirKontrak;
    if (data['comboSupirKontrak'] != null) {
      comboSupirKontrak = ComboSupirModel.fromJson(data['comboSupirKontrak']);
    }
    ComboMobilModel? comboMobil;
    if (data['comboMobil'] != null) {
      comboMobil = ComboMobilModel.fromJson(data['comboMobil']);
    }
    ComboHargaModel? comboHarga;
    if (data['comboHarga'] != null) {
      comboHarga = ComboHargaModel.fromJson(data['comboHarga']);
    }
    
    return SewaCrudModel(
      biayaAntar: double.tryParse(data['biayaAntar'].toString()) ?? 0,
      biayaJemput: double.tryParse(data['biayaJemput'].toString()) ?? 0,
      biayaSewa: double.tryParse(data['biayaSewa'].toString()) ?? 0,
      biayaTotal: double.tryParse(data['biayaTotal'].toString()) ?? 0,
      customerId: data['customerId'] ?? "",
      harga: double.tryParse(data['harga'].toString()) ?? 0,
      isLepaskunci: toBoolean(data['isLepaskunci'].toString()),
      keterangan: data['keterangan'] ?? "",
      mhargaId: data['mhargaId'] ?? "",
      mmasaId: data['mmasaId'] ?? "",
      mmobilId: data['mmobilId'] ?? "",
      mwilayahId: data['mwilayahId'] ?? "",
      qty: int.tryParse((data['qty']??0).toString()),
      akhirTgl: DateTime.tryParse(data['akhirTgl'].toString()) ?? DateTime.now(),
      akhirJam: DateTime.tryParse(data['akhirJam'].toString()) ?? DateTime.now(),
      mulaiTgl: DateTime.tryParse(data['mulaiTgl'].toString()) ?? DateTime.now(),
      mulaiJam: DateTime.tryParse(data['mulaiJam'].toString()) ?? DateTime.now(),
      sewa1Id: data['sewa1Id'] ?? "",
      supirId: data['supirId'] ?? "",
      tglTrx: DateTime.tryParse(data['tglTrx'].toString()) ?? DateTime.now(),
      statusSewa: data['statusSewa'] ?? "",
      isAntarMobil: toBoolean(data['isAntarMobil'].toString()),
      comboWilayah: comboWilayah,
      comboMasaSewa: comboMasaSewa,
      comboCustomer: comboCustomer,
      comboMobil: comboMobil,
      comboSupirKontrak: comboSupirKontrak,
      comboHarga: comboHarga,
    );
  }

  Map<String, dynamic> toJson() => {
        'biayaAntar': biayaAntar.toString(),
        'biayaJemput': biayaJemput.toString(),
        'biayaSewa': biayaSewa.toString(),
        'biayaTotal': biayaTotal.toString(),
        'customerId': customerId,
        'harga': harga.toString(),
        'isLepaskunci': isLepaskunci.toString(),
        'keterangan': keterangan,
        'mhargaId': mhargaId,
        'hargaDesc': hargaDesc,
        //'currId': currId,
        'mmasaId': mmasaId,
        'mmobilId': mmobilId,
        'mwilayahId': mwilayahId,
        'qty': qty.toString(),
        'akhirTgl': akhirTgl?.toIso8601String(),
        'akhirJam': akhirJam?.toIso8601String(),
        'mulaiTgl': mulaiTgl?.toIso8601String(),
        'mulaiJam': mulaiJam?.toIso8601String(),
        'sewa1Id': sewa1Id,
        'supirId': supirId,
        'tglTrx': tglTrx?.toIso8601String(),
        'statusSewa': statusSewa,
        'isAntarMobil': isAntarMobil.toString(),
        'comboWilayah': comboWilayah?.toJson(),
        'comboSupirKontrak': comboSupirKontrak?.toJson(),
        'comboMasaSewa': comboMasaSewa?.toJson(),
        'comboCustomer': comboCustomer?.toJson(),
        'comboMobil': comboMobil?.toJson(),
        'comboHarga': comboHarga?.toJson(),
      };
}
