import 'package:movies/presentation/pages/watchlist_movies_page.dart';
import 'package:series/presentation/pages/watchlist_series_page.dart';
import 'package:flutter/material.dart';

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({super.key});

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: _listTabs.length,
        vsync: this,
        initialIndex: 0,
    );
  }

  final List<Widget> _listTabs = [
    const Text('Movies'),
    const Text('TV Series'),
  ];

  final List<Widget> _listWidgets = [
    const WatchlistMoviesPage(),
    const WatchlistSeriesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
        bottom: TabBar(
          labelPadding: const EdgeInsets.all(16),
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: _listTabs,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _listWidgets,
      ),
    );
  }
}