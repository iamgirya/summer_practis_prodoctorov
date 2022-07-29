import '../repositories/forecast_repository.dart';
import '../repositories/local_saves_repository.dart';

class Cont {
  static ForecastRepository forecastRepository = ForecastRepository();
  static ILocalSavesRepository localSavesRepository = LocalSavesRepository();

  static const String weatherPageRoot = "weatherPage";
  static const String searchPageRoot = "searchPage";
}

/*
можно кликап посмотреть?
 */
