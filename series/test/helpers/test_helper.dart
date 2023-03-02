import 'package:core/data/datasources/series/series_local_data_source.dart';
import 'package:core/data/datasources/series/series_remote_data_source.dart';
import 'package:core/domain/repositories/series_repository.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  SeriesRepository,
  SeriesRemoteDataSource,
  SeriesLocalDataSource,
])
void main() {}
