import 'package:krrng_client/modules/authentication/bloc/authentication_bloc.dart';
import 'package:krrng_client/repositories/hospital_repository/src/hospital_repository.dart';
import 'package:krrng_client/modules/writing_review/cubit/writing_review_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'my_review_page.dart';

class MyReviewScreen extends StatelessWidget {
  static const String routeName = '/my-review';

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: BlocProvider.of<AuthenticationBloc>(context),
        child: BlocProvider(
            create: (context) => WritingReviewCubit(
                hospitalRepository:
                    RepositoryProvider.of<HospitalRepository>(context)),
            child: MyReviewPage()));
  }
}
