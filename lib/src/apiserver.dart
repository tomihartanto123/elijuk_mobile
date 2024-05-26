class ApiServer {
  static Uri url(url) {
    Uri Server = Uri.parse("https://elijuk.tifnganjuk.com/mobile/" + url);
    // Uri Server = Uri.parse("http://192.168.53.207/laravel10/mobile/" + url);
    return Server;
  }

  static Uri urlPublic(url) {
    Uri Server = Uri.parse("https://elijuk.tifnganjuk.com/mobile/" + url);
    // Uri Server = Uri.parse("http://192.168.53.207/laravel10/public/mobile/" + url);
    return Server;
  }

  static Uri urlApi(url) {
    // Uri Server = Uri.parse("http://192.168.1.17:8000/mobile/" + url);
    Uri Server = Uri.parse("https://elijuk.tifnganjuk.com/api/" + url);
    return Server;
  }

  static String urlGetImage = "http://192.168.1.17:8000";
}
