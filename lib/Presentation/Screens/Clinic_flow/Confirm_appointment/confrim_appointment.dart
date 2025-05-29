import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medix/Data/Core/api_client.dart';
import 'package:medix/Extensions/white_space_extension.dart';
import 'package:medix/Presentation/Screens/Clinic_flow/Add_voucher/add_voucher.dart';
import 'package:medix/Utils/utils.dart';
import 'package:medix/Presentation/Widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Shared/app_bar.dart' as bar;

import '../../Flow_widgets/confirmation_detail_widget.dart';

class ConfirmAppointMent extends StatefulWidget {
  final Map<String, dynamic> data;
  const ConfirmAppointMent({Key? key, required this.data}) : super(key: key);

  
  @override
  State<ConfirmAppointMent> createState() => _ConfirmAppointMentState();
}

class _ConfirmAppointMentState extends State<ConfirmAppointMent> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
        body: Stack(
      children: [
        CustomScrollView(
          slivers: [
            const bar.TopAppBar(
              step: bar.Step.confirm,
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
                            'Confirm Appointment',
                            style: FontStyleUtilities.h2(
                              fontWeight: FWT.medium,
                              fontColor: isLight
                                  ? Colors.black
                                  : Colors.white.withOpacity(0.80),
                            ),
                          ),
                          Text(
                            'Find the service you are ',
                            style: FontStyleUtilities.h6(
                              fontWeight: FWT.medium,
                              fontColor: isLight
                                  ? const Color(0xffB9B9B9)
                                  : Colors.white.withOpacity(0.80),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                    ]))),
            SliverSizedBox(height: 10.h),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                margin: EdgeInsets.symmetric(horizontal: 24.w),
                decoration: BoxDecoration(
                  color: isLight ? Colors.white : ColorUtil.surfaceDark,
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child: SizedBox(
                              height: 160.h,
                              width: double.infinity,
                              child: Image.asset(
                                'assets/Images/Temp/hospital_2.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          21.height(),
                          Text(
                            widget.data['clinic_name'],
                            style: FontStyleUtilities.h4(
                                    fontWeight: FWT.medium,
                                    fontColor: isLight
                                        ? Colors.black
                                        : Colors.white.withOpacity(0.80))
                                .copyWith(fontSize: 19.sp),
                          ),
                        ],
                      ),
                    ),
                    14.height(),
                    Divider(
                      thickness: 1,
                      height: 1,
                      color: const Color(0xffd1d1d1).withOpacity(.30),
                    ),
                    23.height(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: Column(
                        children: [
                           ConfirmationDetail(
                              icon: 'assets/Icons/Discovery.svg',
                              tittle: 'Location',
                              subtitle: '${widget.data['clinic_address'].toString().characters.take(30).string}...'),
                          22.height(),
                           ConfirmationDetail(
                              icon: 'assets/Icons/service.svg',
                              tittle: 'Service',
                              subtitle: widget.data['speciality']),
                          22.height(),
                           ConfirmationDetail(
                              icon: 'assets/Icons/Doctor.svg',
                              tittle: 'Doctor',
                              subtitle: widget.data['doctor_name']),
                          22.height(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
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
                
                    consultationRequest(context, widget.data);
                    // NavigationUtil.to(context, const AddVoucher());
                  }),
            )),
      ],
    ));
  }
  
Future<void> consultationRequest(BuildContext context, Map<String, dynamic> data) async {
  final apiClient = ApiClient(http.Client()); // Or however you initialize it

   String formatDateTimeToBackend(DateTime dt) =>
    dt.toString().substring(0, 16).replaceFirst('T', ' ');

  final convertedData = {
    ...data,
    'start': data['start'] is DateTime ? formatDateTimeToBackend(data['start']) : data['start'],
    'end': data['end'] is DateTime ? formatDateTimeToBackend(data['end']) : data['end'],
  };



  try {
    final response = await apiClient.consultationRequest(
      'patient-consult-request',
      params: convertedData,
    );


    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Consultation request submitted successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit request: ${response.statusCode}')),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('An error occurred: $e')),
    );
  } finally {
    apiClient.client.close(); // Don't forget to close the client
  }
}

 void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
