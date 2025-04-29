import 'package:flutter/material.dart';
import 'package:medix/Presentation/Constants/gradients.dart';
import 'package:medix/Presentation/Constants/shadows.dart';
import '../Home/Compo/end_drawer.dart';
import 'package:medix/Utils/utils.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';
import 'package:medix/Extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Shared/home_text_field.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchKey = GlobalKey<ScaffoldState>(debugLabel: 'SearchKey');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SearchBar(searchKey: searchKey),
        key: searchKey,
        endDrawer: const HomeFilter(),
        body: Column(
          children: [
            24.height(),
            const DoctorList(),
            const Spacer(),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Button(tittle: 'Search', onTap: () {})),
            28.height()
          ],
        ));
  }
}

class DoctorList extends StatelessWidget {
  const DoctorList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: isLight ? Colors.white : ColorUtil.surfaceDark,
          boxShadow: [AppShadows.shadow]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Doctors',
            style: FontStyleUtilities.h4(
              fontWeight: FWT.bold,
              fontColor: isLight ? Colors.black : Colors.white,
            ),
          ),
          10.height(),
          _sortedItem(illness: 'Psychiatric', count: 238, isLight: isLight),
          _sortedItem(
              illness: 'Psychiatric Symptoms', count: 120, isLight: isLight),
          _sortedItem(
              illness: 'Psychiatric Disorder', count: 45, isLight: isLight),
          _sortedItem(
              illness: 'Psychiatric Personality Disorder ',
              count: 60,
              isLight: isLight),
          _sortedItem(
              illness: 'Psychiatric Phobia', count: 86, isLight: isLight),
        ],
      ),
    );
  }

  Widget _sortedItem(
      {required String illness, required int count, required bool isLight}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          Text(
            illness,
            style: FontStyleUtilities.t2(
              fontWeight: FWT.semiBold,
              fontColor: isLight ? Colors.black : Colors.white,
            ),
          ),
          const Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            decoration: BoxDecoration(
                color: ColorUtil.primaryColor.withOpacity(.10),
                borderRadius: BorderRadius.circular(4.r)),
            height: 20.h,
            child: Text(
              '$count',
              style: FontStyleUtilities.t5(
                  fontWeight: FWT.medium, fontColor: ColorUtil.primaryColor),
            ),
          )
        ],
      ),
    );
  }
}

class SearchBar extends StatefulWidget implements PreferredSizeWidget {
  const SearchBar({
    Key? key,
    required this.searchKey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> searchKey;

  @override
  State<SearchBar> createState() => _SearchBarState();

  @override
  Size get preferredSize => Size.fromHeight(73.h);
}

class _SearchBarState extends State<SearchBar> {
  late TextEditingController _searchController;

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return AppBar(
      elevation: 0,
      toolbarHeight: 0,
      automaticallyImplyLeading: false,
      bottom: PreferredSize(
          preferredSize: Size.fromHeight(73.h),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Row(
              children: [
                Expanded(
                  child: HomeTextField(
                      controller: _searchController,
                      suffix: GestureDetector(
                        onTap: () {
                          _searchController.clear();
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          child: CircleAvatar(
                            radius: 6.r,
                            backgroundColor: isLight
                                ? const Color(0xffC4C4C4)
                                : ColorUtil.onLightSurface,
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 12.h,
                            ),
                          ),
                        ),
                      ),
                      prefix: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 15.h, horizontal: 11.42.w),
                          child: SvgIcon(
                            'assets/Icons/Search.svg',
                            color: isLight
                                ? Colors.black.withOpacity(.30)
                                : ColorUtil.onLightSurface,
                          )),
                      hint: 'Search'),
                ),
                SizedBox(width: 17.w),
                GestureDetector(
                  onTap: () {
                    widget.searchKey.currentState!.openEndDrawer();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    height: 48.h,
                    width: 48.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        gradient: AppGradients.blueGradient),
                    child: const SvgIcon('assets/Icons/Filter.svg'),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
