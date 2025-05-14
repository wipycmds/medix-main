import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medix/Data/Core/api_client.dart';
import 'package:medix/Presentation/Screens/Consultation_flow/Consulatation_doctor_profile/consulation_doctor_profile.dart';
import 'package:medix/Presentation/Screens/Consultation_flow/Consultation_doctors/doctor_model.dart';
import 'package:medix/Utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';

import '../Shared/app_bar.dart' as bar;
import 'package:medix/Presentation/Widgets/widgets.dart';
import 'select_doctor_consultation_view_model.dart';



class ConsultationSelectDoctor extends StatefulWidget {
  final int providerId;

  const ConsultationSelectDoctor({Key? key, required this.providerId}) : super(key: key);

  @override
  State<ConsultationSelectDoctor> createState() => _ConsultationSelectDoctorState();
}

class _ConsultationSelectDoctorState extends State<ConsultationSelectDoctor> {
  final List<Doctor> _doctors = [];

  

  @override
  void initState() {
    super.initState();
    _fetchDoctors();
  }

  Future<void> _fetchDoctors() async {
    final apiClient = ApiClient(http.Client());

    var providerId = {
      'id': widget.providerId
    };
    List<Doctor> doctors = [];
    try {
      final response = await apiClient.post('auth/apps/fetch/provider/', params: providerId);
  
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);      
        final providerData = responseData['providers'] ?? []; 
        // final doctors = providerData[0]['user'];
    // print(providerData);
        // for (var provider in providerData) {
        //   print(provider['user']);
        //   // List<DoctorModel> doctors =provider;
        // }  

        // for (var provider in providerData) {
        //   final doctor = Doctor.fromJson(provider);
        // }
        setState(() {
          // _doctors = doctors.map<Doctor>((e) => DoctorModel.fromJson(e)).toList();
        });
        
      } else {
        _showErrorSnackBar('Failed to load data.');
      }
    } catch (e) {
      _showErrorSnackBar('An error occurred.');
    } finally {
      apiClient.client.close();
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    return ViewModelBuilder<ConsultationSelectDoctorViewModel>.reactive(
      viewModelBuilder: () => ConsultationSelectDoctorViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Stack(
          children: [
            CustomScrollView(
              slivers: [
                const bar.ConsultationAppBar(step: bar.ConsultationStep.doctor),
                SliverToBoxAdapter(child: SizedBox(height: 24.h)),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Find your Doctor',
                              style: FontStyleUtilities.h2(
                                fontWeight: FWT.medium,
                                fontColor: isLight ? Colors.black : Colors.white,
                              ),
                            ),
                            Text(
                              'Find the service you are ',
                              style: FontStyleUtilities.h6(
                                fontWeight: FWT.medium,
                                fontColor: const Color(0xffB9B9B9),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        IconWrapper(onTap: () {}, icon: 'assets/Icons/Search.svg'),
                      ],
                    ),
                  ),
                ),
                SliverSizedBox(height: 10.h),
                // SliverList(
                //   delegate: SliverChildBuilderDelegate(
                //       (context, index) => DoctorCard(
                //             selected: model.checkIfSelected(doctors[index]),
                //             onTap: () {
                //               model.chooseClinic(doctors[index]);
                //             },
                //             info: doctors[index],
                //           ),
                //       childCount: clinics.length)),
              SliverSizedBox(height: 115.h)
                // SliverList(
                //   delegate: SliverChildBuilderDelegate(
                //     (context, index) {
                //        final practice = _doctors[index];
                //       return DoctorCard(
                //         info: doctors[index],
                //         onTap: () {
                //           // handle doctor selection here
                //           print('Tapped on doctor: ${practice.name}');
                //         },
                //         selected: false, // or true if selected based on logic
                //       );
                //     },
                //     childCount: _doctors.length,
                //   ),
                // ),
                // SliverSizedBox(height: 115.h),
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
                    NavigationUtil.to(context, const ConsultationDoctorProfile());
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
