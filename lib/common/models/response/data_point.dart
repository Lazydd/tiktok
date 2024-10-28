class DataPoiModel {
  String? areaId;
  String? areaName;
  String? createTime;
  String? eventMethodCode;
  String? eventMethodCodeName;
  String? eventTypeCode;
  String? eventTypeCodeName;
  bool? isDelete;
  double? latitude;
  double? longitude;
  String? nodeId;
  String? periodValidity;
  String? pointId;
  double? distance;

  DataPoiModel({
    this.areaId,
    this.areaName,
    this.createTime,
    this.eventMethodCode,
    this.eventMethodCodeName,
    this.eventTypeCode,
    this.eventTypeCodeName,
    this.isDelete,
    this.latitude,
    this.longitude,
    this.nodeId,
    this.periodValidity,
    this.pointId,
    this.distance,
  });

  DataPoiModel.fromJson(Map<String, dynamic> json) {
    areaId = json['areaId'];
    areaName = json['areaName'];
    createTime = json['createTime'];
    eventMethodCode = json['eventMethodCode'];
    eventMethodCodeName = json['eventMethodCodeName'];
    eventTypeCode = json['eventTypeCode'];
    eventTypeCodeName = json['eventTypeCodeName'];
    isDelete = json['isDelete'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    nodeId = json['nodeId'];
    periodValidity = json['periodValidity'];
    pointId = json['pointId'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['areaId'] = areaId;
    data['areaName'] = areaName;
    data['createTime'] = createTime;
    data['eventMethodCode'] = eventMethodCode;
    data['eventMethodCodeName'] = eventMethodCodeName;
    data['eventTypeCode'] = eventTypeCode;
    data['eventTypeCodeName'] = eventTypeCodeName;
    data['isDelete'] = isDelete;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['nodeId'] = nodeId;
    data['periodValidity'] = periodValidity;
    data['pointId'] = pointId;
    data['distance'] = distance;
    return data;
  }
}
