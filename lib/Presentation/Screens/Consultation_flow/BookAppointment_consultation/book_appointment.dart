import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medix/Data/Core/api_client.dart';
import 'package:medix/Extensions/white_space_extension.dart';
import 'package:medix/Presentation/Constants/gradients.dart';
import 'package:medix/Presentation/Screens/Consultation_flow/Confrim_consulatation/confirm_consultation.dart';
import 'package:medix/Presentation/Screens/Consultation_flow/Consultation_doctors/select_doctor_consultation.dart';
import 'package:medix/Utils/utils.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medix/package/filter_controller.dart';

class BookAppointment extends StatefulWidget {
  const BookAppointment({Key? key}) : super(key: key);

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment>
    with SingleTickerProviderStateMixin {
  final List<String> _tabNames = ['Specialty', 'Services'];
  late TabController _tabController;
  late FilterController<String> _selectionController;

  List<String> _specialties = [];
  List<String> _services = [];

  bool _isLoading = true;

  @override
  void initState() {
    _tabController = TabController(length: _tabNames.length, vsync: this);
    _selectionController = FilterController<String>();
    _tabController.addListener(_onTabChanged);
    _fetchData();
    super.initState();
  }

  Future<void> _fetchData() async {
    final apiClient = ApiClient(http.Client());

    try {
      final response = await apiClient.get('auth/apps/provider/preferences');
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final providers = responseData['providers'];

                  
        final List<String> allSpecialtyNames = [];
        final List<String> allServiceNames = [];

        for (var provider in providers) {
          final providerSpecialties = provider['provider_specialties'] ?? [];
          for (var specialtyEntry in providerSpecialties) {
            final specialty = specialtyEntry['specialty'];
            if (specialty != null && specialty['name'] != null) {
              allSpecialtyNames.add(specialty['name']);
            }
          }

          final providerServices = provider['provider_services'] ?? [];
          for (var serviceEntry in providerServices) {
            final service = serviceEntry['service'];
            if (service != null && service['name'] != null) {
              allServiceNames.add(service['name']);
            }
          }
        }

        setState(() {
          _specialties = allSpecialtyNames;
          _services = allServiceNames;
          _isLoading = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load data.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred.')),
      );
    } finally {
      apiClient.client.close();
    }
  }

  void _onTabChanged() {
    _selectionController.clearTheList(); // Optional: uncomment if you want to clear selection on tab change
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      appBar: AppBar(
        leading: const MyBackButton(),
        title: const Text('Book Appointment'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight + 2.0),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Stack(
              children: [
                Positioned(
                  width: (375 - 32).w,
                  bottom: 0,
                  child: const Padding(
                    padding: EdgeInsets.only(bottom: .5),
                    child: Divider(height: 1, color: Color(0xffACACAC)),
                  ),
                ),
                TabBar(
                  labelPadding: EdgeInsets.symmetric(horizontal: 16.w),
                  isScrollable: true,
                  controller: _tabController,
                  labelColor: isLight ? Colors.black : Colors.white,
                  unselectedLabelColor: const Color(0xffA6A6A6),
                  labelStyle: FontStyleUtilities.h4(fontWeight: FWT.medium).copyWith(fontSize: 19),
                  unselectedLabelStyle: FontStyleUtilities.h4(fontWeight: FWT.regular).copyWith(fontSize: 19),
                  tabs: _tabNames.map((name) => Tab(text: name)).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildList(_specialties),
                      _buildList(_services),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                  child: Button(
                    tittle: 'Continue',
                    onTap: () {
                      final selectedItem = _selectionController.getSelectedRadio;
print(selectedItem);
                      // NavigationUtil.to(
                      //     context,
                      //     ConsultationSelectDoctor(provider: _providers),
                      //   );
                    // if (_selectionController.checkIfNotSelected) {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     SnackBar(
                    //       content: Text(
                    //         'Please select one option.',
                    //         textAlign: TextAlign.center,
                    //       ),
                    //     ),
                    //   );
                    // } else {
                    //   final selectedItem = _selectionController.getSelectedRadio;

                    //   // Find matching provider
                    //   final matchingProvider = providers.firstWhere(
                    //     (provider) {
                    //       final specialties = provider['provider_specialties'] ?? [];
                    //       final services = provider['provider_services'] ?? [];

                    //       final matchInSpecialties = specialties.any((entry) =>
                    //           entry['specialty']?['name'] == selectedItem);

                    //       final matchInServices = services.any((entry) =>
                    //           entry['service']?['name'] == selectedItem);

                    //       return matchInSpecialties || matchInServices;
                    //     },
                    //     orElse: () => null,
                    //   );

                    //   if (matchingProvider != null) {
                    //     NavigationUtil.to(
                    //       context,
                    //       ConsultationSelectDoctor(provider: matchingProvider),
                    //     );
                    //   } else {
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       SnackBar(
                    //         content: Text(
                    //           'Selected item does not match any provider.',
                    //           textAlign: TextAlign.center,
                    //         ),
                    //       ),
                    //     );
                    //   }
                    // }
                  }

                  ),
                )
              ],
            ),
    );
  }

  Widget _buildList(List<String> list) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];
        return AnimatedBuilder(
          animation: _selectionController,
          builder: (context, child) => BasicInfoTile(
            title: item,
            isSelected: _selectionController.checkIfSelected(item),
            onTap: () => _selectionController.addAsRadio(item),
          ),
        );
      },
    );
  }
}

class BasicInfoTile extends StatelessWidget {
  const BasicInfoTile({
    Key? key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          gradient: isSelected ? AppGradients.blueGradient : null,
          color: isSelected ? null : (isLight ? Colors.white : Colors.grey[850]),
        ),
        child: Row(
          children: [
            const Icon(Icons.local_hospital, size: 40), // Replace with dynamic icon if needed
            12.width(),
            Expanded(
              child: Text(
                title,
                style: FontStyleUtilities.h6(
                  fontWeight: FWT.medium,
                  fontColor: isSelected ? Colors.white : (isLight ? Colors.black : Colors.white),
                ),
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: Colors.white, size: 20)
          ],
        ),
      ),
    );
  }
}
