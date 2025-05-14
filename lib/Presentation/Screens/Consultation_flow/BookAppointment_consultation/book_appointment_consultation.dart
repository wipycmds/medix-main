import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:medix/Data/Core/api_client.dart';
import 'package:medix/Presentation/Screens/Consultation_flow/BookAppointment_consultation/choose_service_card.dart';
import 'package:medix/Utils/font_style.dart';
import 'package:stacked/stacked.dart';

import 'package:medix/Presentation/Widgets/widgets.dart';
import '../Shared/app_bar.dart' as bar;
import 'package:medix/Presentation/Screens/Consultation_flow/BookAppointment_consultation/book_appointment_consultation_view_model.dart';

class ConsultationBookAppointment extends StatefulWidget {
  const ConsultationBookAppointment({Key? key}) : super(key: key);

  @override
  State<ConsultationBookAppointment> createState() => _ConsultationBookAppointmentState();
}

class _ConsultationBookAppointmentState extends State<ConsultationBookAppointment> with TickerProviderStateMixin {
  late TabController _tabController;
  List<Map<String, dynamic>> specialties = [];
  List<Map<String, dynamic>> services = [];

  List<Map<String, dynamic>> dataService = [];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _fetchData();
  }

  // Future<void> _fetchData() async {
  //   final apiClient = ApiClient(http.Client());
  //   try {
  //     final response = await apiClient.get('auth/apps/provider/preferences');
  //     if (response.statusCode == 200) {
  //       final responseData = jsonDecode(response.body);
  //       final serviceData = responseData['data'];

  //       print(serviceData);

  //       // setState(() {
  //       //   dataService = serviceData;
  //       // });
  //     }
  //   } catch (e) {
  //     print("Error fetching data: $e");
  //   }
  // }
  Future<void> _fetchData() async {
  final apiClient = ApiClient(http.Client());
  try {
    final response = await apiClient.get('auth/apps/provider/preferences');
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      
      // Log the response to see the structure
      print(responseData);
      
      // Extract specialties and services data from the response
      final specialtiesData = responseData['specialties'];
      final servicesData = responseData['services'];  // Assuming services are under the 'services' key

      // Ensure specialtiesData is a List
      if (specialtiesData is List) {
        setState(() {
          dataService = List<Map<String, dynamic>>.from(specialtiesData);
        });
      } else {
        print("specialties is not a list, it's of type: ${specialtiesData.runtimeType}");
      }

      // Ensure servicesData is a List
      if (servicesData is List) {
        setState(() {
          dataService = List<Map<String, dynamic>>.from(servicesData);
        });
      } else {
        print("services is not a list, it's of type: ${servicesData.runtimeType}");
      }
    }
  } catch (e) {
    print("Error fetching data: $e");
  }
}


  List<Map<String, dynamic>> get currentTabData =>
      _tabController.index == 0 ? specialties : services;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget buildTabContent() {
  final data = dataService;

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
    child: Column(
      children: data.map<Widget>((item) {
        return ChooseServicesCard(
          serviceName: item['name'],  // Assuming 'name' is the service name
          category: item['category'],  // Assuming 'category' is the service category
          description: item['description'],  // Assuming 'description' is the service description
          onSelect: () {
            // Logic for when the service is selected
            // For example, you can update a view model, navigate, or show a dialog
            print("Service Selected: ${item['name']}");
          },
        );
      }).toList(),
    ),
  );
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
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: TabBar(
                            controller: _tabController,
                            indicatorColor: const Color(0xff23A8D9),
                            indicatorWeight: 3,
                            labelColor: const Color(0xff23A8D9),
                            unselectedLabelColor: const Color(0xffB9B9B9),
                            labelStyle: FontStyleUtilities.h6(fontWeight: FWT.medium),
                            onTap: (_) => setState(() {}), // Refresh UI on tab tap
                            tabs: const [
                              Tab(text: 'Specialty'),
                              Tab(text: 'Services'),
                            ],
                          ),
                        ),
                        // buildTabContent(),
                      ],
                    ),
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
                    // NavigationUtil.to(context, ConsultationSelectDoctor(...));
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
