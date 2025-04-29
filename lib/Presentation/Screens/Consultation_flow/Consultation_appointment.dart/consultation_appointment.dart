import 'package:flutter/material.dart';
import 'package:medix/Data/Fake_data/Consultation/fees.dart';
import 'package:medix/Data/Model/Consultation/fees_model.dart';
import 'package:medix/Extensions/white_space_extension.dart';
import 'package:medix/Presentation/Constants/gradients.dart';
import 'package:medix/Presentation/Screens/Consultation_flow/Confrim_consulatation/confirm_consultation.dart';
import 'package:medix/Presentation/Screens/Consultation_flow/audio_call_doctor/audio_call_doctor.dart';
import 'package:medix/Presentation/Screens/Consultation_flow/video_call_doctor/video_call_doctor.dart';
import 'package:medix/Utils/utils.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medix/package/filter_controller.dart';
import 'components/schedule_tile_wrapper.dart';

class ConsultationAppointment extends StatefulWidget {
  const ConsultationAppointment({Key? key}) : super(key: key);

  @override
  State<ConsultationAppointment> createState() =>
      _ConsultationAppointmentState();
}

class _ConsultationAppointmentState extends State<ConsultationAppointment>
    with SingleTickerProviderStateMixin {
  final List<String> _tabNames = <String>[
    'Morning Schedule',
    'Evening Schedule'
  ];
  int _selectedIndex = 0;
  late List<Tab> _tabs;
  late final TabController _tabController;
  late FilterController<FeesModel> _feesController;
  late FilterController<String> _filterController;
  @override
  void initState() {
    _filterController = FilterController<String>();
    _feesController = FilterController<FeesModel>();
    _tabController = TabController(
      length: _tabNames.length,
      vsync: this,
    );
    _tabs = <Tab>[
      ..._tabNames
          .map((e) => Tab(
                text: e,
              ))
          
    ];
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight + 2.0),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Stack(
              children: [
                Positioned(
                  width: (375 - 32).w,
                  bottom: 0,
                  child: const Padding(
                    padding: EdgeInsets.only(bottom: .5),
                    child: Divider(
                      height: 1,
                      color: Color(0xffACACAC),
                    ),
                  ),
                ),
                TabBar(
                  labelPadding: EdgeInsets.symmetric(horizontal: 16.w),
                  isScrollable: true,
                  unselectedLabelStyle:
                      FontStyleUtilities.h4(fontWeight: FWT.regular)
                          .copyWith(fontSize: 19),
                  labelStyle: FontStyleUtilities.h4(fontWeight: FWT.medium)
                      .copyWith(fontSize: 19),
                  labelColor: isLight ? Colors.black : Colors.white,
                  unselectedLabelColor: const Color(0xffA6A6A6),
                  tabs: _tabs,
                  controller: _tabController,
                ),
              ],
            ),
          ),
        ),
        leading: const MyBackButton(),
        title: const Text('Appointment'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          14.height(),
          SizedBox(
            height: 216.h,
            child: TabBarView(controller: _tabController, children: [
              Schedules(morningTimes: const [
                '10:30 AM',
                '11:00 AM',
                '11:30 AM',
                '12:00 PM',
                '12:30 PM',
                '01:00 pM',
                '01:30 AM',
              ], controller: _filterController),
              Schedules(morningTimes: const [
                '02:30 PM',
                '03:00 PM',
                '03:30 PM',
                '04:00 PM',
                '04:30 PM',
                '05:00 PM',
                '05:30 PM',
              ], controller: _filterController),
            ]),
          ),
          23.height(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text('Fees Information',
                style: FontStyleUtilities.h4(
                        fontWeight: FWT.medium,
                        fontColor: isLight ? Colors.black : Colors.white)
                    .copyWith(fontSize: 19)),
          ),
          13.height(),
          ListView.builder(
              shrinkWrap: true,
              itemCount: fees.length,
              itemBuilder: (context, int index) => AnimatedBuilder(
                    animation: _feesController,
                    builder: (context, child) => FeesInformationTile(
                        onTap: () {
                          _selectedIndex = index;
                          _feesController.addAsRadio(fees[index]);
                        },
                        info: fees[index],
                        isSelected:
                            _feesController.checkIfSelected(fees[index])),
                  )),
          50.height(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Button(
                tittle: 'Continue',
                onTap: () {
                  if (!_feesController.checkIfNotSelected &&
                      !_filterController.checkIfNotSelected) {
                    NavigationUtil.to(context, const ConfirmConsultation());
                  } else {
                    NavigationUtil.to(
                        context,
                        _selectedIndex == 0
                            ? const CallADoctor()
                            : const VideoCallDoctor());
                  }
                }),
          )
        ],
      ),
    );
  }
}

class FeesInformationTile extends StatelessWidget {
  const FeesInformationTile(
      {Key? key,
      required this.info,
      required this.isSelected,
      required this.onTap})
      : super(key: key);
  final FeesModel info;
  final bool isSelected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          gradient: isSelected ? AppGradients.blueGradient : null,
          // color: isSelected ? ColorUtil.primaryColor : Colors.white
        ),
        height: 62.h,
        width: double.infinity,
        child: Row(
          children: [
            AuthIconWrapper(
              borderRadius: 10.r,
              color: isSelected ? Colors.white : null,
              height: 54.h,
              width: 54.h,
              icon: info.icon,
              margin: EdgeInsets.all(4.w),
            ),
            8.width(),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  info.tittle,
                  style: FontStyleUtilities.h6(
                      fontWeight: FWT.medium,
                      fontColor: isSelected
                          ? Colors.white
                          : isLight
                              ? Colors.black
                              : Colors.white),
                ),
                Text(
                  info.subTittle,
                  style: FontStyleUtilities.t2(
                      fontWeight: FWT.regular,
                      fontColor: isSelected
                          ? Colors.white
                          : isLight
                              ? Colors.black
                              : Colors.white),
                ),
              ],
            ),
            const Spacer(),
            Text(
              "\$${info.price.toInt()}",
              style: FontStyleUtilities.h4(
                  fontWeight: FWT.semiBold,
                  height: 1,
                  fontColor: isSelected
                      ? Colors.white
                      : isLight
                          ? Colors.black
                          : Colors.white),
            ),
            10.width(),
          ],
        ),
      ),
    );
  }
}
