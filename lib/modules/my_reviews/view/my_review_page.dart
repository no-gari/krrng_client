import 'package:krrng_client/modules/writing_review/cubit/writing_review_cubit.dart';
import 'package:krrng_client/modules/authentication/bloc/authentication_bloc.dart';
import 'package:krrng_client/modules/hospital_detail/components/review_tile.dart';
import 'package:krrng_client/modules/review/review_detail_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class MyReviewPage extends StatefulWidget {
  const MyReviewPage({Key? key}) : super(key: key);

  @override
  State<MyReviewPage> createState() => _MyReviewPageState();
}

class _MyReviewPageState extends State<MyReviewPage> {
  late WritingReviewCubit _writingReviewCubit;
  late AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    super.initState();
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    _writingReviewCubit = BlocProvider.of<WritingReviewCubit>(context);
    _writingReviewCubit.getMyReviews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(automaticallyImplyLeading: true),
        body: SafeArea(child:
            BlocBuilder<WritingReviewCubit, WritingReviewState>(
                builder: (context, state) {
          if (state.isComplete == true &&
              state.reviews != null &&
              state.reviews!.length != 0) {
            return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(children: [
                  for (var review in state.reviews!)
                    Column(
                      children: [
                        Container(
                            margin: EdgeInsets.only(
                                right: 24,
                                top: review == state.reviews!.first ? 0 : 10,
                                bottom: 10),
                            width: double.maxFinite,
                            height: 1,
                            color: review == state.reviews!.first
                                ? Colors.white
                                : Colors.black12),
                        ReviewTile(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ReviewDetailPage(review))),
                            name: review.nickname,
                            rate: review.rates,
                            diagnosis: review.diagnosis,
                            date: review.createdAt,
                            imageList: review.reviewImage
                                ?.map((e) => e.image)
                                .toList(),
                            content: review.content,
                            likes: review.likes,
                            isLike: review.isLike)
                      ],
                    )
                ]));
          } else if (state.isComplete == true &&
              state.reviews != null &&
              state.reviews!.length == 0) {
            return Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(top: 30),
                alignment: Alignment.center,
                child: Text('아직 작성한 리뷰가 없습니다'));
          }
          return Center(
              child: Image.asset('assets/images/indicator.gif',
                  width: 100, height: 100));
        })));
  }
}
