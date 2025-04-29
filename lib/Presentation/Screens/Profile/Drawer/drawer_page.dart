import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medix/Presentation/Screens/Auth/Login/login.dart';
import 'package:medix/Presentation/Screens/Clinic_flow/clinic_visit/clinic_vist.dart';
import 'package:medix/Presentation/Screens/help%20center/helpcenter.dart';
import '../about us/about.dart';
import 'drawer_controller.dart';
import 'package:medix/Utils/utils.dart';
import 'package:medix/Extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../MyAppointment/my_appointment.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({
    Key? key,
    required this.drawerController,
  }) : super(key: key);
  final Controller drawerController;
  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    final theme = Theme.of(context);
    final selectedColor = theme.primaryColor.withOpacity(.10);
    return DrawerWrapper<Controller>(
      controller: widget.drawerController,
      builder: (context, controller) => Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: data.padding.top,
            ),
            Padding(
                padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: selectedColor,
                      radius: 24.r,
                      backgroundImage:
                          const AssetImage('assets/Images/Temp/profile.png'),
                    ),
                    24.height(),
                    Text(
                      'Sandra Adams',
                      style: FontStyleUtilities.h3(
                          fontWeight: FWT.medium,
                          height: 1,
                          fontColor: theme.brightness == Brightness.light
                              ? Colors.black
                              : Colors.white.withOpacity(0.70)),
                    ),
                    SizedBox(
                      height: 24.h,
                      child: Text(
                        'sandra_d47@gmail.com',
                        style: FontStyleUtilities.t2(
                            fontColor: theme.brightness == Brightness.light
                                ? ColorUtil.mediumTextColor
                                : Colors.white.withOpacity(0.50),
                            fontWeight: FWT.medium),
                      ),
                      //         ))
                      //     .toList(),
                      // onChanged: setDropDown),
                    ),
                    20.height()
                  ],
                )),
            const Divider(
              height: 1,
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  DrawerTile(
                      isSelected: controller.index == 0,
                      onTap: () {
                        selectDestination(0);
                        NavigationUtil.to(context, const MyAppointmentScreen());
                      },
                      leading: Icons.meeting_room_outlined,
                      tittle: 'My Activity'),
                  12.height(),
                  DrawerTile(
                      isSelected: controller.index == 1,
                      onTap: () {
                        selectDestination(1);
                        NavigationUtil.to(context, ClinicVisit());
                      },
                      leading: Icons.update,
                      tittle: 'Schedule Appointment'),
                ],
              ),
            ),
            const Divider(
              height: 1,
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                children: [
                  DrawerTile(
                      isSelected: controller.index == 2,
                      onTap: () {
                        selectDestination(2);
                        NavigationUtil.to(context, const AboutUs());
                      },
                      leading: Icons.info_outline_rounded,
                      tittle: 'About Us'),
                  12.height(),
                  DrawerTile(
                      isSelected: controller.index == 3,
                      onTap: () {
                        selectDestination(3);
                        NavigationUtil.to(context, const HelpCenter());
                      },
                      leading: Icons.help_center_outlined,
                      tittle: 'Help Center'),
                  12.height(),
                ],
              ),
            ),
            const Divider(
              height: 1,
              thickness: 1,
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    12.height(),
                    DrawerTile(
                        isSelected: controller.index == 4,
                        onTap: () {
                          selectDestination(4);
                        },
                        leading: Icons.delete_forever_outlined,
                        tittle: 'Delete Account'),
                    12.height(),
                    DrawerTile(
                        isSelected: controller.index == 5,
                        onTap: () {
                          selectDestination(5);
                          Navigator.of(context).pushAndRemoveUntil(
                              CupertinoPageRoute(
                                  builder: (context) => const Login()),
                              (route) => false);
                        },
                        leading: Icons.logout,
                        tittle: 'Log Out'),
                    12.height(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  String currentValue = 'sandra_a88@gmail.com';

  void setDropDown(String? value) {
    currentValue = value ?? currentValue;
    setState(() {});
  }

  void selectDestination(int index) {
    Navigator.pop(context);
  }
}

class DrawerTile extends StatelessWidget {
  const DrawerTile(
      {Key? key,
      required this.isSelected,
      required this.onTap,
      required this.leading,
      required this.tittle})
      : super(key: key);
  final bool isSelected;
  final VoidCallback onTap;
  final IconData leading;
  final String tittle;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedColor = theme.primaryColor.withOpacity(.10);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          color: isSelected ? selectedColor : Colors.transparent,
        ),
        child: Row(
          children: [
            Icon(
              leading,
              size: 22.w,
              color: isSelected
                  ? theme.primaryColor
                  : theme.brightness == Brightness.light
                      ? ColorUtil.mediumTextColor
                      : Colors.white.withOpacity(0.50),
            ),
            22.width(),
            Text(
              tittle,
              style: FontStyleUtilities.h6(
                  fontWeight: FWT.medium,
                  fontColor: isSelected
                      ? theme.primaryColor
                      : theme.brightness == Brightness.light
                          ? ColorUtil.mediumTextColor
                          : Colors.white.withOpacity(0.50)),
            ),
          ],
        ),
      ),
    );
  }
}
