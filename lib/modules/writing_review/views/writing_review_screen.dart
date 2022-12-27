import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krrng_client/modules/writing_review/cubit/writing_review_cubit.dart';
import 'package:krrng_client/repositories/hospital_repository/models/hospital_detail.dart';
import 'package:krrng_client/repositories/hospital_repository/src/hospital_repository.dart';
import 'views.dart';

class WritingReviewScreen extends StatelessWidget {
  const WritingReviewScreen({super.key, required this.hospitalDetail});

  static const String routeName = '/review';

  final HospitalDetail hospitalDetail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("병원 리뷰 등록", style: Theme.of(context).textTheme.headline2),
          centerTitle: false,
        ),
        body: BlocProvider(
            create: (context) => WritingReviewCubit(
                RepositoryProvider.of<HospitalRepository>(context),
                this.hospitalDetail
            ),
            child: WritingReviewPage())
    );
  }
}
