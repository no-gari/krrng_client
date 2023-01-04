import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krrng_client/modules/hospital/cubit/hospital_cubit.dart';
import 'package:krrng_client/modules/hospital_detail/view/hospital_detail_screen.dart';
import 'package:krrng_client/modules/search_result/components/search_bar.dart';
import 'package:krrng_client/modules/search_result/components/search_filter.dart';
import 'package:krrng_client/repositories/hospital_repository/models/enums.dart';
import 'package:vrouter/vrouter.dart';
import '../components/hospital_tile.dart';

class HospitalSearchResultPage extends StatefulWidget {
  HospitalSearchResultPage({this.hospitalPart});

  final HospitalPart? hospitalPart;

  @override
  State<HospitalSearchResultPage> createState() =>
      _HospitalSearchResultPageState();
}

class _HospitalSearchResultPageState extends State<HospitalSearchResultPage> {
  final _textEditingController = TextEditingController();

  late HospitalCubit _hospitalCubit;

  @override
  void initState() {
    super.initState();
    _hospitalCubit = BlocProvider.of<HospitalCubit>(context);
    _hospitalCubit
        .emit(_hospitalCubit.state.copyWith(selectedPart: widget.hospitalPart));
    _hospitalCubit.getHosipitals(0);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(automaticallyImplyLeading: true),
        body: SafeArea(child: BlocBuilder<HospitalCubit, HospitalState>(
            builder: (context, state) {
          if (state.isLoaded == true && state.hospitals != null) {
            return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('검색 결과',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        GestureDetector(
                            onTap: () => showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext context) {
                                  return SearchFilter(
                                      hospitalCubit: _hospitalCubit);
                                }),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('${state.hospitals!.length}개 검색 결과',
                                      style: TextStyle(fontSize: 14)),
                                  SizedBox(width: 10),
                                  Icon(Icons.filter_alt_outlined, size: 20)
                                ]))
                      ]),
                  ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: state.hospitals!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => HospitalDetailScreen(
                                          id: state.hospitals![index].id)));
                            },
                            child: HospitalTile(
                                name: state.hospitals![index].name,
                                location:
                                    "${state.hospitals![index].address} ${state.hospitals![index].addressDetail}",
                                price: state.hospitals![index].price,
                                image: state.hospitals![index].image,
                                temperature: state.hospitals![index].recommend!
                                    .toDouble(),
                                reviews: state.hospitals![index].reviewCount,
                                howFar: state.hospitals![index].distance));
                      },
                      separatorBuilder: (BuildContext ctx, int idx) =>
                          Divider(height: 15, color: const Color(0xFFDFE2E9)))
                ]));
          }
          return Center(
              child: Image.asset('assets/images/indicator.gif',
                  width: 100, height: 100));
        })));
  }
}
