import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:medix/Data/Core/api_client.dart'; // Your ApiClient import
import 'package:medix/Data/Model/Clinic/clinic_visit_card.dart';

import 'package:medix/Presentation/Screens/Consultation_flow/Consultation_doctors/select_doctor_consultation.dart';
import 'package:medix/Utils/utils.dart';
import 'package:stacked/stacked.dart';

import 'package:medix/Presentation/Widgets/widgets.dart';
import '../Shared/app_bar.dart' as bar;
import '../../Flow_widgets/clinic_card.dart';

import 'package:medix/Presentation/Screens/Consultation_flow/BookAppointment_consultation/book_appointment_consultation_view_model.dart';
import 'package:medix/Data/Fake_data/Clinic_visit/clinic_visits.dart';

class ConsultationBookAppointment extends StatefulWidget {
  const ConsultationBookAppointment({Key? key}) : super(key: key);

  @override
  State<ConsultationBookAppointment> createState() => _ConsultationBookAppointmentState();
}

class _ConsultationBookAppointmentState extends State<ConsultationBookAppointment> {
  List<Map<String, dynamic>> dataService = [];

  int _servicesId = 0;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final apiClient = ApiClient(http.Client());
    try {
      final response = await apiClient.get('auth/apps/provider/preferences');
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData is Map<String, dynamic>) {
          final data = responseData['data'];
          if (data is Map<String, dynamic>) {
         
            final specialties = data['specialties'];
            final services = data['services'];
            if (specialties is List) {
              setState(() {
                dataService = List<Map<String, dynamic>>.from(specialties);
              });
            } else {
              print("Expected 'specialties' to be a List, got: ${specialties.runtimeType}");
            }
          } else {
            print("Expected 'data' to be a Map, got: ${data.runtimeType}");
          }
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
                      // children: [
                      //   Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Text(
                      //         '24/7 Doctor Video\nConsultation',
                      //         style: FontStyleUtilities.h2(
                      //           height: 1.26,
                      //           fontWeight: FWT.medium,
                      //           fontColor: isLight ? Colors.black : Colors.white,
                      //         ),
                      //       ),
                      //       Text(
                      //         'Find the service you are ',
                      //         style: FontStyleUtilities.h6(
                      //           fontWeight: FWT.medium,
                      //           fontColor: isLight ? const Color(0xffB9B9B9) : Colors.white,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      //   const Spacer(),
                      //   Padding(
                      //     padding: EdgeInsets.only(bottom: 15.h),
                      //     child: IconWrapper(onTap: () {}, icon: 'assets/Icons/Search.svg'),
                      //   ),
                      // ],
                    ),
                  ),
                ),
                SliverSizedBox(height: 10.h),

                /// You can use the fetched dataService here or update your ViewModel accordingly.
                /// For example, if you want to display them in a list:
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final item = index < dataService.length ? dataService[index] : null;
                      if (item == null) return const SizedBox.shrink();


                    final clinicModel = ClinicVisitCardModel.fromMap(item);

                      return ClinicVisitCard(                       
                        selected: model.checkIfSelected(clinicModel),
                            onTap: () {
                              model.chooseClinic(clinicModel, index);
                            },
                        info: clinicModel,

                      );
                    },
                    childCount: dataService.length,
                  ),
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
                    if (model.selectedServiceId != null) {
                      NavigationUtil.to(
                        context,
                        ConsultationSelectDoctor(servicesId: model.selectedServiceId!),
                      );
                    } else {
                      // Optional: show warning if no clinic selected
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please select a Service first")),
                      );
                    }
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
