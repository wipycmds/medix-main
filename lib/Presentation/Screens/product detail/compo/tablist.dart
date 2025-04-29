import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medix/Presentation/Screens/product%20detail/compo/paragraph.dart';
import 'package:medix/Presentation/Screens/shopping/compo/textwrapper.dart';
import 'package:medix/Utils/color_utils.dart';
import 'package:medix/Utils/font_style.dart';

class TabList extends StatefulWidget {
  const TabList({
    Key? key,
    required this.controller,
    required this.onChanged,
  }) : super(key: key);

  final TabController controller;
  final ValueChanged<int> onChanged;

  @override
  State<TabList> createState() => _TabListState();
}

class _TabListState extends State<TabList> {
  // var myChildSize = Size.fromHeight(400.h);
  int currentIndex = 0;
  @override
  void initState() {
    widget.controller.addListener(() {
      if (widget.controller.indexIsChanging) {
        setState(() {
          currentIndex = widget.controller.index;
          changes();
        });
      }
    });
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {});
    super.initState();
  }

  void changes() {
    widget.onChanged(currentIndex);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List paragraph1 = [
      'You probably take vitamins and supplements with the goal of improving your health. That’s great news! Yet these products aren\'t always good for you -- or safe. And buying dietary supplements isn\'t as straightforward as looking for the most promising health claim on a label.',
      'Fortunately, you can arm yourself with some simple facts before you start taking supplements. Use this checklist as a guide to help you talk with your doctor. Bring it to the drug store or supermarket to help you choose a supplement that\'s safe, and that best fits your health needs.'
    ];
    var size2 = MediaQuery.of(context).size;
    var isLight = Theme.of(context).brightness == Brightness.light;
    return DefaultTabController(
      length: 3,
      child: Container(
        width: size2.width,
        height: 50.h,
        padding: EdgeInsets.only(left: 10.w),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 0.8,
                    color: isLight
                        ? Colors.grey.withOpacity(0.3)
                        : Colors.white12))),
        child: TabBar(
          controller: widget.controller,
          unselectedLabelColor: const Color.fromARGB(255, 178, 186, 198),
          labelColor: ColorUtil.primaryColor,
          onTap: (value) {
            setState(() {
              currentIndex = value;
              changes();
            });
          },
          labelStyle: FontStyleUtilities.h5(
              fontWeight: FWT.semiBold, fontColor: ColorUtil.primaryColor),
          unselectedLabelStyle: FontStyleUtilities.h5(
              fontWeight: FWT.semiBold, fontColor: ColorUtil.primaryColor),
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: ColorUtil.primaryColor,
          isScrollable: true,
          tabs: const [
            Text(
              'Detail',
            ),
            Text(
              'How to Use',
            ),
            Text(
              'Review',
            ),
          ],
        ),
      ),
    );
  }

  Column paragraphs(bool isLight) {
    return Column(children: [
      ...paragraph2.map((e) => TextWrapper(text: e, isLight: isLight))
    ]);
  }
}
