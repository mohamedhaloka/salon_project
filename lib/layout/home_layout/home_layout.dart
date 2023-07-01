import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:salon_app/shared/componants/assets_manager.dart';

import '../../modules/appointment/booking.dart';
import '../../modules/home/home_screen.dart';
import '../../modules/settings/settings_screen.dart';
import '../../shared/componants/componants.dart';
import '../cubut/home_layout_cubit.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  List<Widget> bottomScreens = [
    const HomeScreen(),
    const BookingScreen(),
    const SettingsPage(),
  ];

  bool loading = true;

  @override
  void initState() {
    getInitialData();
    super.initState();
  }

  void getInitialData() async {
    final barberID = HomeLayoutCubit.instance.selectedBarber;

    await Future.wait([
      HomeLayoutCubit.instance.getUserData(),
      HomeLayoutCubit.instance.getChooseBarberData(barberID),
      HomeLayoutCubit.instance.getServices(),
      HomeLayoutCubit.instance.getSpecificData(barberID),
      HomeLayoutCubit.instance.getChooseServicesData(),
    ]);
    loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : background(
              child: bottomScreens[HomeLayoutCubit.instance.currentIndex],
            ),
      bottomNavigationBar: Container(
        color: HexColor("#eaeaf5"),
        padding: EdgeInsets.only(
          bottom: 18.0.h,
          right: 30.w,
          left: 30.w,
          top: 15.h,
        ),
        // height: 75,
        width: MediaQuery.of(context).size.width,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            elevation: 0.0,
            backgroundColor: HexColor("#e2e1fc"),
            currentIndex: HomeLayoutCubit.instance.currentIndex,
            onTap: (index) {
              HomeLayoutCubit.instance.changeBottom(index);
              setState(() {});
            },
            items: [
              BottomNavigationBarItem(
                activeIcon: Column(
                  children: const [
                    Image(
                      height: 24,
                      width: 25,
                      image: AssetImage(ImageAssets.homeIcon),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Image(image: AssetImage(ImageAssets.lineIcon)),
                  ],
                ),
                icon: Column(
                  children: const [
                    Image(
                      height: 24,
                      width: 25,
                      image: AssetImage(ImageAssets.homeIcon),
                    ),
                  ],
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                  activeIcon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Image(
                        height: 24,
                        width: 25,
                        image: AssetImage(ImageAssets.appointNavIcon),
                      ),
                      SizedBox(height: 8),
                      Image(image: AssetImage(ImageAssets.lineIcon)),
                    ],
                  ),
                  icon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Image(
                        height: 24,
                        width: 25,
                        image: AssetImage(ImageAssets.appointNavIcon),
                      ),
                    ],
                  ),
                  label: ''),
              BottomNavigationBarItem(
                activeIcon: Column(
                  children: const [
                    Image(
                      height: 24,
                      width: 25,
                      image: AssetImage(ImageAssets.personIcon),
                    ),
                    SizedBox(height: 8),
                    Image(image: AssetImage(ImageAssets.lineIcon)),
                  ],
                ),
                icon: Column(
                  children: const [
                    Image(
                      height: 24,
                      width: 25,
                      image: AssetImage(ImageAssets.personIcon),
                    ),
                  ],
                ),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
