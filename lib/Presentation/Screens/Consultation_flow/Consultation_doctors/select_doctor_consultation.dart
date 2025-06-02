//
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medix/Data/Core/api_client.dart';
import 'package:medix/Data/Model/Home/doctor.dart';
import 'package:medix/Presentation/Screens/Clinic_flow/Select_doctor/doctor_list.dart';
import 'package:medix/Presentation/Screens/Consultation_flow/Consulatation_doctor_profile/consulation_doctor_profile.dart';
import 'package:medix/Utils/utils.dart';
//
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medix/package/filter_controller.dart';
import 'package:stacked/stacked.dart';
//
import 'select_doctor_consultation_view_model.dart';
//
import '../Shared/app_bar.dart' as bar;
import 'package:medix/Presentation/Widgets/widgets.dart';
import '../../Flow_widgets/doctor_card.dart';

class ConsultationSelectDoctor extends StatefulWidget {
  final int servicesId;
  final String tag;

  const ConsultationSelectDoctor({
    Key? key,
    required this.servicesId,
    required this.tag,
  }) : super(key: key);

  @override
  State<ConsultationSelectDoctor> createState() => _ConsultationSelectDoctorState();
}

class _ConsultationSelectDoctorState extends State<ConsultationSelectDoctor> with SingleTickerProviderStateMixin {
  List<DoctorModel> doctors = [];
  int selectedId = 0;
  late TabController _tabController;

@override
void initState() {
  _fetchClinic();
  super.initState();
  _tabController = TabController(length: 2, vsync: this);

  // Listener to detect tab changes
  _tabController.addListener(() {
    if (!_tabController.indexIsChanging) {
      final selectedIndex = _tabController.index;

      if (selectedIndex == 0) {
        _fetchClinic();
      } else if (selectedIndex == 1) {
        
      }
    }
  });
}


  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _fetchClinic() async { 
    final apiClient = ApiClient(http.Client());
    final groupId = {'group_id': widget.servicesId};

    try {
      final response = await apiClient.post('get-group-clinic/', params: groupId);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
     
        final clinic = responseData['clinics'] ?? [];
  
        final List<DoctorModel> _fetchClinic = List<DoctorModel>.from(
          clinic.map((item) {
          
            return DoctorModel(
              id: item['id'] ?? 0,
              groupId: item['group_id'] ?? 0,
              clinicId: item['id'] ?? 0,
              clinicName: item['name'] ?? '',
              clinicAddress:'',
              name: item['name'] ?? '',
              image: item['image_uri'] ?? '',
              specialty: '',
              degree: item['certification'] ?? 'Unknown',
              about: item['description'] ?? '',
              patient: 1000,
              averageRating: 4.5,
              reviews: 100,
              experience: 5,
            );
          }),
        );

        setState(() {
          doctors = _fetchClinic;
        });
        

      }
    } catch (e) {
      print('Error fetching clinics: $e');
    } 
  }

  Future<void> _fetchDoctors() async {
    final apiClient = ApiClient(http.Client());
    final groupId = {'group_id': widget.servicesId};

    try {
      final response = await apiClient.post('auth/apps/fetch/provider/', params: groupId);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final provider = responseData['doctor'] ?? [];

        final List<DoctorModel> fetchedDoctors = List<DoctorModel>.from(
          provider.map((item) {
            final user = item['user'] ?? {};
            final fullName = [
              item['salutation'] ?? '',
              user['fname'] ?? '',
              user['mname'] ?? '',
              user['lname'] ?? '',
            ].where((part) => part.toString().isNotEmpty).join(' ').trim();

            return DoctorModel(
              id: user['id'] ?? 0,
              groupId: item['group_id'] ?? 0,
              clinicId: item['clinic'][0]['id'] ?? 0,
              clinicName: item['clinic'][0]['name'] ?? '',
              clinicAddress: [
                item['clinic'][0]['street'] ?? '',
                item['clinic'][0]['city'] ?? '',
                item['clinic'][0]['province'] ?? '',
                item['clinic'][0]['country'] ?? '',
                item['clinic'][0]['zip'] ?? '',
              ].where((part) => part.isNotEmpty).join(', '),
              name: fullName,
              image: user['avatar_url'] ?? '',
              specialty: item['provider_specialties'][0]['specialty']['name'],
              degree: item['certification'] ?? 'Unknown',
              about: item['description'] ?? '',
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
      } else {
        _showErrorSnackBar('Failed to load data.');
      }
    } catch (_) {
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
      builder: (context, model, child) {
        return Scaffold(
          body: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  const bar.ConsultationAppBar(step: bar.ConsultationStep.doctor),
                  SliverToBoxAdapter(child: SizedBox(height: 4.h)),

                  SliverToBoxAdapter(
                    child: Container(
                      padding: EdgeInsets.all(4.h),
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      decoration: BoxDecoration(
                        color: isLight ? const Color(0xffF4F4F4) : ColorUtil.surfaceDark,
                        borderRadius: BorderRadius.circular(27.5.r),
                      ),
                      child: TabBar(
                        controller: _tabController,
                        labelColor: isLight ? Colors.black : Colors.white,
                        unselectedLabelColor: const Color(0xffA6a6a6),
                        labelStyle: FontStyleUtilities.h6(
                          fontWeight: FWT.medium,
                          fontColor: isLight ? Colors.black : Colors.white,
                        ),
                        indicator: BoxDecoration(
                          color: isLight ? Colors.white : ColorUtil.scaffoldDark,
                          borderRadius: BorderRadius.circular(60.5.r),
                        ),
                        tabs: const [
                          Tab(text: 'Clinic Visit'),
                          Tab(text: 'Virtual Visit'),
                        ],
                      ),
                    ),
                  ),

                  SliverToBoxAdapter(child: SizedBox(height: 10.h)),

                  // if (widget.tag == 'Group')
                  //   SliverToBoxAdapter(
                  //     child: Padding(
                  //       padding: EdgeInsets.symmetric(horizontal: 16.w),
                  //       child: MyOutlinedButton(
                  //         style: FontStyleUtilities.h4(
                  //           height: 1,
                  //           fontWeight: FWT.medium,
                  //           fontColor: ColorUtil.primaryColor,
                  //         ),
                  //         leading: Padding(
                  //           padding: EdgeInsets.only(right: 9.23.w),
                  //           child: const SvgIcon(
                  //             'assets/Icons/specific.svg',
                  //             color: ColorUtil.primaryColor,
                  //           ),
                  //         ),
                  //         tittle: 'Book a Specific Doctor',
                  //         onTap: _fetchDoctors,
                  //       ),
                  //     ),
                  //   ),

                  SliverToBoxAdapter(child: SizedBox(height: 10.h)),

                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => DoctorCard(
                        selected: model.checkIfSelected(doctors[index]),
                        onTap: () => model.chooseDoctor(doctors[index], index),
                        info: doctors[index],
                      ),
                      childCount: doctors.length,
                    ),
                  ),

                  SliverToBoxAdapter(child: SizedBox(height: 115.h)),
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
                        // NavigationUtil.to(
                        //   context,
                        //   ConsultationDoctorProfile(doctor: selectedDoctor),
                        // );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please select a doctor.')),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

