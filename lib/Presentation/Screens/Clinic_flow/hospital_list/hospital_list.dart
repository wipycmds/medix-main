import 'package:flutter/material.dart';
import 'package:medix/Data/Fake_data/Clinic_visit/hospital.dart';
import 'package:medix/Data/Model/Clinic/hospital_card_model.dart';
import 'package:medix/Extensions/white_space_extension.dart';
import 'package:medix/Presentation/Screens/Clinic_flow/Hospital_details/hospital_details.dart';
import 'package:medix/Presentation/Screens/Clinic_flow/hospital_list/Compo/hospital_drawer.dart';
import 'package:medix/Presentation/Screens/Clinic_flow/hospital_list/hospital_view_model.dart';
import 'package:medix/Utils/utils.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
import '../Shared/app_bar.dart' as bar;
import 'Compo/detail.dart';

class HospitalList extends StatefulWidget {
  const HospitalList({Key? key}) : super(key: key);

  @override
  State<HospitalList> createState() => _HospitalListState();
}

class _HospitalListState extends State<HospitalList> {
  late final GlobalKey<ScaffoldState> _scfKey;
  @override
  void initState() {
    _scfKey = GlobalKey<ScaffoldState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
        key: _scfKey,
        drawerScrimColor: Colors.transparent,
        endDrawer: const HospitalDrawer(),
        body: ViewModelBuilder<HospitalListViewModel>.reactive(
          viewModelBuilder: () => HospitalListViewModel(),
          builder: (context, model, child) => Stack(
            children: [
              CustomScrollView(
                slivers: [
                  const bar.TopAppBar(step: bar.Step.hospital),
                  SliverToBoxAdapter(
                    child: SizedBox(height: 5.h),
                  ),
                  SliverToBoxAdapter(
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Row(children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hospital List',
                                  style: FontStyleUtilities.h2(
                                      fontWeight: FWT.medium,
                                      fontColor: isLight
                                          ? Colors.black
                                          : Colors.white),
                                ),
                                Text(
                                  'Find the service you are ',
                                  style: FontStyleUtilities.h6(
                                      fontWeight: FWT.medium,
                                      fontColor: isLight
                                          ? const Color(0xffB9B9B9)
                                          : Colors.white.withOpacity(0.80)),
                                ),
                              ],
                            ),
                            const Spacer(),
                            IconWrapper(
                                onTap: () {}, icon: 'assets/Icons/Search.svg'),
                            SizedBox(width: 30.w),
                            IconWrapper(
                                onTap: () {
                                  _scfKey.currentState!.openEndDrawer();
                                },
                                icon: 'assets/Icons/Filter.svg',
                                padding: 9)
                          ]))),
                  SliverSizedBox(height: 5.h),
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                          (context, index) => HospitalCard(
                                selected:
                                    model.checkIfSelected(hospitals[index]),
                                onTap: () {
                                  model.chooseHospital(hospitals[index]);
                                },
                                info: hospitals[index],
                              ),
                          childCount: hospitals.length)),
                  SliverSizedBox(height: 115.h)
                ],
              ),
              Positioned(
                  bottom: 0,
                  width: 375.w,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
                    child: Button(
                        isArrowButton: true,
                        tittle: 'Continue',
                        onTap: () {
                          NavigationUtil.to(context, const HospitalDetails());
                        }),
                  )),
            ],
          ),
        ));
  }
}

class HospitalCard extends StatelessWidget {
  const HospitalCard(
      {Key? key,
      required this.info,
      this.selected = false,
      required this.onTap})
      : super(key: key);
  final HospitalModel info;
  final bool? selected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 285.h,
        padding: EdgeInsets.fromLTRB(14.w, 16.h, 14.w, 13.h),
        margin: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 0),
        decoration: BoxDecoration(
            border: selected!
                ? Border.all(width: 2, color: ColorUtil.primaryColor)
                : Border.all(width: 2, color: Colors.transparent),
            color: isLight ? Colors.white : ColorUtil.surfaceDark,
            borderRadius: BorderRadius.circular(15.r)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 154.h,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Image.asset(
                    info.image,
                    height: 154.h,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
                Positioned(
                  bottom: 10.h,
                  right: 10.w,
                  child: GlassContainer(
                    color: isLight
                        ? Colors.white.withOpacity(.35)
                        : ColorUtil.surfaceDark.withOpacity(0.20),
                    height: 20.h,
                    padding: EdgeInsets.symmetric(horizontal: 9.w),
                    borderRadius: BorderRadius.circular(9.r),
                    child: Text(
                      "\$${info.charge}",
                      style: FontStyleUtilities.t2(
                          height: 1.3,
                          fontWeight: FWT.semiBold,
                          fontColor: Colors.white),
                    ),
                  ),
                ),
                Positioned(
                    top: 10.h,
                    right: 24.w,
                    child: GlassContainer(
                      padding: EdgeInsets.all(6.h),
                      borderRadius: BorderRadius.circular(16.h),
                      height: 32.h,
                      width: 32.h,
                      color: isLight
                          ? const Color(0xffB6B6B6).withOpacity(.16)
                          : ColorUtil.surfaceDark,
                      child: AnimIcon(
                          activeIcon: 'assets/Icons/Heart.svg',
                          deactivateIcon: 'assets/Icons/Heart.svg',
                          deactivateColor: ColorUtil.mediumTextColor,
                          onChanged: (value) {}),
                    )),
              ],
            ),
          ),
          SizedBox(height: 13.h),
          Text(
            info.name,
            style: FontStyleUtilities.h4(
              height: 1,
              fontWeight: FWT.medium,
              fontColor: isLight ? Colors.black : Colors.white,
            ).copyWith(fontSize: 19.sp),
          ),
          7.20.height(),
          Text(
            info.city,
            style: FontStyleUtilities.h6(
              fontWeight: FWT.medium,
              height: 1,
              fontColor: isLight ? Colors.black.withOpacity(.35) : Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              SvgIcon(
                'assets/Icons/Star.svg',
                height: 12.7.h,
              ),
              SizedBox(
                width: 6.33.w,
              ),
              Text(
                '${info.averageReview} (${info.reviewCount} Reviews)',
                style: FontStyleUtilities.h6(
                  fontWeight: FWT.medium,
                  height: 1,
                  fontColor:
                      isLight ? Colors.black.withOpacity(.35) : Colors.white,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  NavigationUtil.to(context, const HospitalDetails());
                },
                child: DetailTag(isLight: isLight),
              )
            ],
          )
        ]),
      ),
    );
  }
}
