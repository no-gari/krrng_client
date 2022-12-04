import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krrng_client/modules/notice/view/notice_page.dart';
import 'package:krrng_client/modules/notice/cubit/notice_cubit.dart';
import 'package:krrng_client/repositories/notice_repository/src/notice_repository.dart';

class NoticeScreen extends StatelessWidget {
  static const String routeName = '/notices';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            NoticeCubit(RepositoryProvider.of<NoticeRepository>(context)),
        child: NoticePage());
  }
}
