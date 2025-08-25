class User {
  final String id;
  final String name;
  final String email;
  final String? profileImage;
  final String? phoneNumber;
  final CyclingLevel cyclingLevel;
  final List<String> emergencyContacts;
  final UserStats stats;
  final List<String> achievements;
  final DateTime createdAt;
  final DateTime? lastActive;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.profileImage,
    this.phoneNumber,
    this.cyclingLevel = CyclingLevel.beginner,
    this.emergencyContacts = const [],
    this.stats = const UserStats(),
    this.achievements = const [],
    required this.createdAt,
    this.lastActive,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      profileImage: json['profileImage'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      cyclingLevel: CyclingLevel.values.firstWhere(
        (level) => level.toString() == 'CyclingLevel.${json['cyclingLevel']}',
        orElse: () => CyclingLevel.beginner,
      ),
      emergencyContacts: List<String>.from(json['emergencyContacts'] ?? []),
      stats: UserStats.fromJson(json['stats'] ?? {}),
      achievements: List<String>.from(json['achievements'] ?? []),
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastActive: json['lastActive'] != null
          ? DateTime.parse(json['lastActive'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profileImage': profileImage,
      'phoneNumber': phoneNumber,
      'cyclingLevel': cyclingLevel.toString().split('.').last,
      'emergencyContacts': emergencyContacts,
      'stats': stats.toJson(),
      'achievements': achievements,
      'createdAt': createdAt.toIso8601String(),
      'lastActive': lastActive?.toIso8601String(),
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? profileImage,
    String? phoneNumber,
    CyclingLevel? cyclingLevel,
    List<String>? emergencyContacts,
    UserStats? stats,
    List<String>? achievements,
    DateTime? createdAt,
    DateTime? lastActive,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      cyclingLevel: cyclingLevel ?? this.cyclingLevel,
      emergencyContacts: emergencyContacts ?? this.emergencyContacts,
      stats: stats ?? this.stats,
      achievements: achievements ?? this.achievements,
      createdAt: createdAt ?? this.createdAt,
      lastActive: lastActive ?? this.lastActive,
    );
  }
}

enum CyclingLevel {
  beginner,
  intermediate,
  advanced,
  expert,
}

extension CyclingLevelExtension on CyclingLevel {
  String get displayName {
    switch (this) {
      case CyclingLevel.beginner:
        return 'Beginner';
      case CyclingLevel.intermediate:
        return 'Intermediate';
      case CyclingLevel.advanced:
        return 'Advanced';
      case CyclingLevel.expert:
        return 'Expert';
    }
  }

  String get description {
    switch (this) {
      case CyclingLevel.beginner:
        return 'New to cycling, learning the basics';
      case CyclingLevel.intermediate:
        return 'Comfortable with cycling, exploring new routes';
      case CyclingLevel.advanced:
        return 'Experienced cyclist, challenging routes';
      case CyclingLevel.expert:
        return 'Professional level, all types of terrain';
    }
  }
}

class UserStats {
  final double totalDistance;
  final int totalRides;
  final double totalCalories;
  final double totalCo2Saved;
  final Duration totalTime;
  final double averageSpeed;
  final int currentStreak;
  final int longestStreak;
  final DateTime? lastRideDate;

  const UserStats({
    this.totalDistance = 0.0,
    this.totalRides = 0,
    this.totalCalories = 0.0,
    this.totalCo2Saved = 0.0,
    this.totalTime = Duration.zero,
    this.averageSpeed = 0.0,
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.lastRideDate,
  });

  factory UserStats.fromJson(Map<String, dynamic> json) {
    return UserStats(
      totalDistance: (json['totalDistance'] as num?)?.toDouble() ?? 0.0,
      totalRides: json['totalRides'] as int? ?? 0,
      totalCalories: (json['totalCalories'] as num?)?.toDouble() ?? 0.0,
      totalCo2Saved: (json['totalCo2Saved'] as num?)?.toDouble() ?? 0.0,
      totalTime: Duration(seconds: json['totalTimeSeconds'] as int? ?? 0),
      averageSpeed: (json['averageSpeed'] as num?)?.toDouble() ?? 0.0,
      currentStreak: json['currentStreak'] as int? ?? 0,
      longestStreak: json['longestStreak'] as int? ?? 0,
      lastRideDate: json['lastRideDate'] != null
          ? DateTime.parse(json['lastRideDate'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalDistance': totalDistance,
      'totalRides': totalRides,
      'totalCalories': totalCalories,
      'totalCo2Saved': totalCo2Saved,
      'totalTimeSeconds': totalTime.inSeconds,
      'averageSpeed': averageSpeed,
      'currentStreak': currentStreak,
      'longestStreak': longestStreak,
      'lastRideDate': lastRideDate?.toIso8601String(),
    };
  }

  UserStats copyWith({
    double? totalDistance,
    int? totalRides,
    double? totalCalories,
    double? totalCo2Saved,
    Duration? totalTime,
    double? averageSpeed,
    int? currentStreak,
    int? longestStreak,
    DateTime? lastRideDate,
  }) {
    return UserStats(
      totalDistance: totalDistance ?? this.totalDistance,
      totalRides: totalRides ?? this.totalRides,
      totalCalories: totalCalories ?? this.totalCalories,
      totalCo2Saved: totalCo2Saved ?? this.totalCo2Saved,
      totalTime: totalTime ?? this.totalTime,
      averageSpeed: averageSpeed ?? this.averageSpeed,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      lastRideDate: lastRideDate ?? this.lastRideDate,
    );
  }

  String get formattedTotalDistance {
    if (totalDistance < 1) {
      return '${(totalDistance * 1000).toStringAsFixed(0)}m';
    }
    return '${totalDistance.toStringAsFixed(1)}km';
  }

  String get formattedTotalTime {
    final hours = totalTime.inHours;
    final minutes = totalTime.inMinutes % 60;
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    }
    return '${minutes}m';
  }

  String get formattedAverageSpeed {
    return '${averageSpeed.toStringAsFixed(1)} km/h';
  }

  String get formattedTotalCalories {
    return '${totalCalories.toStringAsFixed(0)} cal';
  }

  String get formattedTotalCo2Saved {
    return '${totalCo2Saved.toStringAsFixed(1)} kg';
  }
}
