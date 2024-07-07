abstract class DataInterface {
  Future<dynamic> getData();
  Future<void> postData(String data);
  Future<void> updateData(String data, String id);
  Future<void> deleteData(String id);
}
