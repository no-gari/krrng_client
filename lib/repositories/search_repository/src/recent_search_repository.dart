import 'package:shared_preferences/shared_preferences.dart';
import '../models/recent_search.dart';

class RecentSearchRepository {
  Future getRecentSearchKeywords() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      String recentSearchString = await prefs.getString('recentSearch') ?? '';
      List<RecentSearch> recentSearchList = [];
      if (recentSearchString != '') {
        recentSearchList = await RecentSearch.decode(recentSearchString);
      }
      return recentSearchList;
    } catch (e) {
      print(e.toString());
    }
  }

  Future addRecentSearch(RecentSearch recentSearch) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      String recentSearchString = await prefs.getString('recentSearch') ?? '';
      List<RecentSearch> recentSearchList = [];
      if (recentSearchString != '') {
        recentSearchList = await RecentSearch.decode(recentSearchString);
      }
      recentSearchList.add(recentSearch);
      String encodedData = RecentSearch.encode(recentSearchList);
      await prefs.setString('recentSearch', encodedData);

      return recentSearchList;
    } catch (e) {
      print(e.toString());
    }
  }

  Future deleteRecentSearch(RecentSearch recentSearch) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      String recentSearchString = await prefs.getString('recentSearch') ?? '';
      List<RecentSearch> recentSearchList = [];
      if (recentSearchString != '') {
        recentSearchList = await RecentSearch.decode(recentSearchString);
      }
      recentSearchList.remove(recentSearch);

      String encodedData = RecentSearch.encode(recentSearchList);
      await prefs.setString('recentSearch', encodedData);

      return recentSearchList;
    } catch (e) {
      print(e.toString());
    }
  }

  Future deleteAllRecentSearch() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      String recentSearchString = await prefs.getString('recentSearch') ?? '';
      List<RecentSearch> recentSearchList = [];
      String encodedData = RecentSearch.encode(recentSearchList);
      await prefs.setString('recentSearch', encodedData);
      return recentSearchList;
    } catch (e) {
      print(e.toString());
    }
  }
}
