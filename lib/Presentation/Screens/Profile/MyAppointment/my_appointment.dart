import 'package:flutter/material.dart';
import 'package:medix/Presentation/Screens/shopping/compo/listwrapper.dart';
import 'package:medix/Presentation/Widgets/animate_color.dart';
import 'package:medix/Utils/utils.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';
import 'package:medix/Extensions/extension.dart';
import '../../order/order.dart';
import '../AppointmentDetails/appointment_details.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Shared/icon_container.dart';

class MyAppointmentScreen extends StatefulWidget {
  const MyAppointmentScreen({Key? key}) : super(key: key);

  @override
  State<MyAppointmentScreen> createState() => _MyAppointmentScreenState();
}

class _MyAppointmentScreenState extends State<MyAppointmentScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  int currentIndex = 0;
  List<Widget> tabs = [
    const AppointmentWrapper(),
    const OrderScreen(),
    const OrderScreen(),
  ];

  @override
  void initState() {
    controller = TabController(length: 3, vsync: this)
      ..addListener(() {
        if (controller.indexIsChanging) {
          setState(() {
            currentIndex = controller.index;
          });
        }
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            pinned: true,
            leading: MyBackButton(),
            title: Text('My Activity'),
          ),
          MyStickyHeader(
            height: 76.h,
            pinned: true,
            elevation: 4,
            child: DefaultTabController(
              length: 3,
              child: Container(
                padding: EdgeInsets.all(4.h),
                decoration: BoxDecoration(
                    color: isLight
                        ? const Color(0xffF4F4F4)
                        : ColorUtil.surfaceDark,
                    borderRadius: BorderRadius.circular(27.5.r)),
                margin: EdgeInsets.symmetric(vertical: 10.h),
                height: 56.h,
                width: 335.w,
                child: TabBar(
                    controller: controller,
                    labelColor: isLight ? Colors.black : Colors.white,
                    unselectedLabelColor: const Color(0xffA6a6a6),
                    physics: const NeverScrollableScrollPhysics(),
                    labelStyle: FontStyleUtilities.h6(
                        fontWeight: FWT.medium, fontColor: Colors.black),
                    labelPadding: EdgeInsets.symmetric(horizontal: 2.w),
                    onTap: (value) {
                      setState(() {
                        currentIndex = value;
                      });
                    },
                    indicator: BoxDecoration(
                        color: isLight ? Colors.white : ColorUtil.scaffoldDark,
                        borderRadius: BorderRadius.circular(27.5.r)),
                    tabs: const [
                      Tab(
                        text: 'Appointments',
                      ),
                      Tab(text: 'Delivery'),
                      Tab(text: 'Medication')
                    ]),
              ),
            ),
          ),
          SliverSizedBox(height: 10.h),
          SliverPadding(
            padding: EdgeInsets.only(bottom: 24.h),
            sliver: SliverList(
              delegate: SliverChildListDelegate([tabs[currentIndex]]),
            ),
          ),
        ],
      ),
    );
  }
}

class AppointmentWrapper extends StatelessWidget {
  const AppointmentWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppointmentTiles(
          onTap: () {
            NavigationUtil.to(context, const AppointmentDetails());
          },
          status: 'Pending',
          color: ColorUtil.pendingYellow,
          iconOption: IconOption.direct,
        ),
        AppointmentTiles(
          onTap: () {},
          status: 'Processing',
          color: ColorUtil.primaryColor,
          iconOption: IconOption.video,
        ),
        AppointmentTiles(
          onTap: () {},
          status: 'Processing',
          color: ColorUtil.primaryColor,
          iconOption: IconOption.chat,
        ),
      ],
    );
  }
}

class AppointmentTiles extends StatelessWidget {
  const AppointmentTiles(
      {Key? key,
      required this.iconOption,
      this.status = '',
      this.color,
      required this.onTap})
      : super(key: key);
  final IconOption iconOption;
  final String status;
  final Color? color;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedColor = theme.primaryColor.withOpacity(.10);
    var isLight = Theme.of(context).brightness == Brightness.light;
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          AnimateColor(
            isTextAnimate: false,
            startcolor: color!.withOpacity(0.049),
            endcolor: isLight ? Colors.white : ColorUtil.scaffoldDark,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.r),
                  color: isLight ? Colors.white : ColorUtil.surfaceDark,
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(2, 4),
                        blurRadius: 30)
                  ]),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.w),
                        decoration: BoxDecoration(
                            color: selectedColor,
                            borderRadius: BorderRadius.circular(4.r)),
                        height: 20.h,
                        child: Text(
                          '12 Jan',
                          style: FontStyleUtilities.t5(
                              fontWeight: FWT.medium,
                              fontColor: theme.primaryColor),
                        ),
                      ),
                      6.height(),
                      Text(
                        'Headache and nausea',
                        style: FontStyleUtilities.h4(
                          fontWeight: FWT.semiBold,
                          fontColor: isLight ? Colors.black : Colors.white,
                        ),
                      ),
                      4.height(),
                      Text('Dr.Jonas Edmund',
                          style: FontStyleUtilities.t2(
                            fontWeight: FWT.semiBold,
                            fontColor: isLight
                                ? ColorUtil.mediumTextColor
                                : Colors.white.withOpacity(0.7),
                          )),
                    ],
                  ),
                  const Spacer(),
                  IconContainer(iconOption: iconOption)
                ],
              ),
            ),
          ),
          Positioned(
            left: 90.w,
            top: 24.h,
            child: Colorbox(
              counting: status,
              padding: const EdgeInsets.all(0),
              isIcon: false,
              backColor: isLight ? Colors.white : ColorUtil.surfaceDark,
              width: 90.h,
              color: color,
              backheight: 22.h,
              backwidth: 90.h,
              height: 22.h,
              borderRadius: 10.r,
            ),
          )
        ],
      ),
    );
  }
}
