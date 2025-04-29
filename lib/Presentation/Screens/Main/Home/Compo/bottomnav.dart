import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medix/Presentation/Screens/Main/Home/home.dart';
import 'package:medix/Presentation/Screens/pharmacy/onlinepharmacy.dart';
import 'package:medix/Utils/color_utils.dart';
import '../../../../../Utils/font_style.dart';
import '../../../Profile/Drawer/drawer_controller.dart';
import '../../../Profile/Drawer/drawer_page.dart';
import 'end_drawer.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key, this.index = 0}) : super(key: key);

  final int index;

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  final controller = Controller();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      currentIndex.value = widget.index;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;

    return ValueListenableBuilder<int>(
      valueListenable: currentIndex,
      builder: (context, value1, child) {
        return Scaffold(
          drawer: DrawerPage(drawerController: controller),
          endDrawer: const HomeFilter(),
          body: WillPopScope(
            onWillPop: () async {
              if (mounted) {
                if (currentIndex.value != 0) {
                  currentIndex.value = 0;
                } else {
                  SystemNavigator.pop();
                }
              }
              return false;
            },
            child: SafeArea( // Make sure content is safe and flexible
              child: IndexedStack(
                index: currentIndex.value,
                children: [
                  const Home(),
                  OnlinePharmacy(
                    onIndexChanged: (value) {
                      indexSet(value);
                    },
                  )
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedIconTheme: const IconThemeData(size: 28),
            backgroundColor: isLight ? Colors.white : ColorUtil.surfaceDark,
            selectedItemColor: ColorUtil.primaryColor,
            unselectedItemColor: Colors.grey[400],
            currentIndex: currentIndex.value,
            onTap: (value) {
              indexSet(value);
            },
            selectedLabelStyle: FontStyleUtilities.t2(
              fontFamily: FF.poppins,
              fontWeight: FWT.semiBold,
            ),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.meeting_room_outlined),
                tooltip: 'Appointment',
                label: 'Appointment',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.medication),
                tooltip: 'Pharmacy',
                label: 'Pharmacy',
              ),
            ],
          ),
        );
      },
    );
  }

  void indexSet(int value) {
    currentIndex.value = value;
  }
}

