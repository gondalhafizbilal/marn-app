import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:marn/core/ui/marn_components.dart';
import 'package:marn/core/ui/marn_page_scaffold.dart';
import 'package:marn/core/utils/app_strings.dart';
import 'package:marn/features/requests/logic/request_form_cubit.dart';
import 'package:marn/routing/app_router.dart';

class RequestSubmitScreen extends StatelessWidget {
  const RequestSubmitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RequestFormCubit, RequestFormState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == RequestFormStatus.submitted) {
          context.go(AppRouter.requestSuccess);
        }
      },
      builder: (context, state) {
        final strings = context.strings;

        return MarnPageScaffold(
          showBackButton: true,
          title: strings.submitRequest,
          subtitle: strings.submitRequestSubtitle,
          child: Column(
            children: [
              MarnFormField(
                label: strings.category,
                initialValue: state.category,
                onChanged: context.read<RequestFormCubit>().categoryChanged,
              ),
              SizedBox(height: 14.h),
              MarnFormField(
                label: strings.location,
                initialValue: state.location,
                onChanged: context.read<RequestFormCubit>().locationChanged,
              ),
              SizedBox(height: 14.h),
              MarnFormField(
                label: strings.description,
                maxLines: 4,
                onChanged: context.read<RequestFormCubit>().descriptionChanged,
              ),
              SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: state.status == RequestFormStatus.submitting
                      ? null
                      : context.read<RequestFormCubit>().submit,
                  child: Text(
                    state.status == RequestFormStatus.submitting
                        ? strings.submitting
                        : strings.submitRequest,
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
