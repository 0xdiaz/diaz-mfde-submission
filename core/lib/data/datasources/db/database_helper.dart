import 'dart:async';

import '../../../data/models/movies/movie_table.dart';
import '../../../data/models/series/series_table.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblWatchlistMovies = 'watchlistMovies';
  static const String _tblWatchlistSeries = 'watchlistSeries';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton1.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblWatchlistMovies (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');

    await db.execute('''
      CREATE TABLE  $_tblWatchlistSeries (
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
  }

  Future<int> insertWatchlistMovie(MovieTable movie) async {
    final db = await database;
    return await db!.insert(_tblWatchlistMovies, movie.toJson());
  }

  Future<int> insertWatchlistSeries(SeriesTable series) async {
    final db = await database;
    return await db!.insert(_tblWatchlistSeries, series.toJson());
  }

  Future<int> removeWatchlistMovie(MovieTable movie) async {
    final db = await database;
    return await db!.delete(
      _tblWatchlistMovies,
      where: 'id = ?',
      whereArgs: [movie.id],
    );
  }

  Future<int> removeWatchlistSeries(SeriesTable series) async {
    final db = await database;
    return await db!.delete(
      _tblWatchlistSeries,
      where: 'id = ?',
      whereArgs: [series.id],
    );
  }

  Future<Map<String, dynamic>?> getMovieById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblWatchlistMovies,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getSeriesById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblWatchlistSeries,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistMovies() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblWatchlistMovies);

    return results;
  }

  Future<List<Map<String, dynamic>>> getWatchlistSeries() async {
    final db = await database;
    final List<Map<String, dynamic>> results =
    await db!.query(_tblWatchlistSeries);

    return results;
  }
}
