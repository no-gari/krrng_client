import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krrng_client/modules/version_info/page/version_info_page.dart';
import 'package:krrng_client/modules/version_info/cubit/version_info_cubit.dart';
import 'package:krrng_client/repositories/notice_repository/src/notice_repository.dart';

class VersionInfoScreen extends StatelessWidget {
  static const String routeName = '/version-info';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            VersionInfoCubit(RepositoryProvider.of<NoticeRepository>(context)),
        child: VersionInfoPage());
  }
}
