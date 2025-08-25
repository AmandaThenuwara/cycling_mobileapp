import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Hazard {
  final String id;
  final String reporterId;
  final String reporterName;
  final HazardType type;
  final String description;
  final LatLng location;
  final String? address;
  final String? imageUrl;
  final HazardSeverity severity;
  final HazardStatus status;
  final int upvotes;
  final int downvotes;
  final List<String> confirmedBy;
  final List<String> resolvedBy;
  final DateTime reportedAt;
  final DateTime? resolvedAt;
  final DateTime? expiresAt;

  Hazard({
    required this.id,
    required this.reporterId,
    required this.reporterName,
    required this.type,
    required this.description,
    required this.location,
    this.address,
    this.imageUrl,
    this.severity = HazardSeverity.medium,
    this.status = HazardStatus.active,
    this.upvotes = 0,
    this.downvotes = 0,
    this.confirmedBy = const [],
    this.resolvedBy = const [],
    required this.reportedAt,
    this.resolvedAt,
    this.expiresAt,
  });

  factory Hazard.fromJson(Map<String, dynamic> json) {
    return Hazard(
      id: json['id'] as String,
      reporterId: json['reporterId'] as String,
      reporterName: json['reporterName'] as String,
      type: HazardType.values.firstWhere(
        (type) => type.toString() == 'HazardType.${json['type']}',
        orElse: () => HazardType.other,
      ),
      description: json['description'] as String,
      location: LatLng(
        (json['location']['lat'] as num).toDouble(),
        (json['location']['lng'] as num).toDouble(),
      ),
      address: json['address'] as String?,
      imageUrl: json['imageUrl'] as String?,
      severity: HazardSeverity.values.firstWhere(
        (severity) => severity.toString() == 'HazardSeverity.${json['severity']}',
        orElse: () => HazardSeverity.medium,
      ),
      status: HazardStatus.values.firstWhere(
        (status) => status.toString() == 'HazardStatus.${json['status']}',
        orElse: () => HazardStatus.active,
      ),
      upvotes: json['upvotes'] as int? ?? 0,
      downvotes: json['downvotes'] as int? ?? 0,
      confirmedBy: List<String>.from(json['confirmedBy'] ?? []),
      resolvedBy: List<String>.from(json['resolvedBy'] ?? []),
      reportedAt: DateTime.parse(json['reportedAt'] as String),
      resolvedAt: json['resolvedAt'] != null
          ? DateTime.parse(json['resolvedAt'] as String)
          : null,
      expiresAt: json['expiresAt'] != null
          ? DateTime.parse(json['expiresAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reporterId': reporterId,
      'reporterName': reporterName,
      'type': type.toString().split('.').last,
      'description': description,
      'location': {
        'lat': location.latitude,
        'lng': location.longitude,
      },
      'address': address,
      'imageUrl': imageUrl,
      'severity': severity.toString().split('.').last,
      'status': status.toString().split('.').last,
      'upvotes': upvotes,
      'downvotes': downvotes,
      'confirmedBy': confirmedBy,
      'resolvedBy': resolvedBy,
      'reportedAt': reportedAt.toIso8601String(),
      'resolvedAt': resolvedAt?.toIso8601String(),
      'expiresAt': expiresAt?.toIso8601String(),
    };
  }

  Hazard copyWith({
    String? id,
    String? reporterId,
    String? reporterName,
    HazardType? type,
    String? description,
    LatLng? location,
    String? address,
    String? imageUrl,
    HazardSeverity? severity,
    HazardStatus? status,
    int? upvotes,
    int? downvotes,
    List<String>? confirmedBy,
    List<String>? resolvedBy,
    DateTime? reportedAt,
    DateTime? resolvedAt,
    DateTime? expiresAt,
  }) {
    return Hazard(
      id: id ?? this.id,
      reporterId: reporterId ?? this.reporterId,
      reporterName: reporterName ?? this.reporterName,
      type: type ?? this.type,
      description: description ?? this.description,
      location: location ?? this.location,
      address: address ?? this.address,
      imageUrl: imageUrl ?? this.imageUrl,
      severity: severity ?? this.severity,
      status: status ?? this.status,
      upvotes: upvotes ?? this.upvotes,
      downvotes: downvotes ?? this.downvotes,
      confirmedBy: confirmedBy ?? this.confirmedBy,
      resolvedBy: resolvedBy ?? this.resolvedBy,
      reportedAt: reportedAt ?? this.reportedAt,
      resolvedAt: resolvedAt ?? this.resolvedAt,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }

  int get netVotes => upvotes - downvotes;
  bool get isActive => status == HazardStatus.active;
  bool get isResolved => status == HazardStatus.resolved;
  bool get isExpired => expiresAt != null && DateTime.now().isAfter(expiresAt!);
  bool get isConfirmed => confirmedBy.length >= 3; // At least 3 confirmations
  Duration get age => DateTime.now().difference(reportedAt);
}

enum HazardType {
  pothole,
  unsafeRoad,
  heavyTraffic,
  theftProne,
  poorLighting,
  construction,
  weatherHazard,
  other,
}

enum HazardSeverity {
  low,
  medium,
  high,
  critical,
}

enum HazardStatus {
  active,
  confirmed,
  resolved,
  expired,
}

extension HazardTypeExtension on HazardType {
  String get displayName {
    switch (this) {
      case HazardType.pothole:
        return 'Pothole';
      case HazardType.unsafeRoad:
        return 'Unsafe Road';
      case HazardType.heavyTraffic:
        return 'Heavy Traffic';
      case HazardType.theftProne:
        return 'Theft Prone Area';
      case HazardType.poorLighting:
        return 'Poor Lighting';
      case HazardType.construction:
        return 'Construction';
      case HazardType.weatherHazard:
        return 'Weather Hazard';
      case HazardType.other:
        return 'Other';
    }
  }

  String get description {
    switch (this) {
      case HazardType.pothole:
        return 'Road surface damage that could cause accidents';
      case HazardType.unsafeRoad:
        return 'Road conditions that make cycling dangerous';
      case HazardType.heavyTraffic:
        return 'High traffic volume making cycling difficult';
      case HazardType.theftProne:
        return 'Area with high risk of bicycle theft';
      case HazardType.poorLighting:
        return 'Insufficient lighting for safe cycling';
      case HazardType.construction:
        return 'Ongoing construction affecting cycling route';
      case HazardType.weatherHazard:
        return 'Weather-related hazards (flooding, ice, etc.)';
      case HazardType.other:
        return 'Other safety concerns';
    }
  }

  IconData get icon {
    switch (this) {
      case HazardType.pothole:
        return Icons.terrain;
      case HazardType.unsafeRoad:
        return Icons.warning;
      case HazardType.heavyTraffic:
        return Icons.directions_car;
      case HazardType.theftProne:
        return Icons.security;
      case HazardType.poorLighting:
        return Icons.lightbulb_outline;
      case HazardType.construction:
        return Icons.construction;
      case HazardType.weatherHazard:
        return Icons.cloud;
      case HazardType.other:
        return Icons.report_problem;
    }
  }

  Color get color {
    switch (this) {
      case HazardType.pothole:
        return Colors.orange;
      case HazardType.unsafeRoad:
        return Colors.red;
      case HazardType.heavyTraffic:
        return Colors.yellow;
      case HazardType.theftProne:
        return Colors.purple;
      case HazardType.poorLighting:
        return Colors.blue;
      case HazardType.construction:
        return Colors.brown;
      case HazardType.weatherHazard:
        return Colors.cyan;
      case HazardType.other:
        return Colors.grey;
    }
  }
}

extension HazardSeverityExtension on HazardSeverity {
  String get displayName {
    switch (this) {
      case HazardSeverity.low:
        return 'Low';
      case HazardSeverity.medium:
        return 'Medium';
      case HazardSeverity.high:
        return 'High';
      case HazardSeverity.critical:
        return 'Critical';
    }
  }

  Color get color {
    switch (this) {
      case HazardSeverity.low:
        return Colors.green;
      case HazardSeverity.medium:
        return Colors.orange;
      case HazardSeverity.high:
        return Colors.red;
      case HazardSeverity.critical:
        return Colors.purple;
    }
  }
}

extension HazardStatusExtension on HazardStatus {
  String get displayName {
    switch (this) {
      case HazardStatus.active:
        return 'Active';
      case HazardStatus.confirmed:
        return 'Confirmed';
      case HazardStatus.resolved:
        return 'Resolved';
      case HazardStatus.expired:
        return 'Expired';
    }
  }

  Color get color {
    switch (this) {
      case HazardStatus.active:
        return Colors.red;
      case HazardStatus.confirmed:
        return Colors.orange;
      case HazardStatus.resolved:
        return Colors.green;
      case HazardStatus.expired:
        return Colors.grey;
    }
  }
}
