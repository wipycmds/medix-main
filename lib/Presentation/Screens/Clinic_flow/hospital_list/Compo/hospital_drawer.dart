import 'package:flutter/material.dart';
import 'package:medix/Utils/utils.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';
import 'package:medix/Extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medix/package/packages.dart';

class HospitalDrawer extends StatefulWidget {
  const HospitalDrawer({Key? key}) : super(key: key);

  @override
  State<HospitalDrawer> createState() => _HospitalDrawerState();
}

class _HospitalDrawerState extends State<HospitalDrawer> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 327.w,
        child: Drawer(
          child: ListView(
            controller: scrollController,
            children: [
              8.height(),
              const CityFilter(),
              20.height(),
              Divider(
                height: 2.h,
                thickness: 2.h,
                color: const Color(0xffC7C7C7).withOpacity(.15),
              ),
              27.height(),
              const DistanceFilter(),
              10.height(),
              Divider(
                height: 2.h,
                thickness: 2.h,
                color: const Color(0xffC7C7C7).withOpacity(.15),
              ),
              35.height(),
              PriceFilter(scrollController: scrollController),
              // Padding(
              //     padding: EdgeInsets.only(
              //         bottom: MediaQuery.of(context).viewInsets.bottom))
            ],
          ),
        ));
  }
}

class PriceFilter extends StatefulWidget {
  const PriceFilter({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  final ScrollController scrollController;
  @override
  State<PriceFilter> createState() => _PriceFilterState();
}

class _PriceFilterState extends State<PriceFilter> {
  TextEditingController minController = TextEditingController(text: '0');
  TextEditingController maxController = TextEditingController(text: '100');
  late FilterController<String> _priceFilterController;

  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();

  String val = '';

  @override
  void initState() {
    focusNode1.addListener(() {
      scrollDown();
    });
    minController = TextEditingController(
        text: values[_selectedIndex].keys.toList()[0].toString());
    maxController = TextEditingController(
        text: values[_selectedIndex][values[_selectedIndex].keys.toList()[0]]
            .toString());
    _priceFilterController = FilterController<String>();
    super.initState();
  }

  int _selectedIndex = 0;
  void setIndex(int index) {
    _selectedIndex = index;

    setState(() {
      minController.text = values[_selectedIndex].keys.toList()[0].toString();
      maxController.text = values[_selectedIndex]
              [values[_selectedIndex].keys.toList()[0]]
          .toString();
    });
  }

  List<Map<int, int>> values = [
    {0: 100},
    {100: 200},
    {200: 300},
    {300: 400},
  ];

  void scrollDown() {
    widget.scrollController.animateTo(
        widget.scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: 24.w,
          bottom: MediaQuery.of(context).viewInsets.bottom,
          right: 24.w),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: PriceMinMaxWrapper(
                tittle: 'Min.',
                controller: minController,
                focusNode: focusNode1,
                onChanged: (value) {
                  minController.text;
                  setState(() {});
                },
                value: values[_selectedIndex].keys.toList()[0].toString(),
              )),
              18.width(),
              Expanded(
                  child: GestureDetector(
                onTap: () {},
                child: PriceMinMaxWrapper(
                    focusNode: focusNode2,
                    tittle: 'Max.',
                    controller: maxController,
                    onChanged: (value) {
                      maxController.text;
                      setState(() {});
                    },
                    value: values[_selectedIndex]
                            [values[_selectedIndex].keys.toList()[0]]
                        .toString()),
              )),
            ],
          ),
          8.height(),
          FilterWrapper(
            radio: true,
            filterList: const [
              '\$0-\$100',
              '\$100-\$200',
              '\$200-\$300',
              '\$300-\$500',
            ],
            filterController: _priceFilterController,
            onTap: setIndex,
          )
        ],
      ),
    );
  }
}

class PriceMinMaxWrapper extends StatelessWidget {
  const PriceMinMaxWrapper(
      {Key? key,
      required this.tittle,
      required this.controller,
      required this.onChanged,
      required this.focusNode,
      required this.value})
      : super(key: key);
  final String tittle, value;
  final ValueChanged onChanged;
  final FocusNode focusNode;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tittle,
          style: FontStyleUtilities.h5(
            fontWeight: FWT.medium,
            fontColor: isLight ? Colors.black : Colors.white.withOpacity(0.80),
          ).copyWith(fontSize: 18.sp),
        ),
        8.height(),
        TextFormField(
            controller: controller,
            focusNode: focusNode,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                fillColor: Colors.transparent,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 2.0,
                    color: const Color(0xffC7C7C7).withOpacity(.15),
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 2.0,
                    color: const Color(0xffC7C7C7).withOpacity(.15),
                  ),
                ),
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 2.0,
                    color: const Color(0xffC7C7C7).withOpacity(.15),
                  ),
                )),
            onChanged: onChanged,
            style: FontStyleUtilities.h5(
              fontWeight: FWT.medium,
              fontColor:
                  isLight ? Colors.black : Colors.white.withOpacity(0.80),
            ).copyWith(fontSize: 18.sp)),
        10.height(),
      ],
    );
  }
}

class CityFilter extends StatefulWidget {
  const CityFilter({
    Key? key,
  }) : super(key: key);

  @override
  State<CityFilter> createState() => _CityFilterState();
}

class _CityFilterState extends State<CityFilter> {
  late FilterController<String> filterController;
  @override
  void initState() {
    filterController = FilterController<String>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(TextSpan(children: [
                TextSpan(
                  text: 'Filter ',
                  style: FontStyleUtilities.h2(
                          fontWeight: FWT.medium,
                          fontColor: isLight ? Colors.black : Colors.white)
                      .copyWith(fontSize: 28.sp),
                ),
                TextSpan(
                  text: '(Hospital)',
                  style: FontStyleUtilities.h2(
                          fontWeight: FWT.medium,
                          fontColor:
                              isLight ? const Color(0xffc7c7c7) : Colors.white)
                      .copyWith(fontSize: 28.sp),
                ),
              ])),
              IconWrapper(
                onTap: () {
                  Navigator.pop(context);
                },
                icon: 'assets/Icons/close.svg',
                padding: 12.h,
              ),
            ],
          ),
          27.height(),
          FilterWrapper(
            filterList: const [
              'New York',
              'Michigan',
              'California',
              'Ohio',
              'Florida',
              'Oregon'
            ],
            filterController: filterController,
            onTap: (int index) {},
          ),
          21.height(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'View all',
                style: FontStyleUtilities.h4(
                    fontWeight: FWT.medium,
                    height: 0,
                    fontColor:
                        isLight ? Colors.black : Colors.white.withOpacity(0.8)),
              ),
              8.width(),
              Transform.scale(
                scale: 1.5,
                child: RotatedBox(
                  quarterTurns: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: SvgIcon(
                      'assets/Icons/arrow_right.svg',
                      color: isLight ? Colors.black : Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class DistanceFilter extends StatefulWidget {
  const DistanceFilter({
    Key? key,
  }) : super(key: key);

  @override
  State<DistanceFilter> createState() => _DistanceFilterState();
}

class _DistanceFilterState extends State<DistanceFilter> {
  late FilterController<String> distanceController;
  @override
  void initState() {
    distanceController = FilterController<String>();
    super.initState();
  }

  void _setValueFromSlider(double sliderValue) {
    value = sliderValue;
    setState(() {});
  }

  double value = 25;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '${value.toInt()} km',
                style: FontStyleUtilities.h4(
                    fontWeight: FWT.medium, fontColor: ColorUtil.primaryColor),
              ),
            ],
          ),
        ),
        8.height(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child:
              SliderWrapper(onChanged: _setValueFromSlider, hightestValue: 50),
        ),
        20.height(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: FilterWrapper(
            filterList: const ['Florida', 'Oregon', 'Chicago', 'Beijing'],
            filterController: distanceController,
            onTap: (int index) {},
          ),
        )
      ],
    );
  }
}

class SliderWrapper extends StatefulWidget {
  const SliderWrapper(
      {Key? key, required this.onChanged, required this.hightestValue})
      : super(key: key);
  final ValueChanged<double> onChanged;
  final double hightestValue;

  @override
  _SliderWrapperState createState() => _SliderWrapperState();
}

class _SliderWrapperState extends State<SliderWrapper> {
  double value = .5;
  void _onChanged(double newValue) {
    value = newValue;
    widget.onChanged(value * widget.hightestValue);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: value,
      thumbColor: ColorUtil.primaryColor,
      activeColor: ColorUtil.primaryColor,
      inactiveColor: ColorUtil.primaryColor.withOpacity(0.7),
      onChanged: _onChanged,
    );
  }
}
