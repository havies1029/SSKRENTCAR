part of 'sewacrud_bloc.dart';

class SewaCrudState extends Equatable {
  final SewaCrudModel? record;
  final bool isLoading;
  final bool isLoaded;
  final bool isSaving;
  final bool isSaved;
  final bool hasFailure;
  //final ComboMasasewaModel? comboMasaInitValue;
  //final ComboWilayahModel? comboWilayahInitValue;
  //final ComboHargaModel? comboHargaInitValue;
  //final ComboCustomerModel? comboCustomer;
  //final ComboSupirModel? comboSupirKontrak;
  //final ComboSupirModel? comboSupirAntar;
  //final ComboSupirModel? comboSupirJemput;
  //final ComboMobilModel? comboMobil;
  const SewaCrudState(
      {this.record,
      this.isLoading = false,
      this.isLoaded = false,
      this.isSaving = false,
      this.isSaved = false,
      this.hasFailure = false,
      //this.comboMasaInitValue,
      //this.comboWilayahInitValue,
      //this.comboHargaInitValue,
      //this.comboCustomer,
      //this.comboSupirKontrak,
      //this.comboSupirAntar,
      //this.comboSupirJemput,
      //this.comboMobil
    });

  SewaCrudState copyWith(
      {SewaCrudModel? record,
      bool? isLoading,
      bool? isLoaded,
      bool? isSaving,
      bool? isSaved,
      bool? hasFailure,
      //ComboMasasewaModel? comboMasaInitValue,
      //ComboWilayahModel? comboWilayahInitValue,
      //ComboHargaModel? comboHargaInitValue,
      //ComboCustomerModel? comboCustomer,
      //ComboSupirModel? comboSupirKontrak,
      //ComboSupirModel? comboSupirAntar,
      //ComboSupirModel? comboSupirJemput,
      //ComboMobilModel? comboMobil
    }) {
    return SewaCrudState(
        record: record ?? this.record,
        isLoading: isLoading ?? this.isLoading,
        isLoaded: isLoaded ?? this.isLoaded,
        isSaving: isSaving ?? this.isSaving,
        isSaved: isSaved ?? this.isSaved,
        hasFailure: hasFailure ?? this.hasFailure,
        //comboMasaInitValue: comboMasaInitValue ?? this.comboMasaInitValue,
        //comboWilayahInitValue: comboWilayahInitValue ?? this.comboWilayahInitValue,
        //comboHargaInitValue: comboHargaInitValue ?? this.comboHargaInitValue,
        //comboCustomer: comboCustomer ?? this.comboCustomer,
        //comboSupirKontrak: comboSupirKontrak ?? this.comboSupirKontrak,
        //comboSupirAntar: comboSupirAntar ?? this.comboSupirAntar,
        //comboSupirJemput: comboSupirJemput ?? this.comboSupirJemput,
        //comboMobil: comboMobil ?? this.comboMobil
    );
  }

  @override
  List<Object> get props =>
      [isLoading, isLoaded, isSaving, isSaved, hasFailure];
}
