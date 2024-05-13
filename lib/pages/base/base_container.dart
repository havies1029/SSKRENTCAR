import 'package:rentcarapp/pages/chatting/roomcari_list.dart';
import 'package:rentcarapp/pages/groupchat/groupchat_page.dart';
import 'package:rentcarapp/pages/home/home_page.dart';
import 'package:rentcarapp/menu/app_menu_drawer.dart';
import 'package:rentcarapp/pages/base/base_page.dart';
import 'package:rentcarapp/common/styles.dart';
import 'package:flutter/material.dart';
import 'package:rentcarapp/pages/mstharga/hargacari_main.dart';
import 'package:rentcarapp/pages/mstjabatan/jabatancari_main.dart';
import 'package:rentcarapp/pages/mstmasa/masacari_main.dart';
import 'package:rentcarapp/pages/mstmerk/merkcari_main.dart';
import 'package:rentcarapp/pages/mstmobil/mobilcari_main.dart';
import 'package:rentcarapp/pages/mstrekan/rekancari_main.dart';
import 'package:rentcarapp/pages/mststaff/staffcari_main.dart';
import 'package:rentcarapp/pages/msttipe/tipecari_main.dart';
import 'package:rentcarapp/pages/msttitle/titlecari_main.dart';
import 'package:rentcarapp/pages/mstwarna/warnacari_main.dart';
import 'package:rentcarapp/pages/mstwilayah/wilayahcari_main.dart';
import 'package:rentcarapp/pages/profile/profile_main_page.dart';
import 'package:rentcarapp/pages/sewamobil/sewacari_main.dart';
import 'package:rentcarapp/repositories/user/user_repository.dart';

class PageContainerWithUserRepository extends PageContainerBase {
  final int userid;
  final UserRepository userRepository;
  final PageType pageType;

  const PageContainerWithUserRepository(
      {required super.key,
      required this.userid,
      required this.userRepository,
      required this.pageType});

  @override
  Widget get menuDrawer => const AppMenu();

  @override
  String get pageTitle {
    //debugPrint("PageContainerWithUserRepository -> pageTitle");
    switch (pageType) {
      case PageType.profile:
        return "Profile";      
      default:
        return "Login Page";
    }
  }

  @override
  Widget get body {
    Widget? page;
    //debugPrint("PageContainerWithUserRepository -> body");
    switch (pageType) {
      case PageType.home:
        page = HomePage(
          userid: userid,
          userRepository: userRepository,
          key: null,
        );
        break;      
      case PageType.profile:
        page = ProfileMainPage(
          userid: userid,
          userRepository: userRepository,
        );
        break;      
      default:
        page = null;
    }
    return Padding(
      padding: EdgeInsets.all(Spacing.matGridUnit()),
      child: page,
    );
  }

  @override
  Widget get background => Container();

  @override
  Color get backgroundColor => AppColors.background;

  @override
  PageType? get parentModal => null;
}

class PageContainer extends PageContainerBase {
  final PageType pageType;
  final String? recId;

  const PageContainer({super.key, required this.pageType, this.recId});

  @override
  Widget get menuDrawer => const AppMenu();

  @override
  String get pageTitle {
    switch (pageType) {
      case PageType.profile:
        return "Profile";      
      case PageType.roomchat:
        return "Chat Support";
      case PageType.mstmerk:
        return "Master Merk";
      case PageType.masasewa:
        return "Master Masa Sewa";
      case PageType.title:
        return "Master Title";
      case PageType.customer:
        return "Master Customer";
      case PageType.bengkel:
        return "Master Bengkel";
      case PageType.asuransi:
        return "Master Asuransi";
      case PageType.tipemobil:
        return "Master Tipe Mobil";
      case PageType.wilayah:
        return "Master Wilayah Sewa";
      case PageType.jabatan:
        return "Master Jabatan";
      case PageType.harga:
        return "Master Harga Sewa";
      case PageType.staff:
        return "Master Karyawan";
      case PageType.mobil:
        return "Master Kendaraan";
      case PageType.sewa:
        return "Sewa Mobil";
      default:
        return "Login Page";
    }
  }

  @override
  Widget get body {
    Widget? page;

    switch (pageType) {
      
      case PageType.groupchat:
        page = const ChatPage(roomId: "support");
        break;
      case PageType.roomchat:
        page = const RoomCariPage();
        break;
      case PageType.mstmerk:
        page = const MerkCariMainPage();
        break;
      case PageType.masasewa:
        page = const MasaCariMainPage();
        break;
      case PageType.title:
        page = const TitleCariMainPage();
        break;
      case PageType.customer:
        page = const RekanCariMainPage(rekanTypeId: "00010");
        break;
      case PageType.bengkel:
        page = const RekanCariMainPage(rekanTypeId: "00020");
        break;
      case PageType.asuransi:
        page = const RekanCariMainPage(rekanTypeId: "00030");
        break;
      case PageType.tipemobil:
        page = const TipeCariMainPage();
        break;
      case PageType.wilayah:
        page = const WilayahCariMainPage();
        break;
      case PageType.jabatan:
        page = const JabatanCariMainPage();
        break;
      case PageType.harga:
        page = const HargaCariMainPage();
        break;
      case PageType.staff:
        page = const StaffCariMainPage();
        break;
      case PageType.warna:
        page = const WarnaCariMainPage();
        break;
      case PageType.mobil:
        page = const MobilCariMainPage();
        break;
      case PageType.sewa:
        page = const SewaCariMainPage();
        break;
      default:
        page = null;
    }
    return Padding(
      padding: EdgeInsets.all(Spacing.matGridUnit()),
      child: page,
    );
  }

  @override
  Widget get background => Container();

  @override
  Color get backgroundColor => AppColors.background;

  @override
  PageType? get parentModal => null;
}
