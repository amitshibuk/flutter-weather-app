class Weather {
  final String cityName;
  final double temperature;
  final double maxtemperature; 
  final double mintemperature;
  final String mainCondition;
  final int sunrisetime;
  final int sunsettime;
  final int weatherid; 

  Weather({
    required this.cityName,
    required this.temperature,
    required this.maxtemperature,
    required this.mintemperature,
    required this.mainCondition,
    required this.sunrisetime,
    required this.sunsettime,
    required this.weatherid,
    });

    factory Weather.fromJson(Map<String, dynamic> json){
      return Weather(
        cityName: json['name'],
        temperature: json['main']['temp'],
        maxtemperature: json['main']['temp_max'],
        mintemperature: json['main']['temp_min'],
        mainCondition: json['weather'][0]['main'],
        sunrisetime: json['sys']['sunrise'],
        sunsettime: json['sys']['sunset'],
        weatherid: json['weather'][0]['id']
        );
    }
}