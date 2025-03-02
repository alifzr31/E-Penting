import 'package:epenting/app/models/percentage.dart';
import 'package:epenting/app/services/dashboard_service.dart';

abstract class DashboardRepository {
  Future<List<Percentage>> fetchPercentage();
}

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardService _service;

  DashboardRepositoryImpl(this._service);

  @override
  Future<List<Percentage>> fetchPercentage() async {
    return await _service.fetchPercentage();
  }
}
