import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';
part 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomePageActive()) {
    on<HomePageActiveEvent>((event, emit) => emit(HomePageActive()));
    on<ProfilePageActiveEvent>((event, emit) => emit(ProfilePageActive()));    
    on<RoomCariPageActiveEvent>(
      (event, emit) => emit(RoomCariPageActive())
    ); 
    on<ChatSupportPageActiveEvent>(
      (event, emit) => emit(ChatSupportPageActive())
    );        
    on<MerkCariPageActiveEvent>((event, emit) => emit(MerkCariPageActive())); 
    on<MasaSewaCariPageActiveEvent>((event, emit) => emit(MasaSewaCariPageActive())); 
    on<TitleCariPageActiveEvent>((event, emit) => emit(TitleCariPageActive())); 
    on<CustomerCariPageActiveEvent>((event, emit) => emit(CustomerCariPageActive())); 
    on<BengkelCariPageActiveEvent>((event, emit) => emit(BengkelCariPageActive())); 
    on<AsuransiCariPageActiveEvent>((event, emit) => emit(AsuransiCariPageActive())); 
    on<TipeCariPageActiveEvent>((event, emit) => emit(TipeCariPageActive()));     
    on<WilayahCariPageActiveEvent>((event, emit) => emit(WilayahCariPageActive())); 
    on<JabatanCariPageActiveEvent>((event, emit) => emit(JabatanCariPageActive())); 
    on<HargaCariPageActiveEvent>((event, emit) => emit(HargaCariPageActive())); 
    on<StaffCariPageActiveEvent>((event, emit) => emit(StaffCariPageActive())); 
    on<WarnaCariPageActiveEvent>((event, emit) => emit(WarnaCariPageActive())); 
    on<MobilCariPageActiveEvent>((event, emit) => emit(MobilCariPageActive())); 
    on<SewaCariPageActiveEvent>((event, emit) => emit(SewaCariPageActive())); 
  }
}
