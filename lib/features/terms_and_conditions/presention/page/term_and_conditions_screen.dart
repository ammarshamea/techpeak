import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techpeak/core/app_size/app_size.dart';
import 'package:techpeak/core/constante/app_color.dart';
import 'package:techpeak/core/route/route_list.dart';
import 'package:techpeak/core/widgets/dialogs/loading_dialog_widget.dart';
import 'package:techpeak/features/model_delete_after_api/model.dart';
import 'package:techpeak/features/terms_and_conditions/presention/widget/accept_terms.dart';

import '../../../../core/widgets/app_widget/custom_button.dart';
import '../../../../dependency_injection.dart';
import '../cubit/terms_cubit.dart';
import '../cubit/terms_state.dart';
import '../widget/section_text.dart';
import '../widget/section_title.dart';
import '../../../../features/auth/presention/bloc/auth_cubit.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<TermsCubit>()),
        // Use the existing AuthCubit instance
        BlocProvider.value(value: authCubit),
      ],
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            LoadingDialogWidget.show(context);
          } else {
            LoadingDialogWidget.hide(context);

            if (state is AuthSuccess) {
              AppRouter.navigateAndRemoveUntil(context, AppRouter.login);
            } else if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: AppColors.redColor,
                ),
              );
            }
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.whiteColor,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(response(context, 16),
                  response(context, 16), response(context, 16), 0),
              child: BlocBuilder<TermsCubit, TermsState>(
                builder: (context, state) {
                  if (state is TermsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    );
                  }

                  if (state is TermsError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            state.message,
                            style: const TextStyle(
                              color: AppColors.greyColor,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              context.read<TermsCubit>().loadTerms();
                            },
                            child: const Text('إعادة المحاولة'),
                          ),
                        ],
                      ),
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "الشروط والأحكام",
                        style: TextStyle(
                          fontSize: response(context, 30),
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      SizedBox(height: response(context, 8)),
                      Divider(color: AppColors.greyColor.withOpacity(0.3)),
                      SizedBox(height: response(context, 16)),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                      height: response(context, 16));
                                },
                                itemCount: AppItems.terms.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SectionTitle(
                                        title: AppItems.terms[index].title,
                                      ),
                                      SizedBox(height: response(context, 8)),
                                      SectionText(
                                        text: AppItems.terms[index].description,
                                      ),
                                    ],
                                  );
                                },
                              ),
                              SizedBox(height: response(context, 16)),
                              AcceptTerms(),
                              SizedBox(height: response(context, 32)),
                              Padding(
                                padding: EdgeInsets.all(response(context, 8)),
                                child: CustomLoadingButton(
                                  isElevation:
                                      context.read<TermsCubit>().isAccepted,
                                  vertical: response(context, 10),
                                  title: "قبول الشروط والمتابعة",
                                  height: response(context, 47),
                                  width: width(context),
                                  onPressed:
                                      context.read<TermsCubit>().isAccepted
                                          ? () {
                                              context
                                                  .read<AuthCubit>()
                                                  .completeRegistration(
                                                    acceptTerms: context
                                                        .read<TermsCubit>()
                                                        .isAccepted,
                                                  );
                                            }
                                          : null,
                                  borderRadius: response(context, 20),
                                  colorButton:
                                      context.read<TermsCubit>().isAccepted
                                          ? AppColors.primaryColor
                                          : AppColors.buttonGrey,
                                  colorText: AppColors.whiteColor,
                                ),
                              ),
                              SizedBox(height: response(context, 32)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
