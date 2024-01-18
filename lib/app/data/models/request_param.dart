// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:flutter/foundation.dart';

class RequestParam {
  String? flagId;
  String? flagDetailId;
  String? dateLatest;
  String? salesmanId;
  String? teamleaderId;
  String? merchandiserId;
  String? branchId;
  String? rayonId;
  String? srId;
  List<int>? areaId;
  String? salesmanType;
  String? loginAt;
  String? dateStart;
  String? dateEnd;
  String? customerId;
  List<String>? dateRange;
  RequestParam({
    this.flagId,
    this.flagDetailId,
    this.dateLatest,
    this.salesmanId,
    this.teamleaderId,
    this.merchandiserId,
    this.branchId,
    this.rayonId,
    this.srId,
    this.areaId,
    this.salesmanType,
    this.loginAt,
    this.dateStart,
    this.dateEnd,
    this.dateRange,
    this.customerId,
  });

  RequestParam copyWith({
    String? flagId,
    String? flagDetailId,
    String? dateLatest,
    String? salesmanId,
    String? branchId,
    String? rayonId,
    String? srId,
    List<int>? areaId,
    String? salesmanType,
    String? teamleaderId,
    String? merchandiserId,
    String? loginAt,
    String? dateStart,
    String? dateEnd,
    List<String>? dateRange,
    String? customerId,
  }) {
    return RequestParam(
      flagId: flagId ?? this.flagId,
      flagDetailId: flagDetailId ?? this.flagDetailId,
      dateLatest: dateLatest ?? this.dateLatest,
      salesmanId: salesmanId ?? this.salesmanId,
      teamleaderId: teamleaderId ?? this.teamleaderId,
      merchandiserId: merchandiserId ?? this.merchandiserId,
      branchId: branchId ?? this.branchId,
      rayonId: rayonId ?? this.rayonId,
      srId: srId ?? this.srId,
      areaId: areaId ?? this.areaId,
      salesmanType: salesmanType ?? this.salesmanType,
      loginAt: loginAt ?? this.loginAt,
      dateStart: dateStart ?? this.dateStart,
      dateEnd: dateEnd ?? this.dateEnd,
      dateRange: dateRange ?? this.dateRange,
      customerId: customerId ?? this.customerId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'flagId': flagId,
      'flagDetailId': flagDetailId,
      'dateLatest': dateLatest,
      'salesmanId': salesmanId,
      'teamleaderId': teamleaderId,
      'merchandiserId': merchandiserId,
      'branchId': branchId,
      'rayonId': rayonId,
      'srId': srId,
      'areaId': areaId?.map((e) => e.toString()).toList(),
      'salesmanType': salesmanType,
      'loginAt': loginAt,
      'dateStart': dateStart,
      'dateEnd': dateEnd,
      'dateRange': dateRange,
      'customerId': customerId,
    };
  }

  factory RequestParam.fromMap(Map<String, dynamic> map) {
    return RequestParam(
      flagId: map['flagId'] != null ? map['flagId'] as String : null,
      flagDetailId: map['flagDetailId'] != null ? map['flagDetailId'] as String : null,
      dateLatest: map['dateLatest'] != null ? map['dateLatest'] as String : null,
      salesmanId: map['salesmanId'] != null ? map['salesmanId'] as String : null,
      teamleaderId: map['teamleaderId'] != null ? map['teamleaderId'] as String : null,
      merchandiserId: map['merchandiserId'] != null ? map['merchandiserId'] as String : null,
      branchId: map['branchId'] != null ? map['branchId'] as String : null,
      rayonId: map['rayonId'] != null ? map['rayonId'] as String : null,
      srId: map['srId'] != null ? map['srId'] as String : null,
      salesmanType: map['salesmanType'] != null ? map['salesmanType'] as String : null,
      loginAt: map['loginAt'] != null ? map['loginAt'] as String : null,
      dateStart: map['dateStart'] != null ? map['dateStart'] as String : null,
      dateEnd: map['dateEnd'] != null ? map['dateEnd'] as String : null,
      dateRange: map['dateRange'] != null ? List<String>.from((map['dateRange'] as List<String>)) : [],
      customerId: map['customerId'] != null ? map['customerId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestParam.fromJson(String source) => RequestParam.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RequestParam(flagId: $flagId, flagDetailId: $flagDetailId, dateLatest: $dateLatest, salesmanId: $salesmanId, teamleaderId: $teamleaderId, merchandiserId: $merchandiserId,branchId: $branchId,rayonId: $rayonId,srId: $srId, salesmanType: $salesmanType, loginAt: $loginAt, dateStart: $dateStart, dateEnd: $dateEnd, dateRange: $dateRange, customerId: $customerId)';
  }

  @override
  bool operator ==(covariant RequestParam other) {
    if (identical(this, other)) return true;

    return other.flagId == flagId &&
        other.flagDetailId == flagDetailId &&
        other.dateLatest == dateLatest &&
        other.salesmanId == salesmanId &&
        other.teamleaderId == teamleaderId &&
        other.merchandiserId == merchandiserId &&
        other.branchId == branchId &&
        other.rayonId == rayonId &&
        other.srId == srId &&
        other.areaId == areaId &&
        other.salesmanType == salesmanType &&
        other.loginAt == loginAt &&
        other.dateStart == dateStart &&
        other.dateEnd == dateEnd &&
        other.customerId == customerId &&
        listEquals(other.dateRange, dateRange);
  }

  @override
  int get hashCode {
    return flagId.hashCode ^
        flagDetailId.hashCode ^
        dateLatest.hashCode ^
        salesmanId.hashCode ^
        teamleaderId.hashCode ^
        branchId.hashCode ^
        rayonId.hashCode ^
        srId.hashCode ^
        areaId.hashCode ^
        salesmanType.hashCode ^
        loginAt.hashCode ^
        dateStart.hashCode ^
        dateEnd.hashCode ^
        dateRange.hashCode ^
        customerId.hashCode;
  }
}
