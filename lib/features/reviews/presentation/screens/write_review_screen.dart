import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:marn/core/ui/marn_components.dart';
import 'package:marn/core/ui/marn_page_scaffold.dart';
import 'package:marn/features/reviews/logic/review_form_cubit.dart';

class WriteReviewScreen extends StatelessWidget {
  const WriteReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReviewFormCubit, ReviewFormState>(
      listenWhen: (previous, current) =>
          previous.isSubmitted != current.isSubmitted,
      listener: (context, state) {
        if (state.isSubmitted) {
          context.pop();
        }
      },
      builder: (context, state) {
        return MarnPageScaffold(
          showBackButton: true,
          title: 'Write review',
          subtitle: 'Rate your completed service experience.',
          child: Column(
            children: [
              DropdownButtonFormField<int>(
                initialValue: state.rating,
                decoration: const InputDecoration(labelText: 'Rating'),
                items: const [
                  DropdownMenuItem(value: 5, child: Text('5 stars')),
                  DropdownMenuItem(value: 4, child: Text('4 stars')),
                  DropdownMenuItem(value: 3, child: Text('3 stars')),
                  DropdownMenuItem(value: 2, child: Text('2 stars')),
                  DropdownMenuItem(value: 1, child: Text('1 star')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    context.read<ReviewFormCubit>().ratingChanged(value);
                  }
                },
              ),
              SizedBox(height: 14.h),
              MarnFormField(
                label: 'Review',
                maxLines: 5,
                onChanged: context.read<ReviewFormCubit>().bodyChanged,
              ),
              SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: state.isSubmitting
                      ? null
                      : context.read<ReviewFormCubit>().submit,
                  child: Text(
                    state.isSubmitting ? 'Submitting...' : 'Submit review',
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
