part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object> get props => [];
}

class HomePageActive extends HomeState {}

class ProfilePageActive extends HomeState {}

class RoomCariPageActive extends HomeState {}

class ChatSupportPageActive extends HomeState {}

class MerkCariPageActive extends HomeState {}

class MasaSewaCariPageActive extends HomeState {}

class TitleCariPageActive extends HomeState {}

class CustomerCariPageActive extends HomeState {}

class BengkelCariPageActive extends HomeState {}

class AsuransiCariPageActive extends HomeState {}

class TipeCariPageActive extends HomeState {}

class WilayahCariPageActive extends HomeState {}

class JabatanCariPageActive extends HomeState {}

class HargaCariPageActive extends HomeState {}

class StaffCariPageActive extends HomeState {}

class WarnaCariPageActive extends HomeState {}

class MobilCariPageActive extends HomeState {}

class SewaCariPageActive extends HomeState {}

