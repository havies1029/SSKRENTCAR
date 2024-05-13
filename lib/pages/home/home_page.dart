import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentcarapp/blocs/home/home_bloc.dart';
import 'package:rentcarapp/blocs/profile/profile_bloc.dart';
import 'package:rentcarapp/common/size_config.dart';
import 'package:rentcarapp/pages/base/base_container.dart';
import 'package:rentcarapp/pages/base/base_page.dart';
import 'package:rentcarapp/repositories/user/user_repository.dart';

class HomePage extends StatefulWidget {
  final int userid;
  final UserRepository userRepository;

  const HomePage(
      {required super.key, required this.userid, required this.userRepository});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(create: (context) => HomeBloc()),
        BlocProvider<ProfileBloc>(
          create: (content) => ProfileBloc(
              userRepository: widget.userRepository, id: widget.userid),
        ),
      ],
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          SizeConfig().init(context);
          if (state is HomePageActive) {
            debugPrint("HomePageActive");
            return const PageContainer(pageType: PageType.sewa);
          } else if (state is RoomCariPageActive) {
            debugPrint("RoomCariPageActive");

            return const PageContainer(pageType: PageType.roomchat);
          } else if (state is ProfilePageActive) {
            return PageContainerWithUserRepository(
              pageType: PageType.profile,
              userRepository: widget.userRepository,
              userid: widget.userid,
              key: null,
            );
          } else if (state is MerkCariPageActive) {
            debugPrint("MerkCariPageActive");

            return const PageContainer(pageType: PageType.mstmerk);
          }
          else if (state is MasaSewaCariPageActive) {
            debugPrint("MasaSewaCariPageActive");

            return const PageContainer(pageType: PageType.masasewa);
          }
          else if (state is TitleCariPageActive) {
            debugPrint("TitleCariPageActive");

            return const PageContainer(pageType: PageType.title);
          }
          else if (state is CustomerCariPageActive) {
            debugPrint("CustomerCariPageActive");

            return const PageContainer(pageType: PageType.customer);
          }
          else if (state is BengkelCariPageActive) {
            debugPrint("BengkelCariPageActive");

            return const PageContainer(pageType: PageType.bengkel);
          }
          else if (state is AsuransiCariPageActive) {
            debugPrint("AsuransiCariPageActive");

            return const PageContainer(pageType: PageType.asuransi);
          }
          else if (state is TipeCariPageActive) {
            debugPrint("TipeCariPageActive");

            return const PageContainer(pageType: PageType.tipemobil);
          }
          else if (state is WilayahCariPageActive) {
            debugPrint("WilayahCariPageActive");

            return const PageContainer(pageType: PageType.wilayah);
          }
          else if (state is JabatanCariPageActive) {
            debugPrint("JabatanCariPageActive");

            return const PageContainer(pageType: PageType.jabatan);
          }
          else if (state is HargaCariPageActive) {
            debugPrint("HargaCariPageActive");

            return const PageContainer(pageType: PageType.harga);
          }
          else if (state is StaffCariPageActive) {
            debugPrint("StaffCariPageActive");

            return const PageContainer(pageType: PageType.staff);
          }
          else if (state is WarnaCariPageActive) {
            debugPrint("WarnaCariPageActive");

            return const PageContainer(pageType: PageType.warna);
          }
          else if (state is MobilCariPageActive) {
            debugPrint("MobilCariPageActive");

            return const PageContainer(pageType: PageType.mobil);
          }
          else if (state is SewaCariPageActive) {
            debugPrint("SewaCariPageActive");

            return const PageContainer(pageType: PageType.sewa);
          }



          return Container();
        },
      ),
    );
  }
}
