// lib/models/weather_alert.dart

class WeatherAlert {
  final String senderName; 
  final String event;
  final String description;
  final int start;
  final int end;
  final List<String>? tags; 

  WeatherAlert({
    required this.senderName,
    required this.event,
    required this.description,
    required this.start,
    required this.end,
    this.tags,
  });

  factory WeatherAlert.fromJson(Map<String, dynamic> json) {
    return WeatherAlert(
      senderName: json['sender_name'] ?? '',
      event: json['event'] ?? '',
      description: json['description'] ?? '',
      start: json['start']?.toInt() ?? 0,
      end: json['end']?.toInt() ?? 0,
      tags: (json['tags'] as List?)?.map((tag) => tag as String).toList(),  // Map tags to List<String>
    );
  }
}
