import 'package:rentcarapp/blocs/mstharga/hargacari_bloc.dart';
import 'package:rentcarapp/blocs/mstharga/hargacrud_bloc.dart';
import 'package:rentcarapp/blocs/mstjabatan/jabatancari_bloc.dart';
import 'package:rentcarapp/blocs/mstjabatan/jabatancrud_bloc.dart';
import 'package:rentcarapp/blocs/mstmasa/masacari_bloc.dart';
import 'package:rentcarapp/blocs/mstmasa/masacrud_bloc.dart';
import 'package:rentcarapp/blocs/mstmerk/merkcari_bloc.dart';
import 'package:rentcarapp/blocs/mstmerk/merkcrud_bloc.dart';
import 'package:rentcarapp/blocs/mstmobil/mobilcari_bloc.dart';
import 'package:rentcarapp/blocs/mstmobil/mobilcrud_bloc.dart';
import 'package:rentcarapp/blocs/mstrekan/rekancari_bloc.dart';
import 'package:rentcarapp/blocs/mstrekan/rekancrud_bloc.dart';
import 'package:rentcarapp/blocs/mststaff/staffcari_bloc.dart';
import 'package:rentcarapp/blocs/mststaff/staffcrud_bloc.dart';
import 'package:rentcarapp/blocs/msttipe/tipecari_bloc.dart';
import 'package:rentcarapp/blocs/msttipe/tipecrud_bloc.dart';
import 'package:rentcarapp/blocs/msttitle/titlecari_bloc.dart';
import 'package:rentcarapp/blocs/msttitle/titlecrud_bloc.dart';
import 'package:rentcarapp/blocs/mstwarna/warnacari_bloc.dart';
import 'package:rentcarapp/blocs/mstwarna/warnacrud_bloc.dart';
import 'package:rentcarapp/blocs/mstwilayah/wilayahcari_bloc.dart';
import 'package:rentcarapp/blocs/mstwilayah/wilayahcrud_bloc.dart';
import 'package:rentcarapp/blocs/sewamobil/sewacari_bloc.dart';
import 'package:rentcarapp/blocs/sewamobil/sewacrud_bloc.dart';
import 'package:rentcarapp/common/app_data.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:rentcarapp/blocs/chatting/chatgroupcari_bloc.dart';
import 'package:rentcarapp/blocs/chatting/chatgroupcrud_bloc.dart';
import 'package:rentcarapp/blocs/chatting/roomcari_bloc.dart';
import 'package:rentcarapp/blocs/networkconnection/network_bloc.dart';
import 'package:rentcarapp/blocs/progressindicator/progressindicator_bloc.dart';
import 'package:rentcarapp/repositories/chatting/chatgroupcrud_repository.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentcarapp/pages/home/home_page.dart';
import 'package:rentcarapp/pages/login/login_page.dart';
import 'package:rentcarapp/repositories/mstharga/hargacrud_repository.dart';
import 'package:rentcarapp/repositories/mstjabatan/jabatancrud_repository.dart';
import 'package:rentcarapp/repositories/mstmasa/masacrud_repository.dart';
import 'package:rentcarapp/repositories/mstmerk/merkcrud_repository.dart';
import 'package:rentcarapp/repositories/mstmobil/mobilcrud_repository.dart';
import 'package:rentcarapp/repositories/mstrekan/rekancrud_repository.dart';
import 'package:rentcarapp/repositories/mststaff/staffcrud_repository.dart';
import 'package:rentcarapp/repositories/msttipe/tipecrud_repository.dart';
import 'package:rentcarapp/repositories/msttitle/titlecrud_repository.dart';
import 'package:rentcarapp/repositories/mstwarna/warnacrud_repository.dart';
import 'package:rentcarapp/repositories/mstwilayah/wilayahcrud_repository.dart';
import 'package:rentcarapp/repositories/sewamobil/sewacrud_repository.dart';
import 'package:rentcarapp/repositories/user/user_repository.dart';
import 'package:rentcarapp/blocs/authentication/authentication_bloc.dart';
import 'package:rentcarapp/pages/splash/splash_page.dart';
import 'package:rentcarapp/common/loading_indicator.dart';

import 'blocs/takeimage/takeimage_cubit.dart';

void main() {
  final userRepository = UserRepository();
  AppData.kIsWeb = kIsWeb;
  runApp(BlocProvider<AuthenticationBloc>(
    create: (context) {
      return AuthenticationBloc(userRepository: userRepository)
        ..add(AppStarted());
    },
    child: App(
      userRepository: userRepository,
      key: null,
    ),
  ));
}

class App extends StatelessWidget {
  final UserRepository userRepository;

  const App({required super.key, required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TakeImageCubit>(
          create: (context) => TakeImageCubit(),
        ),
        BlocProvider<RoomCariBloc>(create: (context) => RoomCariBloc()),
        BlocProvider<ChatGroupCariBloc>(
            create: (context) => ChatGroupCariBloc()),
        BlocProvider<ChatGroupCrudBloc>(
            create: (context) => ChatGroupCrudBloc(
                chatGroupRepository: ChatGroupCrudRepository())),
        BlocProvider<ProgressIndicatorBloc>(
            create: (context) => ProgressIndicatorBloc()),
        BlocProvider<NetworkBloc>(
            create: (context) => NetworkBloc()..add(NetworkObserve())),
        BlocProvider<MerkCariBloc>(
            create: (context) => MerkCariBloc()),
        BlocProvider<MerkCrudBloc>(
            create: (context) => MerkCrudBloc(repository: MerkCrudRepository())),
        BlocProvider<MasaCariBloc>(
            create: (context) => MasaCariBloc()),
        BlocProvider<MasaCrudBloc>(
            create: (context) => MasaCrudBloc(repository: MasaCrudRepository())),
        BlocProvider<TitleCariBloc>(
            create: (context) => TitleCariBloc()),
        BlocProvider<TitleCrudBloc>(
            create: (context) => TitleCrudBloc(repository: TitleCrudRepository())),
        BlocProvider<RekanCariBloc>(
            create: (context) => RekanCariBloc()),
        BlocProvider<RekanCrudBloc>(
            create: (context) => RekanCrudBloc(repository: RekanCrudRepository())),
        BlocProvider<TipeCariBloc>(
            create: (context) => TipeCariBloc()),
        BlocProvider<TipeCrudBloc>(
            create: (context) => TipeCrudBloc(repository: TipeCrudRepository())),
        BlocProvider<WilayahCariBloc>(
            create: (context) => WilayahCariBloc()),
        BlocProvider<WilayahCrudBloc>(
            create: (context) => WilayahCrudBloc(repository: WilayahCrudRepository())),
        BlocProvider<JabatanCariBloc>(
            create: (context) => JabatanCariBloc()),
        BlocProvider<JabatanCrudBloc>(
            create: (context) => JabatanCrudBloc(repository: JabatanCrudRepository())),
        BlocProvider<HargaCariBloc>(
            create: (context) => HargaCariBloc()),
        BlocProvider<HargaCrudBloc>(
            create: (context) => HargaCrudBloc(repository: HargaCrudRepository())),
        BlocProvider<StaffCariBloc>(
            create: (context) => StaffCariBloc()),
        BlocProvider<StaffCrudBloc>(
            create: (context) => StaffCrudBloc(repository: StaffCrudRepository())),
        BlocProvider<WarnaCariBloc>(
            create: (context) => WarnaCariBloc()),
        BlocProvider<WarnaCrudBloc>(
            create: (context) => WarnaCrudBloc(repository: WarnaCrudRepository())),
        BlocProvider<MobilCariBloc>(
            create: (context) => MobilCariBloc()),
        BlocProvider<MobilCrudBloc>(
            create: (context) => MobilCrudBloc(repository: MobilCrudRepository())),
        BlocProvider<SewaCariBloc>(
            create: (context) => SewaCariBloc()),
        BlocProvider<SewaCrudBloc>(
            create: (context) => SewaCrudBloc(repository: SewaCrudRepository())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Rentcar App',
        theme: FlexThemeData.light(scheme: FlexScheme.mandyRed),
        // The Mandy red, dark theme.
        darkTheme: FlexThemeData.dark(scheme: FlexScheme.mandyRed),
        // Use dark or light theme based on system setting.
        themeMode: ThemeMode.system,

        routes: const {},

        //home: const MyHomePage(title: "Testing in Web",),

/*
        home: LoginPage(
                userRepository: userRepository,
              ),
*/

        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationUninitialized) {
              debugPrint("AuthenticationUninitialized #10");

              return const SplashPage();
            }

            if (state is AuthenticationAuthenticated) {
              debugPrint("AuthenticationAuthenticated #20");

              return HomePage(
                userRepository: userRepository,
                userid: 0,
                key: null,
              );
            }

            if (state is AuthenticationUnauthenticated) {
              debugPrint("AuthenticationUnauthenticated #30");
              return LoginPage(
                userRepository: userRepository,
              );
            }

            if (AppData.kIsWeb) {
              return LoginPage(
                userRepository: userRepository,
              );
            } else {
              return const LoadingIndicator();
            }
          },
        ),
      ),
    );
  }
}
