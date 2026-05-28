abstract interface class DataSource<T> {
  Future<List<T>> fetchAllData();

  Future<T?> fetchDataForId(int id);

  Future<List<T>> insertData(T data);

  Future<List<T>> updateData(T data);

  Future<List<T>> deleteData(int id);

}
