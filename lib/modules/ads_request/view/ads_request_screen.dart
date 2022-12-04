import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krrng_client/modules/ads_request/cubit/ads_request_cubit.dart';
import 'package:krrng_client/repositories/faq_repository/src/faq_repository.dart';
import 'ads_request_page.dart';

class AdsRequestScreen extends StatelessWidget {
  static const routeName = '/ads-request';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            AdsRequestCubit(RepositoryProvider.of<FAQRepository>(context)),
        child: AdsRequestPage());
  }
}
