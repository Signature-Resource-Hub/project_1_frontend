class Config {
  String url = "http://10.0.2.2:8000/api/";
  String flaskUrl = "http://10.0.2.2:5000//predict";

  String getUrl() {
    return url;
  }
  String getFlaskUrl() {
    return flaskUrl;
  }
}