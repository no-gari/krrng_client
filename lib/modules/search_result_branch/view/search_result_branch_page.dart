import 'package:krrng_client/modules/hospital/cubit/hospital_cubit.dart';
import 'package:krrng_client/modules/disease/cubit/disease_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:krrng_client/modules/hospital_detail/view/hospital_detail_screen.dart';
import 'package:krrng_client/modules/hospital_search/view/hostipal_search_page.dart';
import 'package:krrng_client/modules/search_result/components/hospital_tile.dart';

class SearchResultBranchPage extends StatefulWidget {
  SearchResultBranchPage({this.keyword});

  final String? keyword;

  @override
  State<SearchResultBranchPage> createState() => _SearchResultBranchPageState();
}

class _SearchResultBranchPageState extends State<SearchResultBranchPage>
    with TickerProviderStateMixin {
  late HospitalCubit _hospitalCubit;
  late DiseaseCubit _diseaseCubit;
  late TabController _tabController;

  final _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _hospitalCubit = BlocProvider.of<HospitalCubit>(context);
    _diseaseCubit = BlocProvider.of<DiseaseCubit>(context);
    _hospitalCubit.hospitalSearch(widget.keyword!);
    _diseaseCubit.getDiseaseList(widget.keyword!);
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
        body: BlocBuilder<DiseaseCubit, DiseaseState>(
            builder: (context, diseaseState) {
          return BlocBuilder<HospitalCubit, HospitalState>(
              builder: (context, hospitalState) {
            if (diseaseState.isLoaded == true &&
                hospitalState.isLoaded == true) {
              return SafeArea(
                  child: Column(children: [
                Container(
                    height: 45,
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(25.0)),
                    child: TabBar(
                        controller: _tabController,
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color: Theme.of(context).primaryColor),
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.black,
                        tabs: [Tab(text: '질병 검색'), Tab(text: '병원 검색')])),
                Expanded(
                    child: TabBarView(controller: _tabController, children: [
                  Container(
                      child: SingleChildScrollView(
                          child: Column(children: [
                    for (var item in _diseaseCubit.state.disease!)
                      ListTile(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      HospitalSearchPage(disease: item.id))),
                          title: Text(item.name.toString())),
                    if (_diseaseCubit.state.disease!.isEmpty)
                      Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text('검색 결과가 없습니다.',
                              style: TextStyle(fontSize: 14)))
                  ]))),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: SingleChildScrollView(
                          child: Column(children: [
                        for (var item in _hospitalCubit.state.hospitals!)
                          GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        HospitalDetailScreen(id: item.id))),
                            child: HospitalTile(
                                name: item.name,
                                location:
                                    "${item.address} ${item.addressDetail}",
                                price: item.price,
                                image: item.image,
                                temperature: item.recommend!.toDouble(),
                                reviews: item.reviewCount,
                                howFar: item.distance),
                          ),
                        if (_hospitalCubit.state.hospitals!.isEmpty)
                          Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text('검색 결과가 없습니다.',
                                  style: TextStyle(fontSize: 14)))
                      ])))
                ]))
              ]));
            }
            return Center(
                child: Image.asset('assets/images/indicator.gif',
                    width: 100, height: 100));
          });
        }));
  }
}
