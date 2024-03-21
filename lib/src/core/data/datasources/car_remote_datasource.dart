abstract interface class ICarRemoteDatasource {
  Future<List<Map<String, dynamic>>> getCars();
  Future<bool> syncLeads({required List<Map<String, dynamic>> favoriteCars});
}
