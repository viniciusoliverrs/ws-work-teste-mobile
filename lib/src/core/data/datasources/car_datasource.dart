abstract interface class ICarDatasource {
  Future<List<Map<String, dynamic>>> getCars();
  Future<List<Map<String, dynamic>>> getCarsFavorite();
  Future<int> setCarFavorite({required Map<String, dynamic> map});
  Future<int> removeCarFavorite({required int carId});
  Future<bool> syncLeads({required List<Map<String, dynamic>> favoriteCars});
  Future<int> updateCarAsFavorite({required Map<String, dynamic> map});
}
