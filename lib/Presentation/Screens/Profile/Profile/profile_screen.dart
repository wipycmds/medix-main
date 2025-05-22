import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medix/Data/Core/api_client.dart';
import 'package:medix/Presentation/Constants/shadows.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../EditProfile/edit_profile.dart';
import 'package:medix/Utils/utils.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';
import 'package:medix/Extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Shared/illness_tag.dart';
class ProfileScreen extends StatefulWidget {

const ProfileScreen({Key? key}) : super(key: key);

 @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  String? loginId;

Map<String, dynamic> profile = {};




  @override
  void initState() {
    super.initState();
     fetchPatienProfile();
     loadLoginId(); 
  }

  Future<void> loadLoginId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      loginId = prefs.getString('login_id');
    });
  }

  Future<void> fetchPatienProfile() async {
    final apiClient = ApiClient(http.Client());

    var patientId = {
      'id': loginId
    };
    

    try {
      final response = await apiClient.post('auth/patient/profile/', params: patientId);

      if (response.statusCode == 200) {
        final patientProfile = jsonDecode(response.body) as Map<String, dynamic>;
      

      setState(() {
        profile = patientProfile['patient'];
      });
          
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.body}')),
        );
      }
    } catch (e) {
      print("Error occurred: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred. Please try again later.')),
      );
    } finally {
      apiClient.client.close();
    }
  }

  @override
  Widget build(BuildContext context) { 
    print('profile: $profile');
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            pinned: true,
            elevation: 4,
            leading: MyBackButton(),
            title: Text('My Profile'),
          ),
          const SliverSizedBox(
            // child: ProfileHeader(),
          ),
           SliverSizedBox(child: ProfileHeader(profile: profile)),

          SliverSizedBox(height: 24.h),
          // const SliverSizedBox(child: PersonalInfo()),
          SliverSizedBox(child: PersonalInfo(profile: profile)),

          SliverSizedBox(height: 24.h),
        ],
      ),
    );
  }
}
  



class PersonalInfo extends StatelessWidget {
 final Map<String, dynamic> profile;
  const PersonalInfo({Key? key, required this.profile}) : super(key: key);

  Widget _buildData(
      {required String param, required String value, required bool isLight}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          param,
          style: FontStyleUtilities.t1(
              fontWeight: FWT.medium,
              height: 1,
              fontColor:
                  isLight ? Colors.black : Colors.white.withOpacity(0.80)),
        ),
        2.height(),
        Text(
          value,
          style: FontStyleUtilities.t2(
              fontWeight: FWT.bold,
              fontColor:
                  isLight ? Colors.black : Colors.white.withOpacity(0.80)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: isLight ? Colors.white : ColorUtil.surfaceDark,
          boxShadow: [AppShadows.shadow]),
      padding: EdgeInsets.symmetric(
        vertical: 16.h,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Personal Info',
                      style: FontStyleUtilities.h4(
                          fontWeight: FWT.bold,
                          fontColor: isLight ? Colors.black : Colors.white),
                    ),
                    const Spacer(),
                    CustomOutlinedButton(text: 'Change', onTap: () {})
                  ],
                ),
                10.height(),
                // _buildData(param: 'Phone Number', value: profile['mobile_no'] ?? '', isLight: isLight),
                // _buildData(param: 'Gender', value: profile['gender'] ?? '', isLight: isLight),
                // _buildData(param: 'Date Of Birth', value: profile['dob'] ?? '', isLight: isLight),

                _buildData(
                    param: 'Phone Number',
                    value: profile['mobile_number'] ?? '',
                    isLight: isLight),
                14.height(),
                _buildData(
                    param: 'Email', value: profile['email'] ?? '', isLight: isLight),
                14.height(),
                _buildData(param: 'Gender', value: profile['gender'] ?? '', isLight: isLight),
                14.height(),
                _buildData(
                    param: 'Date Of Birth',
                    value: profile['dob'] ?? '',
                    isLight: isLight),
                14.height(),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Medical Info',
                      style: FontStyleUtilities.h4(
                          fontWeight: FWT.bold,
                          fontColor: isLight ? Colors.black : Colors.white),
                    ),
                    const Spacer(),
                    CustomOutlinedButton(text: 'Change', onTap: () {})
                  ],
                ),
                10.height(),
                Text(
                  'Illness',
                  style: FontStyleUtilities.t1(
                      fontWeight: FWT.medium,
                      height: 1,
                      fontColor: isLight
                          ? Colors.black
                          : Colors.white.withOpacity(0.80)),
                ),
                8.height(),
                Wrap(
                  spacing: 6.w,
                  runSpacing: 8.w,
                  children: [
                    'Migraine',
                    'Asthma',
                    'Low Blood Sugar',
                    'Diabetes',
                    'Kidney Stone',
                  ].map((e) => IllnessTag(value: e)).toList(),
                ),
                14.height(),
                _buildData(
                    param: 'Medical Record',
                    value: 'Med_report.pdf',
                    isLight: isLight),
                14.height(),
                _buildData(
                    param: 'Emergency Contact',
                    value: profile['emergency_contact_number'] ?? '',
                    isLight: isLight),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton(
      {Key? key, required this.text, required this.onTap})
      : super(key: key);
  final String text;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 32.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(
            color: ColorUtil.primaryColor,
          )),
      child: Text(
        text,
        style: FontStyleUtilities.t2(
            fontWeight: FWT.medium,
            fontColor: ColorUtil.primaryColor,
            height: 1),
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  final Map<String, dynamic> profile;
  const ProfileHeader({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Column(
      children: [
        24.height(),

        ///IMAGE
        Hero(
          tag: 'Profile Hero',
          child: CircleAvatar(
            radius: 30.r,
            backgroundImage: const AssetImage('assets/Images/Temp/profile.png'),
            backgroundColor: ColorUtil.primaryColor.withOpacity(.20),
          ),
        ),
        20.height(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ///NAME
            Text(
              '${profile['first_name']} ${profile['middle_name']} ${profile['last_name']}',
              style: FontStyleUtilities.h3(
                  fontWeight: FWT.bold,
                  fontColor: isLight ? Colors.black : Colors.white),
            ),
            10.width(),

            ///EDIT ICON
            GestureDetector(
              onTap: () {
                NavigationUtil.to(context, const EditProfile());
              },
              child: SizedBox.square(
                dimension: 35.h,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.r),
                      color: isLight ? Colors.white : ColorUtil.surfaceDark,
                      boxShadow: [AppShadows.shadow]),
                  child: const Icon(
                    Icons.edit_outlined,
                    color: ColorUtil.primaryColor,
                  ),
                ),
              ),
            )
          ],
        ),
        10.height(),

        ///EDIT LOCATION
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     const Icon(
        //       CupertinoIcons.location,
        //       color: ColorUtil.primaryColor,
        //     ),
        //     6.width(),
        //     Text(
        //       'LONDON',
        //       style: FontStyleUtilities.t1(
        //           fontWeight: FWT.bold,
        //           height: 1.5,
        //           fontColor: isLight ? Colors.black : Colors.white),
        //     ),
        //   ],
        // ),
        // 20.height(),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     _buildProfileData(
        //         isLight: isLight,
        //         icon: CupertinoIcons.news,
        //         count: '2,346',
        //         param: 'Appointments'),
        //     20.width(),
        //     _buildProfileData(
        //         isLight: isLight,
        //         icon: CupertinoIcons.creditcard,
        //         count: r'$250',
        //         param: 'Total Spending'),
        //   ],
        // )
      ],
    );
  }

  Widget _buildProfileData(
      {required IconData icon,
      required String count,
      required String param,
      required bool isLight}) {
    return Column(
      children: [
        Icon(icon),
        Text(
          count,
          style: FontStyleUtilities.h4(
              fontWeight: FWT.bold,
              fontColor: isLight ? Colors.black : Colors.white),
        ),
        Text(
          param,
          style: FontStyleUtilities.t4(
              fontWeight: FWT.medium,
              fontColor: isLight
                  ? ColorUtil.lightTextColor
                  : Colors.white.withOpacity(0.70)),
        ),
      ],
    );
  }
}
