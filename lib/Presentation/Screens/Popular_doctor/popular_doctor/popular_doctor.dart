import 'package:flutter/material.dart';
import 'package:medix/Data/Fake_data/Home/doctors.dart';
import 'package:medix/Presentation/Screens/Popular_doctor/Popular_doctor_profile/popular_doctor_profile.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medix/Utils/font_style.dart';
import 'package:medix/Utils/navigation_util.dart';
import '../../Flow_widgets/doctor_card.dart';
import '../../Profile/Drawer/drawer_controller.dart';
import '../../Profile/Drawer/drawer_page.dart';

class PopularDoctorScreen extends StatefulWidget {
  const PopularDoctorScreen({Key? key}) : super(key: key);

  @override
  State<PopularDoctorScreen> createState() => _PopularDoctorScreenState();
}

class _PopularDoctorScreenState extends State<PopularDoctorScreen> {
  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  final controller = Controller();
  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      key: key,
      drawer: DrawerPage(
        drawerController: controller,
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
              title: Text(
                'Popular Doctors',
                style: FontStyleUtilities.h3(
                        fontWeight: FWT.medium,
                        fontColor: isLight ? Colors.black : Colors.white)
                    .copyWith(fontSize: 22.sp),
              ),
              pinned: true,
              elevation: 4,
              leadingWidth: 37.w,
              leading: Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: GestureDetector(
                  onTap: () {
                    key.currentState!.openDrawer();
                  },
                  child: SvgIcon('assets/Icons/menu.svg',
                      color: isLight ? null : Colors.white),
                ),
              ),
              actions: [
                Container(
                    margin: EdgeInsets.symmetric(vertical: 5.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.only(left: 12.w, right: 12.w),
                    width: 48.w,
                    child: const SvgIcon(
                      'assets/Icons/Notification.svg',
                    )),
                SizedBox(width: 16.w)
              ]),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, int index) => DoctorCard(
                      info: doctors[index],
                      onTap: () {
                        NavigationUtil.to(
                            context, const PopularDoctorProfile());
                      }),
                  childCount: doctors.length)),
          SliverSizedBox(
            height: 115.h,
          )
        ],
      ),
    );
  }
}
