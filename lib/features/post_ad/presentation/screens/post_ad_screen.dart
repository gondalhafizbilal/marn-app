import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:marn/core/ui/marn_components.dart';
import 'package:marn/core/ui/marn_page_scaffold.dart';
import 'package:marn/core/utils/app_strings.dart';
import 'package:marn/features/post_ad/logic/post_ad_cubit.dart';
import 'package:marn/routing/app_router.dart';

class PostAdScreen extends StatelessWidget {
  const PostAdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostAdCubit, PostAdState>(
      listenWhen: (previous, current) =>
          previous.isSubmitted != current.isSubmitted,
      listener: (context, state) {
        if (state.isSubmitted) {
          context.go(AppRouter.ads);
        }
      },
      builder: (context, state) {
        final strings = context.strings;

        return MarnPageScaffold(
          title: strings.postAd,
          subtitle: strings.postAdSubtitle,
          child: Column(
            children: [
              MarnFormField(
                label: strings.category,
                initialValue: state.category,
                onChanged: context.read<PostAdCubit>().categoryChanged,
              ),
              SizedBox(height: 14.h),
              MarnFormField(
                label: strings.title,
                onChanged: context.read<PostAdCubit>().titleChanged,
              ),
              SizedBox(height: 14.h),
              MarnFormField(
                label: strings.description,
                maxLines: 4,
                onChanged: context.read<PostAdCubit>().descriptionChanged,
              ),
              SizedBox(height: 14.h),
              MarnFormField(
                label: strings.price,
                keyboardType: TextInputType.number,
                onChanged: context.read<PostAdCubit>().priceChanged,
              ),
              SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: state.isSubmitting
                      ? null
                      : context.read<PostAdCubit>().submit,
                  child: Text(
                    state.isSubmitting ? strings.posting : strings.postAd,
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
