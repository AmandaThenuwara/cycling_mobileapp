import 'package:google_maps_flutter/google_maps_flutter.dart';

class Ride {
  final String id;
  final String userId;
  final DateTime startTime;
  final DateTime? endTime;
  final RideStatus status;
  final RideStats stats;
  final List<LatLng> route;
  final String? startLocation;
  final String? endLocation;
  final String? notes;
  final List<String> hazardsEncountered;
  final DateTime createdAt;

  Ride({
    required this.id,
    required this.userId,
    required this.startTime,
    this.endTime,
    this.status = RideStatus.active,
    this.stats = const RideStats(),
    this.route = const [],
    this.startLocation,
    this.endLocation,
    this.notes,
    this.hazardsEncountered = const [],
    required this.createdAt,
  });

  factory Ride.fromJson(Map<String, dynamic> json) {
    return Ride(
      id: json['id'] as String,
      userId: json['userId'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] != null
          ? DateTime.parse(json['endTime'] as String)
          : null,
      status: RideStatus.values.firstWhere(
        (status) => status.toString() == 'RideStatus.${json['status']}',
        orElse: () => RideStatus.active,
      ),
      stats: RideStats.fromJson(json['stats'] ?? {}),
      route: (json['route'] as List<dynamic>?)
              ?.map((point) => LatLng(
                    (point['lat'] as num).toDouble(),
                    (point['lng'] as num).toDouble(),
                  ))
              .toList() ??
          [],
      startLocation: json['startLocation'] as String?,
      endLocation: json['endLocation'] as String?,
      notes: json['notes'] as String?,
      hazardsEncountered: List<String>.from(json['hazardsEncountered'] ?? []),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'status': status.toString().split('.').last,
      'stats': stats.toJson(),
      'route': route
          .map((point) => {
                'lat': point.latitude,
                'lng': point.longitude,
              })
          .toList(),
      'startLocation': startLocation,
      'endLocation': endLocation,
      'notes': notes,
      'hazardsEncountered': hazardsEncountered,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  Ride copyWith({
    String? id,
    String? userId,
    DateTime? startTime,
    DateTime? endTime,
    RideStatus? status,
    RideStats? stats,
    List<LatLng>? route,
    String? startLocation,
    String? endLocation,
    String? notes,
    List<String>? hazardsEncountered,
    DateTime? createdAt,
  }) {
    return Ride(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      status: status ?? this.status,
      stats: stats ?? this.stats,
      route: route ?? this.route,
      startLocation: startLocation ?? this.startLocation,
      endLocation: endLocation ?? this.endLocation,
      notes: notes ?? this.notes,
      hazardsEncountered: hazardsEncountered ?? this.hazardsEncountered,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Duration get duration {
    final end = endTime ?? DateTime.now();
    return end.difference(startTime);
  }

  bool get isActive => status == RideStatus.active;
  bool get isCompleted => status == RideStatus.completed;
  bool get isPaused => status == RideStatus.paused;
}

enum RideStatus {
  active,
  paused,
  completed,
  cancelled,
}

class RideStats {
  final double distance;
  final Duration duration;
  final double averageSpeed;
  final double maxSpeed;
  final double calories;
  final double co2Saved;
  final double elevationGain;
  final double elevationLoss;
  final int heartRateAverage;
  final int heartRateMax;

  const RideStats({
    this.distance = 0.0,
    this.duration = Duration.zero,
    this.averageSpeed = 0.0,
    this.maxSpeed = 0.0,
    this.calories = 0.0,
    this.co2Saved = 0.0,
    this.elevationGain = 0.0,
    this.elevationLoss = 0.0,
    this.heartRateAverage = 0,
    this.heartRateMax = 0,
  });

  factory RideStats.fromJson(Map<String, dynamic> json) {
    return RideStats(
      distance: (json['distance'] as num?)?.toDouble() ?? 0.0,
      duration: Duration(seconds: json['durationSeconds'] as int? ?? 0),
      averageSpeed: (json['averageSpeed'] as num?)?.toDouble() ?? 0.0,
      maxSpeed: (json['maxSpeed'] as num?)?.toDouble() ?? 0.0,
      calories: (json['calories'] as num?)?.toDouble() ?? 0.0,
      co2Saved: (json['co2Saved'] as num?)?.toDouble() ?? 0.0,
      elevationGain: (json['elevationGain'] as num?)?.toDouble() ?? 0.0,
      elevationLoss: (json['elevationLoss'] as num?)?.toDouble() ?? 0.0,
      heartRateAverage: json['heartRateAverage'] as int? ?? 0,
      heartRateMax: json['heartRateMax'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'distance': distance,
      'durationSeconds': duration.inSeconds,
      'averageSpeed': averageSpeed,
      'maxSpeed': maxSpeed,
      'calories': calories,
      'co2Saved': co2Saved,
      'elevationGain': elevationGain,
      'elevationLoss': elevationLoss,
      'heartRateAverage': heartRateAverage,
      'heartRateMax': heartRateMax,
    };
  }

  RideStats copyWith({
    double? distance,
    Duration? duration,
    double? averageSpeed,
    double? maxSpeed,
    double? calories,
    double? co2Saved,
    double? elevationGain,
    double? elevationLoss,
    int? heartRateAverage,
    int? heartRateMax,
  }) {
    return RideStats(
      distance: distance ?? this.distance,
      duration: duration ?? this.duration,
      averageSpeed: averageSpeed ?? this.averageSpeed,
      maxSpeed: maxSpeed ?? this.maxSpeed,
      calories: calories ?? this.calories,
      co2Saved: co2Saved ?? this.co2Saved,
      elevationGain: elevationGain ?? this.elevationGain,
      elevationLoss: elevationLoss ?? this.elevationLoss,
      heartRateAverage: heartRateAverage ?? this.heartRateAverage,
      heartRateMax: heartRateMax ?? this.heartRateMax,
    );
  }

  String get formattedDistance {
    if (distance < 1) {
      return '${(distance * 1000).toStringAsFixed(0)}m';
    }
    return '${distance.toStringAsFixed(1)}km';
  }

  String get formattedDuration {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;
    
    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  String get formattedAverageSpeed {
    return '${averageSpeed.toStringAsFixed(1)} km/h';
  }

  String get formattedMaxSpeed {
    return '${maxSpeed.toStringAsFixed(1)} km/h';
  }

  String get formattedCalories {
    return '${calories.toStringAsFixed(0)} cal';
  }

  String get formattedCo2Saved {
    return '${co2Saved.toStringAsFixed(1)} kg';
  }

  String get formattedElevationGain {
    return '${elevationGain.toStringAsFixed(0)}m';
  }

  String get formattedElevationLoss {
    return '${elevationLoss.toStringAsFixed(0)}m';
  }

  double get pace {
    if (distance == 0) return 0;
    return duration.inMinutes / distance;
  }

  String get formattedPace {
    if (pace == 0) return '--:--';
    final minutes = pace.floor();
    final seconds = ((pace - minutes) * 60).round();
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
