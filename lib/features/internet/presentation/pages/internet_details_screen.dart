// import 'package:flutter/material.dart';
// import 'package:image_multi_type/image_multi_type.dart';
// import 'package:intl/intl.dart';
// import 'package:techpeak/core/app_size/app_size.dart';
// import 'package:techpeak/core/constante/app_color.dart';
// import 'package:techpeak/core/constante/app_image.dart';
// import 'package:techpeak/features/internet/presentation/widgets/internet_details_header.dart';
// import 'package:techpeak/features/model_delete_after_api/model.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'dart:math' as math;
// import '../cubit/internet_details_cubit.dart';
// import 'package:techpeak/features/internet/presentation/widgets/date_info_widget.dart';
// import 'package:techpeak/features/internet/presentation/widgets/package_info_widget.dart';
// import 'package:techpeak/features/internet/presentation/widgets/progress_indicator_widget.dart';
// import 'package:techpeak/features/internet/presentation/widgets/user_info_widget.dart';
//
// class InternetDetailsScreen extends StatelessWidget {
//   final int index;
//
//   const InternetDetailsScreen({super.key, required this.index});
//
//   @override
//   Widget build(BuildContext context) {
//     if (index < 0 || index >= AppItems.internetUsers.length) {
//       return const Scaffold(
//         body: Center(
//             child: Text("المستخدم غير موجود", style: TextStyle(fontSize: 18))),
//       );
//     }
//
//     final details = AppItems.internetDetailsList[index];
//     final user = AppItems.internetUsers[index];
//
//     double usedGB =
//         double.tryParse(details.usedPackage.replaceAll(' جيجابايت', '')) ?? 0;
//     double totalGB =
//         double.tryParse(user.internet.replaceAll(' جيجابايت', '')) ?? 1;
//     double percentage = usedGB / totalGB;
//
//     return BlocProvider(
//       create: (context) {
//         final cubit = InternetDetailsCubit();
//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           cubit.startProgressAnimation(percentage);
//         });
//         return cubit;
//       },
//       child: Scaffold(
//         backgroundColor: AppColors.whiteColor,
//         body: SafeArea(
//           child: Padding(
//             padding: EdgeInsets.fromLTRB(response(context, 16),
//                 response(context, 16), response(context, 16), 0),
//             child: Column(
//               children: [
//                 const InternetDetailsHeader(),
//                 SizedBox(height: response(context, 16)),
//                 _buildDetailsCard(context, details, user, percentage),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDetailsCard(
//       BuildContext context, dynamic details, dynamic user, double percentage) {
//     return Column(
//       children: [
//         Container(
//           padding: EdgeInsets.all(response(context, 12)),
//           decoration: BoxDecoration(
//             color: AppColors.cardColor,
//             borderRadius: BorderRadius.circular(response(context, 8)),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               UserInfoWidget(user: user),
//               SizedBox(height: response(context, 12)),
//               PackageInfoWidget(details: details),
//               SizedBox(height: response(context, 12)),
//               DateInfoWidget(details: details),
//             ],
//           ),
//         ),
//         SizedBox(height: response(context, 24)),
//         ProgressIndicatorWidget(
//           percentage: percentage,
//           used: details.usedPackage,
//           total: user.internet,
//         ),
//       ],
//     );
//   }
// }
