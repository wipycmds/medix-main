//
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medix/Data/Core/api_client.dart';
import 'package:medix/Data/Model/Home/doctor.dart';
import 'package:medix/Presentation/Screens/Consultation_flow/Consulatation_doctor_profile/consulation_doctor_profile.dart';
import 'package:medix/Utils/utils.dart';
//
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
//
import 'select_doctor_consultation_view_model.dart';
//
import '../Shared/app_bar.dart' as bar;
import 'package:medix/Presentation/Widgets/widgets.dart';
import '../../Flow_widgets/doctor_card.dart';
class ConsultationSelectDoctor extends StatefulWidget {
  const ConsultationSelectDoctor({Key? key}) : super(key: key);

  @override
  State<ConsultationSelectDoctor> createState() => _ConsultationSelectDoctorState();
}

class _ConsultationSelectDoctorState extends State<ConsultationSelectDoctor> {
   List<DoctorModel> doctors = []; 

  @override
  void initState() {
    super.initState();
    _fetchDoctors();
  }

 

Future<void> _fetchDoctors() async {
  final apiClient = ApiClient(http.Client());

  try {
    final response = await apiClient.get(
      'auth/apps/group/provider/'
    );


    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);

      if (responseData is Map<String, dynamic>) {
      
        final groupProvider = responseData['group'] ?? [];
 
        final List<DoctorModel> fetchedDoctors = List<DoctorModel>.from(
          groupProvider.map((item) {
            final provider = item['providers'] ?? {};
            final user = provider.map((providerItem) => providerItem['user'] ?? {}).toList();

            final fname = user.map((userItem) => userItem['fname'] ?? '').join(', ');
            final mname = user.map((userItem) => userItem['lname'] ?? '').join(', ');
            final lname = user.map((userItem) => userItem['lname'] ?? '').join(', ');
            final name = '$fname $mname $lname';
            return DoctorModel(
              id: item["id"] ?? 0,
              name: item["name"] ?? name,
              image: '',
              degree: '',
              specialty:  '',
              // specialization: '',
              about:  '',
              patient: 1000,
              averageRating: 4.5,
              reviews: 100,
              experience: 5,
            );
          }),
        );

        setState(() {
          doctors = fetchedDoctors;
        });
      }
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
    var isLight = Theme.of(context).brightness == Brightness.light;
    return ViewModelBuilder<ConsultationSelectDoctorViewModel>.reactive(
      viewModelBuilder: () => ConsultationSelectDoctorViewModel(),
      builder: (context, model, child) => Scaffold(
          body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              const bar.ConsultationAppBar(
                step: bar.ConsultationStep.doctor,
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: 24.h),
              ),
              SliverToBoxAdapter(
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Find your Doctor',
                              style: FontStyleUtilities.h2(
                                  fontWeight: FWT.medium,
                                  fontColor:
                                      isLight ? Colors.black : Colors.white),
                            ),
                            Text(
                              'Find the service you are ',
                              style: FontStyleUtilities.h6(
                                  fontWeight: FWT.medium,
                                  fontColor: const Color(0xffB9B9B9)),
                            ),
                          ],
                        ),
                        const Spacer(),
                        IconWrapper(
                            onTap: () {}, icon: 'assets/Icons/Search.svg'),
                      ]))),
              SliverSizedBox(height: 10.h),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => DoctorCard(
                    selected: model.checkIfSelected(doctors[index]),
                    onTap: () {
                      model.chooseDoctor(doctors[index], index);
                    },
                    info: doctors[index],
                  ),
                  childCount: doctors.length,
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
                  final selectedDoctor = model.selectedDoctor;
                  if (selectedDoctor != null) {
                   
                    NavigationUtil.to(
                      context,
                      ConsultationDoctorProfile(doctor: selectedDoctor),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select a doctor.'),
                      ),
                    );
                  }
                },
              ),
            ),
          ),

        ],
      )),
    );
  }
}