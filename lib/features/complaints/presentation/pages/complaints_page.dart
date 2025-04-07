import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techpeak/core/app_size/app_size.dart';
import 'package:techpeak/core/constante/app_color.dart';
import 'package:techpeak/core/function/validator.dart';
import 'package:techpeak/core/widgets/app_widget/custom_button.dart';
import 'package:techpeak/core/widgets/app_widget/text_field_custom.dart';
import 'package:techpeak/core/widgets/dialogs/loading_dialog_widget.dart';
import 'package:techpeak/dependency_injection.dart';
import 'package:techpeak/features/complaints/presentation/widget/complain_header.dart';
import '../cubit/complaints_cubit.dart';
import 'package:get_it/get_it.dart';

class ComplaintsPage extends StatelessWidget {
  const ComplaintsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ComplaintsCubit>(),
      child: BlocConsumer<ComplaintsCubit, ComplaintsState>(
        listener: (context, state) {
          if (state.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.successMessage ?? 'تم إرسال الشكوى بنجاح'),
                backgroundColor: AppColors.primaryColor,
              ),
            );
          }
          if (state.isLoading) {
            LoadingDialogWidget();
          } else if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error!),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<ComplaintsCubit>();

          return Form(
            key: cubit.formKey,
            child: Scaffold(
              backgroundColor: AppColors.whiteColor,
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      response(context, 16),
                      response(context, 16),
                      response(context, 16),
                      0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ComplainHeader(),
                        SizedBox(height: response(context, 16)),
                        Text(
                          "نحن هنا للاستماع إليك! إذا كنت تواجه أي مشكلة أو لديك ملاحظة، يرجى ملء النموذج أدناه وسنعمل على حلها في أسرع وقت ممكن.",
                          style: TextStyle(
                            color: AppColors.greyColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.right,
                        ),
                        SizedBox(height: response(context, 24)),
                        const Text(
                          "موضوع الشكوى",
                          style: TextStyle(
                            color: AppColors.blackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: response(context, 8)),
                        TextFieldCustom(
                          controller: cubit.subjectController,
                          maxLength: 256,
                          validator: (value) =>
                              validateNotHaveValue(value, context),
                          hintText: "أدخل موضوع الشكوى",
                          hintStyle: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: response(context, 16)),
                        const Text(
                          "تفاصيل الشكوى",
                          style: TextStyle(
                            color: AppColors.blackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: response(context, 8)),
                        TextFieldCustom(
                          controller: cubit.detailsController,
                          hintText: "اكتب تفاصيل الشكوى هنا",
                          maxLines: 5,
                          validator: (value) =>
                              validateNotHaveValue(value, context),
                          hintStyle: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: response(context, 24)),
                        BlocBuilder<ComplaintsCubit, ComplaintsState>(
                          builder: (context, state) {

                            return Center(
                              child: CustomLoadingButton(
                                isElevation: state.isNotEmpty,
                                title: "إرسال الشكوى",
                                width: width(context),
                                vertical: response(context, 10),
                                height: response(context, 47),
                                borderRadius: 30,
                                onPressed:state.isLoading?null: () => cubit.submitComplaint(),
                                colorButton: AppColors.primaryColor,
                                isLoading: state.isLoading,
                                colorText: Colors.white,
                                colorLoader: AppColors.primaryColor,
                              ),
                            );
                          },
                        ),
                        SizedBox(height: response(context, 24)),
                        Text(
                          "📩 ملاحظة: سيتم الرد على الشكوى عبر البريد الإلكتروني في أقرب وقت ممكن",
                          style: TextStyle(
                            color: AppColors.greyColor,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
