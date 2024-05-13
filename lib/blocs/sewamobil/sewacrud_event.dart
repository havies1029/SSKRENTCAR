part of 'sewacrud_bloc.dart';

abstract class SewaCrudEvents extends Equatable {
  const SewaCrudEvents();

  @override
  List<Object> get props => [];
}

class SewaCrudTambahEvent extends SewaCrudEvents {
  final SewaCrudModel record;
  const SewaCrudTambahEvent({required this.record});

  @override
  List<Object> get props => [record];
}

class SewaCrudUbahEvent extends SewaCrudEvents {
  final SewaCrudModel record;
  const SewaCrudUbahEvent({required this.record});

  @override
  List<Object> get props => [record];
}

class SewaCrudHapusEvent extends SewaCrudEvents {
  final String recordId;
  const SewaCrudHapusEvent({required this.recordId});

  @override
  List<Object> get props => [recordId];
}

class SewaCrudLihatEvent extends SewaCrudEvents {
  final String recordId;
  const SewaCrudLihatEvent({required this.recordId});

  @override
  List<Object> get props => [recordId];
}

class UpdateRecordEvent extends SewaCrudEvents {
  final SewaCrudModel record;
  const UpdateRecordEvent({required this.record});

  @override
  List<Object> get props => [record];
}

class InitRecordEvent extends SewaCrudEvents {}

class TglMulaiSewaChangedEvent extends SewaCrudEvents {
  final DateTime tglMulaiSewa;
  const TglMulaiSewaChangedEvent({required this.tglMulaiSewa});

  @override
  List<Object> get props => [tglMulaiSewa];
}

class QtySewaChangedEvent extends SewaCrudEvents {
  final int qty;
  const QtySewaChangedEvent({required this.qty});

  @override
  List<Object> get props => [qty];
}

class MasaSewaChangedEvent extends SewaCrudEvents {
  final ComboMasasewaModel masasewaRec;
  const MasaSewaChangedEvent({required this.masasewaRec});

  @override
  List<Object> get props => [masasewaRec];
}

class JamMulaiChangedEvent extends SewaCrudEvents {
  final DateTime mulaiJam;
  const JamMulaiChangedEvent({required this.mulaiJam});

  @override
  List<Object> get props => [mulaiJam];
}

class HargaSewaChangedEvent extends SewaCrudEvents {
  final ComboHargaModel comboHarga;
  const HargaSewaChangedEvent({required this.comboHarga});

  @override
  List<Object> get props => [comboHarga];
}

class CustomerChangedEvent extends SewaCrudEvents {
  final ComboCustomerModel comboCustomer;
  const CustomerChangedEvent({required this.comboCustomer});

  @override
  List<Object> get props => [comboCustomer];
}

class SupirKontrakChangedEvent extends SewaCrudEvents {
  final ComboSupirModel comboSupirKontrak;
  const SupirKontrakChangedEvent({required this.comboSupirKontrak});

  @override
  List<Object> get props => [comboSupirKontrak];
}

class SupirAntarChangedEvent extends SewaCrudEvents {
  final ComboSupirModel comboSupirAntar;
  const SupirAntarChangedEvent({required this.comboSupirAntar});

  @override
  List<Object> get props => [comboSupirAntar];
}

class SupirJemputChangedEvent extends SewaCrudEvents {
  final ComboSupirModel comboSupirJemput;
  const SupirJemputChangedEvent({required this.comboSupirJemput});

  @override
  List<Object> get props => [comboSupirJemput];
}

class MobilChangedEvent extends SewaCrudEvents {
  final ComboMobilModel comboMobil;
  const MobilChangedEvent({required this.comboMobil});

  @override
  List<Object> get props => [comboMobil];
}
