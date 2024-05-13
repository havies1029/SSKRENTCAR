import 'package:rentcarapp/pages/home/home.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentcarapp/blocs/authentication/authentication_bloc.dart';
import 'package:rentcarapp/blocs/home/home_bloc.dart';
import 'package:flutter/material.dart';

class AppMenu extends StatefulWidget {
  const AppMenu({super.key});

  @override
  AppMenuState createState() => AppMenuState();
}

class AppMenuState extends State<AppMenu> with RouteAware {
  @override
  Widget build(BuildContext context) {
    final HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);

    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPictureSize: const Size.square(120),
            currentAccountPicture: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                //color: Colors.blue,
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Image.asset('assets/images/login_logo.png', width: 100, height: 100,),
              ),
            ),
            accountEmail: const Text("support@jayaproteksindo.co.id"),
            accountName: const Text("CS-Support"),
            onDetailsPressed: () {
              SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                Navigator.of(context).pop();
                homeBloc.add(ProfilePageActiveEvent());
              });
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Profile"),
            //selected: _activeRoute == AppRoutes.homePage,
            onTap: () {
              SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                Navigator.of(context).pop();
                homeBloc.add(ProfilePageActiveEvent());
              });
            },
          ),

          ExpansionTile(
            leading: const Icon(
              Icons.car_repair,          
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 10.0,          
            ),
            title: const Text(
              "Tansaksi",
              style: TextStyle(            
              ),
            ),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: ListTile(
                  leading: const Icon(Icons.note_alt),
                  title: const Text("Sewa Mobil"),
                  onTap: () {
                    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                      Navigator.of(context).pop();
                      homeBloc.add(SewaCariPageActiveEvent());
                    });
                  },
                ),
              ),              
            ],
          ),

          ExpansionTile(
            leading: const Icon(
              Icons.car_repair,          
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 10.0,          
            ),
            title: const Text(
              "Data Mobil",
              style: TextStyle(            
              ),
            ),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: ListTile(
                  leading: const Icon(Icons.note_alt),
                  title: const Text("Warna Mobil"),
                  onTap: () {
                    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                      Navigator.of(context).pop();
                      homeBloc.add(WarnaCariPageActiveEvent());
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: ListTile(
                  leading: const Icon(Icons.note_alt),
                  title: const Text("Merk Mobil"),
                  onTap: () {
                    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                      Navigator.of(context).pop();
                      homeBloc.add(MerkCariPageActiveEvent());
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: ListTile(
                  leading: const Icon(Icons.note_alt),
                  title: const Text("Tipe Mobil"),
                  onTap: () {
                    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                      Navigator.of(context).pop();
                      homeBloc.add(TipeCariPageActiveEvent());
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: ListTile(
                  leading: const Icon(Icons.note_alt),
                  title: const Text("Master Kendaraan"),
                  onTap: () {
                    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                      Navigator.of(context).pop();
                      homeBloc.add(MobilCariPageActiveEvent());
                    });
                  },
                ),
              ),
            ],
          ),

          ExpansionTile(
            leading: const Icon(
              Icons.money,          
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 10.0,          
            ),
            title: const Text(
              "Data Sewa",
              style: TextStyle(            
              ),
            ),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: ListTile(
                  leading: const Icon(Icons.timer),
                  title: const Text("Masa Sewa"),
                  onTap: () {
                    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                      Navigator.of(context).pop();
                      homeBloc.add(MasaSewaCariPageActiveEvent());
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: ListTile(
                  leading: const Icon(Icons.timer),
                  title: const Text("Wilayah Sewa"),
                  onTap: () {
                    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                      Navigator.of(context).pop();
                      homeBloc.add(WilayahCariPageActiveEvent());
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: ListTile(
                  leading: const Icon(Icons.timer),
                  title: const Text("Harga Sewa"),
                  onTap: () {
                    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                      Navigator.of(context).pop();
                      homeBloc.add(HargaCariPageActiveEvent());
                    });
                  },
                ),
              ),
            ],
          ),          

          ExpansionTile(
            leading: const Icon(
              Icons.settings,          
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 10.0,          
            ),
            title: const Text(
              "Data Umum",
              style: TextStyle(            
              ),
            ),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: ListTile(
                  leading: const Icon(Icons.timer),
                  title: const Text("Title"),
                  onTap: () {
                    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                      Navigator.of(context).pop();
                      homeBloc.add(TitleCariPageActiveEvent());
                    });
                  },
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: ListTile(
                  leading: const Icon(Icons.timer),
                  title: const Text("Jabatan"),
                  onTap: () {
                    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                      Navigator.of(context).pop();
                      homeBloc.add(JabatanCariPageActiveEvent());
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: ListTile(
                  leading: const Icon(Icons.timer),
                  title: const Text("Customer"),
                  onTap: () {
                    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                      Navigator.of(context).pop();
                      homeBloc.add(CustomerCariPageActiveEvent());
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: ListTile(
                  leading: const Icon(Icons.timer),
                  title: const Text("Bengkel"),
                  onTap: () {
                    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                      Navigator.of(context).pop();
                      homeBloc.add(BengkelCariPageActiveEvent());
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: ListTile(
                  leading: const Icon(Icons.timer),
                  title: const Text("Asuransi"),
                  onTap: () {
                    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                      Navigator.of(context).pop();
                      homeBloc.add(AsuransiCariPageActiveEvent());
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: ListTile(
                  leading: const Icon(Icons.timer),
                  title: const Text("Karyawan"),
                  onTap: () {
                    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                      Navigator.of(context).pop();
                      homeBloc.add(StaffCariPageActiveEvent());
                    });
                  },
                ),
              ),
            ],
          ),          
          ListTile(
            leading: const Icon(Icons.chat),
            title: const Text("Chat Support"),
            //selected: _activeRoute == AppRoutes.homePage,
            onTap: () {              
              SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                Navigator.of(context).pop();
                homeBloc.add(RoomCariPageActiveEvent());
              });
            },
          ),                       
          const AboutListTile(
            icon: Icon(Icons.info),
            applicationName: "JPS SuperApp",
            aboutBoxChildren: <Widget>[
              Text("http://www.jayaproteksindo.co.id/", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
              Text("version : 0.2", style: TextStyle(fontSize: 12.0),),
            ],
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            onTap: () {
              BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
            },
          ),
        ],
      ),
    );
  }
}
