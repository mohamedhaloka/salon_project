// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:salon_app/shared/componants/app_strings.dart';
// import 'package:salon_app/shared/componants/color_manager.dart';
// import '../../layout/cubut/home_layout_cubit.dart';
// import '../../layout/cubut/home_layout_states.dart';
// import '../../shared/componants/assets_manager.dart';
// import 'add_appointment.dart';
// import 'booking_widget.dart';
//
// class Appointments extends StatefulWidget {
//   const Appointments({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   State<Appointments> createState() => _AppointmentsState();
// }
//
// class _AppointmentsState extends State<Appointments> {
//   int currentStep = 0;
//   List<DateTime> dates = <DateTime>[];
//   int? ff;
//   DateTime selectedDateTime = DateTime.now();
//
//   @override
//   void initState() {
//     DateTime now = DateTime.now();
//     dates.add(now.subtract(const Duration(days: 3)));
//     dates.add(now.subtract(const Duration(days: 2)));
//     dates.add(now.subtract(const Duration(days: 1)));
//     dates.add(now);
//     dates.add(now.add(const Duration(days: 1)));
//     dates.add(now.add(const Duration(days: 2)));
//     dates.add(now.add(const Duration(days: 3)));
//     dates.add(now.add(const Duration(days: 4)));
//     dates.add(now.add(const Duration(days: 5)));
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Locale myLocale = Localizations.localeOf(context);
//     // var cubit = HomeLayoutCubit.get(context).getChooseServices!.data;
//     return BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
//         listener: (context, state) {},
//         builder: (context, state) {
//
//
//           return Column(children: [
//             Padding(
//                 padding: EdgeInsets.only(top: 60.h, right: 35.w, left: 35.w),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Column(
//
//                       children: [
//                         Text(
//                           AppStrings.today.tr(),
//                           style: const TextStyle(
//                             fontWeight: FontWeight.w700,
//                             fontSize: 20,
//                           ),
//                         ),
//                         SizedBox(
//                           height: 2.h,
//                         ),
//                         Text(
//                           'may 5, 2023',
//                           style: TextStyle(
//                             color: HexColor('#212121').withOpacity(0.5),
//                             fontWeight: FontWeight.w400,
//                             fontSize: 11,
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 20.h),
//                     SizedBox(
//                       height: 70.h,
//                       child: ListView.separated(
//                         itemBuilder: (_, int index) => Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 4.w),
//                           child: InkWell(
//                             onTap: () {
//                               selectedDateTime = dates[index];
//                               setState(() {});
//                             },
//                             child: Column(
//                               children: [
//                                 Center(
//                                   child: Align(
//                                     child: Text(
//                                       DateFormat.E(myLocale.languageCode)
//                                           .format(dates[index]),
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                         color: dates[index].day ==
//                                             selectedDateTime.day
//                                             ? ColorManager.buttonColor
//                                             : Colors.grey,
//                                       ),
//                                     ),
//                                     alignment: Alignment.center,
//                                   ),
//                                 ),
//                                 Text(
//                                   dates[index].day.toString(),
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     color:
//                                     dates[index].day == selectedDateTime.day
//                                         ? ColorManager.buttonColor
//                                         : Colors.grey,
//                                   ),
//                                 ),
//                                 if (dates[index].day ==
//                                     selectedDateTime.day) ...[
//                                   CircleAvatar(
//                                     backgroundColor: ColorManager.buttonColor,
//                                     radius: 2,
//                                   )
//                                 ]
//                               ],
//                             ),
//                           ),
//                         ),
//                         separatorBuilder: (_, __) => SizedBox(width: 12.w),
//                         itemCount: dates.length,
//                         scrollDirection: Axis.horizontal,
//                       ),
//                     ),
//                     SizedBox(height: 10.h),
//                     ConditionalBuilder(condition: cubit  != null, builder: (context)=>
//                         ListView.separated(
//                             shrinkWrap: true,
//                             physics: const NeverScrollableScrollPhysics(),
//                             itemBuilder: (_, int index) => BookingWidget(
//                               index: index,
//                             ),
//                             separatorBuilder: (_, __) => SizedBox(width: 0.w),
//                             itemCount: cubit!.length
//                         ),
//                         fallback: (context)=>const Center(child: CircularProgressIndicator()))
//                   ],
//                 ))
//           ]);
//
//         });
//
//   }
// }
