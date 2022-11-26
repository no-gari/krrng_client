import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krrng_client/modules/faq/cubit/faq_cubit.dart';
import 'package:krrng_client/modules/faq/page/faq_page.dart';
import 'package:krrng_client/repositories/faq_repository/src/faq_repository.dart';

class FaqScreen extends StatelessWidget {
  static const String routeName = '/faq';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            FAQCubit(RepositoryProvider.of<FAQRepository>(context)),
        child: FaqPage());
  }
}
