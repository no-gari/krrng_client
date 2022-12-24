import 'package:krrng_client/modules/search/cubit/recent_search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:krrng_client/modules/search_result/view/search_result_screen.dart';
import 'package:krrng_client/modules/search_result_branch/view/search_result_branch_screen.dart';
import 'package:vrouter/vrouter.dart';

class RecentSearchTile extends StatelessWidget {
  RecentSearchTile(
      {this.index, this.recentSearchCubit, this.recentSearchState});

  final RecentSearchState? recentSearchState;
  final RecentSearchCubit? recentSearchCubit;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => SearchResultBranchScreen(
                  keyword: recentSearchState!.results![index!].keyword!))),
      child: Container(
          margin: EdgeInsets.only(right: 7, bottom: 8),
          padding: EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Colors.black12)),
          height: 36,
          child: Wrap(children: [
            SizedBox(width: 15),
            Text(recentSearchState!.results![index!].keyword!,
                style: TextStyle(fontSize: 14)),
            SizedBox(width: 6),
            GestureDetector(
                onTap: () => recentSearchCubit!
                    .deleteRecentSearch(recentSearchState!.results![index!]),
                child: Padding(
                    padding: EdgeInsets.only(top: 2),
                    child: Icon(Icons.close, size: 13, color: Colors.grey))),
            SizedBox(width: 15)
          ])),
    );
  }
}
