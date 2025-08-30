class URL{
  static const String _baseUrl = 'http://35.73.30.144:2008/api/v1';
  static const String getProductUrl = '$_baseUrl/ReadProduct';// read er url
  static String getDeleteUrl(String id) => '$_baseUrl/DeleteProduct/$id';
  static String postUpdate(String id) => '$_baseUrl/UpdateProduct/$id';

}