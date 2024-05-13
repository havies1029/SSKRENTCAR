part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomePageActiveEvent extends HomeEvent {}

class ProfilePageActiveEvent extends HomeEvent {}

class RoomCariPageActiveEvent extends HomeEvent {}

class ChatSupportPageActiveEvent extends HomeEvent {}

class MerkCariPageActiveEvent extends HomeEvent {}

class MasaSewaCariPageActiveEvent extends HomeEvent {}

class TitleCariPageActiveEvent extends HomeEvent {}

class CustomerCariPageActiveEvent extends HomeEvent {}

class BengkelCariPageActiveEvent extends HomeEvent {}

class AsuransiCariPageActiveEvent extends HomeEvent {}

class TipeCariPageActiveEvent extends HomeEvent {}

class WilayahCariPageActiveEvent extends HomeEvent {}

class JabatanCariPageActiveEvent extends HomeEvent {}

class HargaCariPageActiveEvent extends HomeEvent {}

class StaffCariPageActiveEvent extends HomeEvent {}

class WarnaCariPageActiveEvent extends HomeEvent {}

class MobilCariPageActiveEvent extends HomeEvent {}

class SewaCariPageActiveEvent extends HomeEvent {}


