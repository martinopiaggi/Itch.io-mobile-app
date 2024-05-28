import 'dart:ffi';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'custom_app_bar.dart';
import 'customIcons/custom_icon_icons.dart';
import 'helperClasses/Game.dart';
import 'helperClasses/User.dart';
import 'game_tile.dart';
import 'package:badges/badges.dart' as badges;
import 'package:firebase_database/firebase_database.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with SingleTickerProviderStateMixin {
  final Logger logger = Logger(printer: PrettyPrinter());
  final TextEditingController _searchController = TextEditingController();
  late Future<Map<String, dynamic>> searchResults;
  late Future<Map<String, dynamic>> tabFilteredResults;
  bool _searchPerformed = false;
  bool _showSearchBar = true;
  Map<String, String> currentTab = {};
  int _filterCount = 0;
  Map<String, Set<String>> _selectedFilters = {};
  late TabController _tabController;
  late List<Map<String, String>> _tabs = [];

  @override
  void initState() {
    fetchFilters();
    fetchTabs();
    super.initState();
    searchResults = Future.value({"games": [], "users": []});
    tabFilteredResults = Future.value({"items": [], "title": ""});
    _changeTab();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<Map<String, dynamic>> fetchSearchResults(String query) async {
    final response = await http.get(
      Uri.parse('https://us-central1-itchioclientapp.cloudfunctions.net/search?search=$query'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      logger.e('Failed to load search results, status code: ${response.statusCode}');
      throw Exception('Failed to load search results');
    }
  }

  Future<Map<String, dynamic>> fetchTabResults(Map<String, String> currentTab, Map<String, Set<String>> filters) async {
    var concatenatedFilters = '';

    if(filters.entries.isNotEmpty && filters.entries.every((e) => e.value.isNotEmpty)){
      concatenatedFilters = '/${filters.entries.expand((entry) => entry.value).join('/')}';
    }

    final currentTabName = (currentTab['name'] ?? 'games');
    final response = await http.post(
      Uri.parse('https://us-central1-itchioclientapp.cloudfunctions.net/item_list'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'filters': concatenatedFilters, 'type': currentTabName}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      logger.e('Type: $currentTabName, Filters: $concatenatedFilters');
      logger.e('Failed to load tab results, status code: ${response.statusCode}');
      throw Exception('Failed to load tab results');
    }
  }

  Future<void> fetchTabs() async {
    final firebaseApp = Firebase.app();
    final dbInstance = FirebaseDatabase.instanceFor(app: firebaseApp, databaseURL: 'https://itchioclientapp-default-rtdb.europe-west1.firebasedatabase.app');

    final DatabaseReference dbRef = dbInstance.ref('/items/item_types');
    final snapshot = await dbRef.get();
    if (snapshot.exists) {
      final dynamic data = snapshot.value;
      if (data is List<dynamic>) {
        setState(() {
          _tabs = data.map((item) {
            if (item is Map<Object?, Object?>) {
              final Map<String, String> convertedMap = {};
              item.forEach((key, value) {
                if (key != null && value != null) {
                  convertedMap[key.toString()] = value.toString();
                }
              });
              return convertedMap;
            } else {
              return <String, String>{};
            }
          }).toList();

          _tabController = TabController(length: _tabs.length, vsync: this)
            ..addListener(() {
              if (_tabController.indexIsChanging) {
                setState(() {
                  currentTab = _tabs[_tabController.index];
                  _changeTab();
                });
              }
            });
        });
      } else {
        logger.i('Unexpected data type: ${data.runtimeType}');
      }
    } else {
      logger.i('No data available.');
    }
  }

  Future<Map<String, List<Map<String, String>>>> fetchFilters() async {
    final firebaseApp = Firebase.app();
    final dbInstance = FirebaseDatabase.instanceFor(app: firebaseApp, databaseURL: 'https://itchioclientapp-default-rtdb.europe-west1.firebasedatabase.app');

    final DatabaseReference dbRef = dbInstance.ref('/items/filters');
    final snapshot = await dbRef.get();
    if (snapshot.exists) {
      final dynamic data = snapshot.value;
      Map<String, List<Map<String, String>>> resultMap = {};

      data.forEach((key, value) {
        if (key is String) {
          if (value is List) {
            List<Map<String, String>> listValue = [];
            for (var item in value) {
              if (item is Map) {
                Map<String, String> stringMap = {};

                item.forEach((key, value) {
                  if (key is String && value is String) {
                    stringMap[key] = value;
                  }
                });

                listValue.add(stringMap);
              }
            }

            resultMap[key] = listValue;
          }
        }
      });
      return resultMap;
    } else {
      logger.i('No data available.');
      return {};
    }
  }

  void _performSearch() {
    setState(() {
      _searchPerformed = true;
      searchResults = fetchSearchResults(_searchController.text);
    });
  }

  void _changeTab() {
    setState(() {
      _searchPerformed = true;
      tabFilteredResults = fetchTabResults(currentTab, _selectedFilters);
    });
  }

  Future<void> _showFilterPopup(Map<String, Set<String>> existingFilters) async {
    Map<String, Set<String>> newSelectedFilters = Map.from(existingFilters);

    List<Widget> filterRows = await _buildFilterRows(newSelectedFilters);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Filter'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: filterRows
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Confirm'),
            onPressed: () {
              setState(() {
                _selectedFilters = newSelectedFilters;
                _filterCount = _selectedFilters.values.fold(0, (prev, elem) => prev + elem.length);
                _showSearchBar = _filterCount == 0;
              });
              _changeTab();
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Future<List<Widget>> _buildFilterRows(Map<String, Set<String>> selectedFilters) async {
    List<Widget> filterRows = [];
    Map<String, List<Map<String, String>>> filtersData = (await fetchFilters()) as Map<String, List<Map<String, String>>>;

    filtersData.forEach((label, options) {
      filterRows.add(
        FilterRowWidget(
          label: label,
          options: options.toList(),
          selectedFilters: selectedFilters,
          onFiltersChanged: (filters) => selectedFilters = filters,
        ),
      );
    });

    return filterRows;
  }

  void _saveSearch() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Bookmark'),
        content: Text('Search saved in the home'),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for games or users...',
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: _performSearch,
                    ),
                    IconButton(
                      icon: badges.Badge(
                        showBadge: _filterCount > 0,
                        badgeContent: Text('$_filterCount', style: TextStyle(color: Colors.white)),
                        badgeStyle: badges.BadgeStyle(),
                        badgeAnimation: badges.BadgeAnimation.slide(),
                        child: Icon(Icons.filter_list),
                      ),
                      onPressed: () => _showFilterPopup(_selectedFilters),
                    ),
                    IconButton(
                      icon: Icon(Icons.bookmark),
                      onPressed: _saveSearch,
                    ),
                  ],
                ),
              ),
              onSubmitted: (value) => _performSearch(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchActions() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            icon: badges.Badge(
              showBadge: _filterCount > 0,
              badgeContent: Text('$_filterCount', style: TextStyle(color: Colors.white)),
              badgeStyle: badges.BadgeStyle(),
              badgeAnimation: badges.BadgeAnimation.slide(),
              child: Icon(Icons.filter_list),
            ),
            onPressed: () => _showFilterPopup(_selectedFilters),
          ),
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: _saveSearch,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: [
          if (_showSearchBar)
            _buildSearchBar()
          else
            _buildSearchActions(),
          if (_searchController.text.isEmpty)
            ..._buildTabsPage(),
          if (_searchPerformed && _searchController.text.isNotEmpty)
            Expanded(
              child: _buildSearchPage(),
            ),
        ],
      ),
    );
  }

  Widget _buildSearchPage() {
    return FutureBuilder<Map<String, dynamic>>(
      future: searchResults,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          logger.e('FutureBuilder Error: ${snapshot.error}');
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (snapshot.hasData) {
          final data = snapshot.data!;
          final games = (data['games'] as List).map((game) => Game(game)).toList();
          final users = (data['users'] as List).map((user) => User(user)).toList();

          return ListView(
            children: [
              if (games.isNotEmpty)
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Games', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ...games.map((game) => GameTile(game: game)).toList(),
            ],
          );
        } else {
          return Center(child: Text("No results found"));
        }
      },
    );
  }

  Widget _buildTabPage() {
    return FutureBuilder<Map<String, dynamic>>(
      future: tabFilteredResults,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          logger.e('FutureBuilder Error: ${snapshot.error}');
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (snapshot.hasData) {
          final data = snapshot.data!;
          final items = (data['items'] as List).map((game) => Game(game)).toList();
          final title = data['title'] as String;

          return ListView(
            children: [
              if (items.isNotEmpty)
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ...items.map((game) => GameTile(game: game)).toList(),
            ],
          );
        } else {
          return Center(child: Text("No results found"));
        }
      },
    );
  }

  List<Widget> _buildTabsPage() {
    if (_tabs.isEmpty) {
      return [
        const Center(child: CircularProgressIndicator()),
      ];
    } else {
      return [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: TabBar(
            isScrollable: true,
            controller: _tabController,
            tabs: _tabs.map((tab) => Tab(text: tab['label'])).toList(),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: _tabs.map((tab) => _buildTabPage()).toList(),
          ),
        ),
      ];
    }
  }

}

class FilterRowWidget extends StatefulWidget {
  final String label;
  final List<Map<String, String>> options;
  final Map<String, Set<String>> selectedFilters;
  final void Function(Map<String, Set<String>>) onFiltersChanged;

  FilterRowWidget({required this.label, required this.options, required this.selectedFilters, required this.onFiltersChanged});

  @override
  _FilterRowWidgetState createState() => _FilterRowWidgetState();
}

class _FilterRowWidgetState extends State<FilterRowWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: widget.options.map((option) {
              final isSelected = widget.selectedFilters.entries.any((entry) => entry.value.contains(option['name']));
              return Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: FilterChip(
                  label: Text(option['label']!),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        widget.selectedFilters[widget.label] ??= Set();
                        widget.selectedFilters[widget.label]!.add(option['name']!);
                      } else {
                        widget.selectedFilters[widget.label]?.remove(option['name']);
                      }
                      widget.onFiltersChanged(widget.selectedFilters);
                    });
                  },
                  selectedColor: isSelected ? Colors.blue : null,
                  backgroundColor: isSelected ? Colors.blue.withOpacity(0.1) : null,
                  labelStyle: TextStyle(color: isSelected ? Colors.white : null),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

