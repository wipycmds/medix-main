import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medix/Presentation/Constants/gradients.dart';
import 'package:medix/Presentation/Screens/Clinic_flow/Appointment_data/appointment_data.dart';
import 'package:medix/Utils/utils.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';
import 'package:medix/Extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

class SelectAppointmentDate extends StatelessWidget {
  const SelectAppointmentDate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              const SliverAppBar(
                pinned: true,
                leading: MyBackButton(),
                title: Text('Appointment'),
              ),
              MyStickyHeader(
                height: 76.h,
                pinned: true,
                elevation: 4,
                child: DefaultTabController(
                  length: 2,
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
                        labelColor: isLight ? Colors.black : Colors.white,
                        unselectedLabelColor: const Color(0xffA6a6a6),
                        labelStyle: FontStyleUtilities.h6(
                          fontWeight: FWT.medium,
                          fontColor: isLight ? Colors.black : Colors.white,
                        ),
                        indicator: BoxDecoration(
                            color:
                                isLight ? Colors.white : ColorUtil.scaffoldDark,
                            borderRadius: BorderRadius.circular(27.5.r)),
                        tabs: const [
                          Tab(text: 'Current'),
                          Tab(text: 'History')
                        ]),
                  ),
                ),
              ),
              SliverSizedBox(height: 27.h),
              SliverSizedBox(
                child: DateWidget(
                  onChanged: (DateTime value) {},
                ),
              ),
              SliverSizedBox(height: 17.h),
              TimeWIdget(
                onChange: (value) {},
                availableTime: const [
                  '10:30 PM',
                  '11:00 AM',
                  '12:00 PM',
                  '12:30 PM',
                  '01:00 PM',
                  '01:30 PM'
                ],
              ),
              SliverSizedBox(
                height: 110.h,
              )
            ],
          ),
          Positioned(
              bottom: 0,
              width: 375.w,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
                child: Button(
                    isArrowButton: true,
                    tittle: 'Continue',
                    onTap: () {
                      NavigationUtil.to(context, const AppointmentData());
                    }),
              )),
        ],
      ),
    );
  }
}

class TimeWIdget extends StatefulWidget {
  const TimeWIdget({
    Key? key,
    required this.availableTime,
    required this.onChange,
  }) : super(key: key);

  final List<String> availableTime;
  final ValueChanged<String> onChange;
  @override
  State<TimeWIdget> createState() => _TimeWIdgetState();
}

class _TimeWIdgetState extends State<TimeWIdget> {
  _onTap(int index) {
    _selectedIndex = index;
    widget.onChange(widget.availableTime[_selectedIndex]);
    setState(() {});
  }

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      sliver: SliverGrid(
          delegate: SliverChildBuilderDelegate(
              (context, int index) => GestureDetector(
                    onTap: () {
                      _onTap(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        gradient: _selectedIndex == index
                            ? AppGradients.blueGradient
                            : null,
                        color: _selectedIndex == index
                            ? null
                            : isLight
                                ? Colors.white
                                : ColorUtil.surfaceDark,
                      ),
                      child: Center(
                        child: Text(
                          widget.availableTime[index],
                          style: FontStyleUtilities.h5(
                                  fontWeight: FWT.regular,
                                  fontColor: _selectedIndex == index
                                      ? Colors.white
                                      : isLight
                                          ? Colors.black
                                          : Colors.white)
                              .copyWith(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
              childCount: widget.availableTime.length),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 3,
              crossAxisCount: 2,
              mainAxisSpacing: 21.w,
              crossAxisSpacing: 30.h)),
    );
  }
}

class DateWidget extends StatefulWidget {
  const DateWidget({
    Key? key,
    required this.onChanged,
  }) : super(key: key);
  final ValueChanged<DateTime> onChanged;
  @override
  State<DateWidget> createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {
  late DateTime _dateTime;

  @override
  void initState() {
    _dateTime = DateTime.now();
    super.initState();
  }

  String getFormattedString(DateTime time) {
    String day = DateFormat('dd').format(time);
    String month = DateFormat('MMMM').format(time);
    String year = DateFormat('yyyy').format(time);
    return '$day $month, $year';
  }

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(top: 0.h, bottom: 18.h),
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              color: isLight ? Colors.white : ColorUtil.surfaceDark),
          child: TableCalendar(
              headerStyle: HeaderStyle(
                  titleTextStyle: FontStyleUtilities.h4(
                      height: 1,
                      fontWeight: FWT.medium,
                      fontColor: isLight ? Colors.black : Colors.white)),
              daysOfWeekHeight: 24,
              daysOfWeekStyle: DaysOfWeekStyle(
                weekendStyle: FontStyleUtilities.t5(
                  fontWeight: FWT.medium,
                  fontColor: const Color(0xffAAAAAA),
                ),
                weekdayStyle: FontStyleUtilities.t5(
                        fontWeight: FWT.medium,
                        fontColor: const Color(0xffAAAAAA))
                    .copyWith(fontSize: 10.sp),
                dowTextFormatter: (date, locale) => DateFormat('EEEE')
                    .format(date)
                    .substring(0, 3)
                    .toUpperCase(),
              ),
              rowHeight: 45.h,
              calendarStyle: CalendarStyle(
                  cellPadding: EdgeInsets.zero,
                  cellMargin: const EdgeInsets.all(2.5),
                  outsideDaysVisible: false,
                  weekendTextStyle: FontStyleUtilities.h6(
                      fontWeight: FWT.medium,
                      fontColor: isLight
                          ? const Color(0xff222222)
                          : Colors.white.withOpacity(0.70)),
                  defaultTextStyle: FontStyleUtilities.h6(
                      fontWeight: FWT.medium,
                      fontColor: isLight
                          ? const Color(0xff222222)
                          : Colors.white.withOpacity(0.70)),
                  selectedDecoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: AppGradients.blueGradient),
                  todayDecoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor)),
              availableCalendarFormats: const {CalendarFormat.month: 'Month'},
              onDaySelected: (dateTime1, dateTime2) {
                _dateTime = dateTime2;
                widget.onChanged(_dateTime);
                setState(() {});
              },
              onCalendarCreated: (PageController controller) {},
              focusedDay: _dateTime,
              currentDay: _dateTime,
              firstDay: DateTime(2022),
              lastDay: DateTime(2100)),
        ),
        21.height(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Text(
            getFormattedString(_dateTime),
            style: FontStyleUtilities.h5(
                fontWeight: FWT.medium, fontColor: ColorUtil.primaryColor),
          ),
        ),
      ],
    );
  }
}
