import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:rentcarapp/models/combobox/combocustomer_model.dart';
import 'package:rentcarapp/models/combobox/comboharga_model.dart';
import 'package:rentcarapp/models/combobox/combomasasewa_model.dart';
import 'package:rentcarapp/models/combobox/combomobil_model.dart';
import 'package:rentcarapp/models/combobox/combosupir_model.dart';
import 'package:rentcarapp/models/combobox/combowilayah_model.dart';
import 'package:rentcarapp/models/responseAPI/returndataapi_model.dart';
import 'package:rentcarapp/models/sewamobil/sewacrud_model.dart';
import 'package:rentcarapp/repositories/combobox/combomasasewa_repository.dart';
import 'package:rentcarapp/repositories/combobox/combowilayah_repository.dart';
import 'package:rentcarapp/repositories/sewamobil/sewacrud_repository.dart';

part 'sewacrud_event.dart';
part 'sewacrud_state.dart';

class SewaCrudBloc extends Bloc<SewaCrudEvents, SewaCrudState> {
  final SewaCrudRepository repository;
  SewaCrudBloc({required this.repository}) : super(const SewaCrudState()) {
    on<SewaCrudUbahEvent>(onUbahSewaCrud);
    on<SewaCrudTambahEvent>(onTambahSewaCrud);
    on<SewaCrudHapusEvent>(onHapusSewaCrud);
    on<SewaCrudLihatEvent>(onLihatSewaCrud);
    on<UpdateRecordEvent>(onUpdateRecord);
    on<InitRecordEvent>(onInitRecord);
    on<TglMulaiSewaChangedEvent>(onTglMulaiSewaChanged);
    on<QtySewaChangedEvent>(onQtySewaChanged);
    on<MasaSewaChangedEvent>(onMasaSewaChanged);
    on<JamMulaiChangedEvent>(onJamMulaiChanged);
    on<HargaSewaChangedEvent>(onHargaSewaChanged);
    on<CustomerChangedEvent>(onCustomerChanged);
    on<SupirKontrakChangedEvent>(onSupirKontrakChanged);
  }

  Future<void> onUpdateRecord(
      UpdateRecordEvent event, Emitter<SewaCrudState> emit) async {
    emit(state.copyWith(isLoading: true, isLoaded: false));
    emit(
        state.copyWith(record: event.record, isLoading: false, isLoaded: true));
  }

  Future<void> onInitRecord(
      InitRecordEvent event, Emitter<SewaCrudState> emit) async {
    debugPrint("onInitRecord #10");

    emit(state.copyWith(isLoading: true, isLoaded: false));

    debugPrint("onInitRecord #20");
    //set init value rec sewa

    var recSewa = SewaCrudModel(sewa1Id: "");
    DateTime mulaiTgl = DateTime.now().add(const Duration(days: 1));
    mulaiTgl = mulaiTgl.copyWith(hour: 8, minute: 0, second: 0);
    DateTime akhirTgl;
    recSewa.tglTrx = DateTime.now();
    recSewa.mulaiTgl = mulaiTgl;
    recSewa.mulaiJam = mulaiTgl;
    recSewa.qty = 1;
    akhirTgl = mulaiTgl.add(const Duration(hours: 12));
    recSewa.akhirTgl = akhirTgl;
    recSewa.akhirJam = akhirTgl;

    debugPrint("onInitRecord #30");

    //load init data combo masa sewa
    ComboMasasewaRepository repoMasa = ComboMasasewaRepository();
    ComboMasasewaModel comboMasaSewa =
        await repoMasa.getInitValueComboMasaSewa().then((value) {
      recSewa.mmasaId = value.mmasaId;
      return value;
    });
    recSewa.mmasaId = comboMasaSewa.mmasaId;
    recSewa.comboMasaSewa = comboMasaSewa;

    debugPrint("onInitRecord #40");

    //load ini data combo wilayah

    ComboWilayahRepository repoWilayah = ComboWilayahRepository();
    ComboWilayahModel? comboWilayah =
        await repoWilayah.getInitValueComboWilayah();
    recSewa.mwilayahId = comboWilayah.mwilayahId;
    recSewa.comboWilayah = comboWilayah;

    debugPrint("onInitRecord #50");

    emit(state.copyWith(
      record: recSewa,
      isLoading: false,
      isLoaded: true,
    ));
  }

  Future<void> onTambahSewaCrud(
      SewaCrudTambahEvent event, Emitter<SewaCrudState> emit) async {
    ReturnDataAPI returnData;
    bool hasFailure = true;
    emit(state.copyWith(isSaving: true, isSaved: false));
    SewaCrudModel recState = state.record!;
    SewaCrudModel recEvent = event.record;
    recEvent.mulaiTgl = recState.mulaiTgl;
    recEvent.mulaiJam = recState.mulaiJam;
    recEvent.akhirTgl = recState.akhirTgl;
    recEvent.akhirJam = recState.akhirJam;
    recEvent.mmasaId = recState.mmasaId;
    recEvent.harga = recState.harga;
    recEvent.mhargaId = recState.mhargaId;
    recEvent.qty = recState.qty;
    recEvent.biayaAntar = recState.biayaAntar ?? 0;
    recEvent.biayaJemput = recState.biayaJemput ?? 0;
    recEvent.biayaSewa = recState.biayaSewa;
    recEvent.biayaTotal = recState.biayaTotal;
    returnData = await repository.sewaCrudTambah(recEvent);
    hasFailure = !returnData.success;
    emit(
        state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
  }

  Future<void> onUbahSewaCrud(
      SewaCrudUbahEvent event, Emitter<SewaCrudState> emit) async {
    emit(state.copyWith(isSaving: true, isSaved: false));

    SewaCrudModel recState = state.record!;
    SewaCrudModel recEvent = event.record;
    recEvent.mulaiTgl = recState.mulaiTgl;
    recEvent.mulaiJam = recState.mulaiJam;
    recEvent.akhirTgl = recState.akhirTgl;
    recEvent.akhirJam = recState.akhirJam;
    recEvent.mmasaId = recState.mmasaId;
    recEvent.harga = recState.harga;
    recEvent.mhargaId = recState.mhargaId;
    recEvent.qty = recState.qty;
    recEvent.biayaAntar = recState.biayaAntar ?? 0;
    recEvent.biayaJemput = recState.biayaJemput ?? 0;
    recEvent.biayaSewa = recState.biayaSewa;
    recEvent.biayaTotal = recState.biayaTotal;

    debugPrint("onUbahSewaCrud -> recEvent.customerId ${recEvent.customerId}");

    bool hasFailure = !await repository.sewaCrudUbah(recEvent);
    emit(
        state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
  }

  Future<void> onHapusSewaCrud(
      SewaCrudHapusEvent event, Emitter<SewaCrudState> emit) async {
    emit(state.copyWith(isSaving: true, isSaved: false));
    bool hasFailure = !await repository.sewaCrudHapus(event.recordId);
    emit(
        state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
  }

  Future<void> onLihatSewaCrud(
      SewaCrudLihatEvent event, Emitter<SewaCrudState> emit) async {
    emit(state.copyWith(isLoading: true, isLoaded: false));

    debugPrint("onLihatSewaCrud #10");

    SewaCrudModel record = await repository.sewaCrudLihat(event.recordId);

    debugPrint("onLihatSewaCrud #20");

    emit(state.copyWith(
      isLoading: false,
      isLoaded: true,
      record: record,
    ));

    debugPrint("onLihatSewaCrud #30");

  }

  Future<void> onTglMulaiSewaChanged(
      TglMulaiSewaChangedEvent event, Emitter<SewaCrudState> emit) async {
    emit(state.copyWith(isLoading: true, isLoaded: false));

    SewaCrudModel rec = state.record!;

    DateTime tglMulaiSewa = event.tglMulaiSewa;
    String masaId = state.record!.mmasaId!;
    int qty = rec.qty!;
    DateTime jamMulaiSewa = rec.mulaiJam!;
    DateTime tglAkhirSewa;
    DateTime jamAkhirSewa;
    if (masaId == "240400001") {
      tglMulaiSewa = tglMulaiSewa.copyWith(
          hour: jamMulaiSewa.hour, minute: jamMulaiSewa.minute);
      if (qty > 1) {
        tglAkhirSewa = tglMulaiSewa.add(Duration(days: qty - 1, hours: 12));
      } else {
        tglAkhirSewa = tglMulaiSewa.add(const Duration(hours: 12));
      }
      jamAkhirSewa = tglAkhirSewa;
    } else if (masaId == "240400002") {
      tglAkhirSewa = tglMulaiSewa.add(Duration(days: qty));
      jamAkhirSewa = jamMulaiSewa;
    } else {
      tglAkhirSewa = DateTime.parse(
          Jiffy.parseFromDateTime(tglMulaiSewa).add(months: qty).format());
      jamAkhirSewa = jamMulaiSewa;
    }
    rec.mulaiTgl = tglMulaiSewa;
    rec.akhirJam = jamAkhirSewa;
    rec.akhirTgl = tglAkhirSewa;

    emit(state.copyWith(isLoading: false, isLoaded: true, record: rec));
  }

  Future<void> onQtySewaChanged(
      QtySewaChangedEvent event, Emitter<SewaCrudState> emit) async {
    emit(state.copyWith(isLoading: true, isLoaded: false));

    debugPrint("onQtySewaChanged value : ${event.qty}");

    int qty = event.qty;

    debugPrint("onQtySewaChanged #10");
    SewaCrudModel rec = state.record!;
    debugPrint("onQtySewaChanged #11");
    String masaId = state.record!.mmasaId!;
    debugPrint("onQtySewaChanged #12");
    DateTime tglMulaiSewa = rec.mulaiTgl!;
    debugPrint("onQtySewaChanged #13");
    DateTime jamMulaiSewa = rec.mulaiJam!;
    debugPrint("onQtySewaChanged #14");
    DateTime tglAkhirSewa;
    DateTime jamAkhirSewa;

    debugPrint("onQtySewaChanged #20");

    if (qty == 0) {
      tglAkhirSewa = tglMulaiSewa;
      jamAkhirSewa = jamMulaiSewa;
    } else {
      if (masaId == "240400001") {
        tglMulaiSewa = tglMulaiSewa.copyWith(
            hour: jamMulaiSewa.hour, minute: jamMulaiSewa.minute);

        if (qty > 1) {
          tglAkhirSewa = tglMulaiSewa.add(Duration(days: qty - 1, hours: 12));
        } else {
          tglAkhirSewa = tglMulaiSewa.add(const Duration(hours: 12));
        }
        jamAkhirSewa = tglAkhirSewa;
      } else if (masaId == "240400002") {
        tglAkhirSewa = tglMulaiSewa.add(Duration(days: qty));
        jamAkhirSewa = jamMulaiSewa;
      } else {
        tglAkhirSewa = DateTime.parse(
            Jiffy.parseFromDateTime(tglMulaiSewa).add(months: qty).format());
        jamAkhirSewa = jamMulaiSewa;
      }
    }

    debugPrint("onQtySewaChanged #30");
    rec.qty = qty;
    rec.akhirTgl = tglAkhirSewa;
    rec.akhirJam = jamAkhirSewa;

    debugPrint("onQtySewaChanged #32");

    double harga = rec.harga ?? 0;
    double biayaSewa = qty * harga;
    double biayaAntar = rec.biayaAntar ?? 0;
    double biayaJemput = rec.biayaJemput ?? 0;
    double biayaTotal = biayaSewa + biayaAntar + biayaJemput;

    debugPrint("onQtySewaChanged #33");

    rec.biayaSewa = biayaSewa;
    rec.biayaTotal = biayaTotal;

    debugPrint("onQtySewaChanged #40");
    emit(state.copyWith(isLoading: false, isLoaded: true, record: rec));
  }

  Future<void> onMasaSewaChanged(
      MasaSewaChangedEvent event, Emitter<SewaCrudState> emit) async {
    emit(state.copyWith(isLoading: true, isLoaded: false));

    debugPrint("onMasaSewaChanged #10");
    SewaCrudModel rec = state.record!;
    String masaId = event.masasewaRec.mmasaId;
    int qty = rec.qty ?? 0;
    DateTime tglMulaiSewa = rec.mulaiTgl!;
    DateTime jamMulaiSewa = rec.mulaiJam!;
    DateTime tglAkhirSewa;
    DateTime jamAkhirSewa;
    debugPrint("masaId #10 : $masaId");
    if (masaId == "240400001") {
      debugPrint("tglMulaiSewa #10 : ${tglMulaiSewa.toIso8601String()}");
      tglMulaiSewa = tglMulaiSewa.copyWith(
          hour: jamMulaiSewa.hour, minute: jamMulaiSewa.minute);
      debugPrint("tglMulaiSewa #20 : ${tglMulaiSewa.toIso8601String()}");
      if (qty > 1) {
        tglAkhirSewa = tglMulaiSewa.add(Duration(days: qty - 1, hours: 12));
      } else {
        tglAkhirSewa = tglMulaiSewa.add(const Duration(hours: 12));
      }
      jamAkhirSewa = tglAkhirSewa;
    } else if (masaId == "240400002") {
      tglAkhirSewa = tglMulaiSewa.add(Duration(days: qty));
      jamAkhirSewa = jamMulaiSewa;
    } else {
      tglAkhirSewa = DateTime.parse(
          Jiffy.parseFromDateTime(tglMulaiSewa).add(months: qty).format());
      jamAkhirSewa = jamMulaiSewa;
    }

    debugPrint("onMasaSewaChanged #30");

    rec.akhirTgl = tglAkhirSewa;
    rec.akhirJam = jamAkhirSewa;

    emit(state.copyWith(isLoading: false, isLoaded: true, record: rec));
  }

  Future<void> onJamMulaiChanged(
      JamMulaiChangedEvent event, Emitter<SewaCrudState> emit) async {
    emit(state.copyWith(isLoading: true, isLoaded: false));

    SewaCrudModel rec = state.record!;
    String masaId = state.record!.mmasaId!;
    int qty = rec.qty ?? 0;
    DateTime mulaiJam = event.mulaiJam;
    DateTime akhirTgl;
    DateTime mulaiTgl = rec.mulaiTgl!;
    DateTime akhirJam;
    if (masaId == "240400001") {
      mulaiTgl =
          mulaiTgl.copyWith(hour: mulaiJam.hour, minute: mulaiJam.minute);
      if (qty > 1) {
        akhirTgl = mulaiTgl.add(Duration(days: qty - 1, hours: 12));
      } else {
        akhirTgl = mulaiTgl.add(const Duration(hours: 12));
      }
      akhirJam = akhirTgl;
    } else if (masaId == "240400002") {
      akhirTgl = mulaiTgl.add(Duration(days: qty));
      akhirJam = mulaiJam;
    } else {
      akhirTgl = DateTime.parse(
          Jiffy.parseFromDateTime(mulaiTgl).add(months: qty).format());
      akhirJam = mulaiJam;
    }

    rec.mulaiJam = mulaiJam;
    rec.akhirTgl = akhirTgl;
    rec.akhirJam = akhirJam;

    emit(state.copyWith(isLoading: false, isLoaded: true, record: rec));
  }

  Future<void> onHargaSewaChanged(
      HargaSewaChangedEvent event, Emitter<SewaCrudState> emit) async {
    emit(state.copyWith(isLoading: true, isLoaded: false));

    ComboHargaModel comboHarga = event.comboHarga;
    double harga = comboHarga.harga;
    SewaCrudModel rec = state.record!;
    int qty = rec.qty ?? 0;
    double biayaSewa = qty * harga;
    double biayaAntar = rec.biayaAntar ?? 0;
    double biayaJemput = rec.biayaJemput ?? 0;
    double biayaTotal = biayaSewa + biayaAntar + biayaJemput;
    rec.mhargaId = comboHarga.mhargaId;
    rec.comboHarga = comboHarga;
    rec.harga = harga;
    rec.biayaSewa = biayaSewa;
    rec.biayaTotal = biayaTotal;

    emit(state.copyWith(isLoading: false, isLoaded: true, record: rec));
  }

  Future<void> onCustomerChanged(
      CustomerChangedEvent event, Emitter<SewaCrudState> emit) async {
    emit(state.copyWith(isLoading: true, isLoaded: false));

    ComboCustomerModel comboCustomer = event.comboCustomer;
    SewaCrudModel rec = state.record!;
    rec.customerId = comboCustomer.mrekanId;
    rec.comboCustomer = comboCustomer;

    emit(state.copyWith(isLoading: false, isLoaded: true, record: rec));
  }

  Future<void> onSupirKontrakChanged(
      SupirKontrakChangedEvent event, Emitter<SewaCrudState> emit) async {
    emit(state.copyWith(isLoading: true, isLoaded: false));

    ComboSupirModel comboSupir = event.comboSupirKontrak;
    SewaCrudModel rec = state.record!;
    rec.supirId = comboSupir.mstaffId;
    rec.comboSupirKontrak = comboSupir;

    emit(state.copyWith(isLoading: false, isLoaded: true, record: rec));
  }

  Future<void> onMobilChanged(
      MobilChangedEvent event, Emitter<SewaCrudState> emit) async {
    emit(state.copyWith(isLoading: true, isLoaded: false));

    ComboMobilModel comboMobil = event.comboMobil;
    SewaCrudModel rec = state.record!;
    rec.mmobilId = comboMobil.mmobilId;
    rec.comboMobil = comboMobil;

    emit(state.copyWith(isLoading: false, isLoaded: true, record: rec));
  }
}
