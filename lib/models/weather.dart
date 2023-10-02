class Weather {
  int? temp;
  int? feelsLike;
  int? minTemp;
  int? maxTemp;
  int? sunrise;
  int? sunset;

  Weather(
      {this.temp,
      this.feelsLike,
      this.minTemp,
      this.maxTemp,
      this.sunrise,
      this.sunset});

  Weather.fromJson(Map<String, dynamic> json) {
    temp = json['temp'];
    feelsLike = json['feels_like'];
    minTemp = json['min_temp'];
    maxTemp = json['max_temp'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['temp'] = temp;
    data['feels_like'] = feelsLike;
    data['min_temp'] = minTemp;
    data['max_temp'] = maxTemp;
    data['sunrise'] = sunrise;
    data['sunset'] = sunset;
    return data;
  }
}
