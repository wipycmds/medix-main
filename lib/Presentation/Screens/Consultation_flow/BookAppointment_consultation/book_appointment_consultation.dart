import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:medix/Data/Core/api_client.dart';
import 'package:medix/Data/Fake_data/Clinic_visit/clinic_visit.dart';
import 'package:medix/Presentation/Screens/Clinic_flow/clinic_visit/clinic_vist.dart';
import 'package:medix/Presentation/Screens/Flow_widgets/clinic_card.dart'; 
import 'package:stacked/stacked.dart';

import 'package:medix/Presentation/Widgets/widgets.dart';
import '../Shared/app_bar.dart' as bar;

import 'package:medix/Presentation/Screens/Consultation_flow/BookAppointment_consultation/book_appointment_consultation_view_model.dart';

class ConsultationBookAppointment extends StatefulWidget {
  const ConsultationBookAppointment({Key? key}) : super(key: key);

  @override
  State<ConsultationBookAppointment> createState() => _ConsultationBookAppointmentState();
}

class _ConsultationBookAppointmentState extends State<ConsultationBookAppointment> {
  List<Map<String, dynamic>> dataService = [];

  final int _servicesId = 0;

  @override
  void initState() {
    super.initState();
    _fetchGroups();
  }

  Future<void> _fetchGroups() async {
    final apiClient = ApiClient(http.Client());

    try {
      final response = await apiClient.get('auth/apps/provider/group');
     
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final groupList = responseData['group'];
        if (groupList is List) {
          final normalizedList = <Map<String, dynamic>>[];

          var groupCount = <int, int>{};

          for (final group in groupList) {
            final groupId = group['id'];
            final groupName = group['name'];
            final providers = group['providers'] as List<dynamic>? ?? [];

            for (final provider in providers) {
              final providerGroupId = provider['group_id'];

              if (groupId == providerGroupId) {
                // print(groupCount[groupId] ?? 0); // Print the count for each groupId)
                groupCount[groupId] = (groupCount[groupId] ?? 0) + 1;

              }
            }
          }

          for (final group in groupList) {
            final groupId = group['id'];
            final groupName = group['name'];
            final providers = group['providers'] as List<dynamic>? ?? [];

            for (final provider in providers) {
              final providerGroupId = provider['group_id'];
              final user = provider['user'] ?? {};

              String displayName;

              if (groupId == providerGroupId) {
                final fname = user['fname'] ?? '';
                final mname = user['mname'] ?? '';
                final lname = user['lname'] ?? '';
                displayName = "$fname $mname $lname".trim();
                normalizedList.add({
                  'id': groupId,
                  'name': displayName,
                  'tag': 'Personal',
                  'count': groupCount[groupId] ?? 0,
                });
              } else {
                displayName = groupName ?? 'Unnamed Group';
                normalizedList.add({
                  'id': groupId,
                  'name': displayName,
                  'tag': 'Group',
                  'count': groupCount[groupId] ?? 0,
                });
              }
            }
          }

          setState(() {
            dataService = normalizedList;
          });
        } else {
          print("Expected 'group' to be a List, got: ${groupList.runtimeType}");
        }
      } else {
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }




  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;

    return ViewModelBuilder<ConsulTationAppointmentViewModel>.reactive(
      viewModelBuilder: () => ConsulTationAppointmentViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Stack(
          children: [
            CustomScrollView(
              slivers: [
                const bar.ConsultationAppBar(step: bar.ConsultationStep.service),
                SliverToBoxAdapter(child: SizedBox(height: 24.h)),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(
                            //   '24/7 Doctor Video\nConsultation',
                            //   style: FontStyleUtilities.h2(
                            //     height: 1.26,
                            //     fontWeight: FWT.medium,
                            //     fontColor: isLight ? Colors.black : Colors.white,
                            //   ),
                            // ),
                            // Text(
                            //   'Find the service you are ',
                            //   style: FontStyleUtilities.h6(
                            //     fontWeight: FWT.medium,
                            //     fontColor: isLight ? const Color(0xffB9B9B9) : Colors.white,
                            //   ),
                            // ),
                          ],
                        ),
                        // const Spacer(),
                        // Padding(
                        //   padding: EdgeInsets.only(bottom: 15.h),
                        //   child: IconWrapper(onTap: () {}, icon: 'assets/Icons/Search.svg'),
                        // ),
                      ],
                    ),
                  ),
                ),
                SliverSizedBox(height: 5.h),

                /// You can use the fetched dataService here or update your ViewModel accordingly.
                /// For example, if you want to display them in a list:
                // SliverList(
                //   delegate: SliverChildBuilderDelegate(
                //     (context, index) {
                //       final item = index < dataService.length ? dataService[index] : null;
                //       if (item == null) return const SizedBox.shrink();


                //     final clinicModel = ClinicVisitCardModel.fromMap(item);

                //       return ClinicVisitCard(                       
                //         selected: model.checkIfSelected(clinicModel),
                //             onTap: () {
                //               model.chooseClinic(clinicModel, index);
                //             },
                //         info: clinicModel,

                //       );
                //     },
                //     childCount: dataService.length,
                //   ),
                // ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => ClinicVisitCard(
                      selected: model.checkIfSelected(clinics[index]),
                      onTap: (){
                        model.chooseClinic(clinics[index]);
                      },
                      info: clinics[index],
                    ),
                    childCount: clinics.length,
                  )
                ),
                SliverSizedBox(height: 115.h),
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
                    // if (model.selectedServiceId != null) {
                    //   // if (model.selectedTag == 'Personal') {
                    //   //    NavigationUtil.to(
                    //   //   context,
                    //   //   ConsultationDoctorProfile(doctor: model.selectedServiceId),
                    //   // );
                    //   // }
                    //   NavigationUtil.to(
                    //     context,
                    //     ConsultationSelectDoctor(servicesId: model.selectedServiceId!, tag: model.selectedTag!,),
                    //   );
                    // } else {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     SnackBar(content: Text("Please select a Service first")),
                    //   );
                    // }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
