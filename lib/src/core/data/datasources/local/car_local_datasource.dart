abstract interface class ICarLocalDatasource {
  Future<List<Map<String, dynamic>>> getCarsFavorite();
  Future<int> setCarFavorite({required Map<String, dynamic> map});
  Future<int> removeCarFavorite({required int carId});
  Future<int> updateCarAsFavorite({required Map<String, dynamic> map});
}
