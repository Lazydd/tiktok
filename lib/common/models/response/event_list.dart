class EventListItem {
  String? address;
  String? allocationDes;
  String? allocationTime;
  String? allocator;
  String? approveOpinion;
  String? approver;
  String? areaId;
  String? createTime;
  String? deadlineTime;
  String? eventDes;
  String? eventId;
  List<EventLogVos>? eventLogVos;
  String? eventMethodCode;
  String? eventPictureHandling;
  String? eventPictureReport;
  int? eventStatus;
  String? eventTitle;
  String? eventTypeCode;
  String? executableUnit;
  String? executableUnitName;
  String? executor;
  String? finishTime;
  String? handlingRes;
  bool? isDelete;
  bool? isPlebEvent;
  bool? isSiteApprove;
  bool? isSiteReview;
  String? latitude;
  String? longitude;
  int? reportChannel;
  String? reportUnit;
  String? reportUnitName;
  String? reporter;
  String? reviewOpinion;
  String? reviewer;
  String? superintendant;
  String? supervisingUnit;
  String? supervisingUnitName;
  int? warningStatus;
  String? eventMethodName;
  String? eventTypeName;
  int? rejectStatus;

  EventListItem(
      {this.address,
      this.allocationDes,
      this.allocationTime,
      this.allocator,
      this.approveOpinion,
      this.approver,
      this.areaId,
      this.createTime,
      this.deadlineTime,
      this.eventDes,
      this.eventId,
      this.eventLogVos,
      this.eventMethodCode,
      this.eventPictureHandling,
      this.eventPictureReport,
      this.eventStatus,
      this.eventTitle,
      this.eventTypeCode,
      this.executableUnit,
      this.executableUnitName,
      this.executor,
      this.finishTime,
      this.handlingRes,
      this.isDelete,
      this.isPlebEvent,
      this.isSiteApprove,
      this.isSiteReview,
      this.latitude,
      this.longitude,
      this.reportChannel,
      this.reportUnit,
      this.reportUnitName,
      this.reporter,
      this.reviewOpinion,
      this.reviewer,
      this.superintendant,
      this.supervisingUnit,
      this.supervisingUnitName,
      this.warningStatus,
      this.eventMethodName,
      this.eventTypeName,
      this.rejectStatus});

  EventListItem.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    allocationDes = json['allocationDes'];
    allocationTime = json['allocationTime'];
    allocator = json['allocator'];
    approveOpinion = json['approveOpinion'];
    approver = json['approver'];
    areaId = json['areaId'];
    createTime = json['createTime'];
    deadlineTime = json['deadlineTime'];
    eventDes = json['eventDes'];
    eventId = json['eventId'];
    if (json['eventLogVos'] != null) {
      eventLogVos = <EventLogVos>[];
      json['eventLogVos'].forEach((v) {
        eventLogVos!.add(EventLogVos.fromJson(v));
      });
    }
    eventMethodCode = json['eventMethodCode'];
    eventPictureHandling = json['eventPictureHandling'];
    eventPictureReport = json['eventPictureReport'];
    eventStatus = json['eventStatus'];
    eventTitle = json['eventTitle'];
    eventTypeCode = json['eventTypeCode'];
    executableUnit = json['executableUnit'];
    executableUnitName = json['executableUnitName'];
    executor = json['executor'];
    finishTime = json['finishTime'];
    handlingRes = json['handlingRes'];
    isDelete = json['isDelete'];
    isPlebEvent = json['isPlebEvent'];
    isSiteApprove = json['isSiteApprove'];
    isSiteReview = json['isSiteReview'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    reportChannel = json['reportChannel'];
    reportUnit = json['reportUnit'];
    reportUnitName = json['reportUnitName'];
    reporter = json['reporter'];
    reviewOpinion = json['reviewOpinion'];
    reviewer = json['reviewer'];
    superintendant = json['superintendant'];
    supervisingUnit = json['supervisingUnit'];
    supervisingUnitName = json['supervisingUnitName'];
    warningStatus = json['warningStatus'];
    eventMethodName = json['eventMethodName'];
    eventTypeName = json['eventTypeName'];
    rejectStatus = json['rejectStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['allocationDes'] = allocationDes;
    data['allocationTime'] = allocationTime;
    data['allocator'] = allocator;
    data['approveOpinion'] = approveOpinion;
    data['approver'] = approver;
    data['areaId'] = areaId;
    data['createTime'] = createTime;
    data['deadlineTime'] = deadlineTime;
    data['eventDes'] = eventDes;
    data['eventId'] = eventId;
    if (eventLogVos != null) {
      data['eventLogVos'] = eventLogVos!.map((v) => v.toJson()).toList();
    }
    data['eventMethodCode'] = eventMethodCode;
    data['eventPictureHandling'] = eventPictureHandling;
    data['eventPictureReport'] = eventPictureReport;
    data['eventStatus'] = eventStatus;
    data['eventTitle'] = eventTitle;
    data['eventTypeCode'] = eventTypeCode;
    data['executableUnit'] = executableUnit;
    data['executableUnitName'] = executableUnitName;
    data['executor'] = executor;
    data['finishTime'] = finishTime;
    data['handlingRes'] = handlingRes;
    data['isDelete'] = isDelete;
    data['isPlebEvent'] = isPlebEvent;
    data['isSiteApprove'] = isSiteApprove;
    data['isSiteReview'] = isSiteReview;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['reportChannel'] = reportChannel;
    data['reportUnit'] = reportUnit;
    data['reportUnitName'] = reportUnitName;
    data['reporter'] = reporter;
    data['reviewOpinion'] = reviewOpinion;
    data['reviewer'] = reviewer;
    data['superintendant'] = superintendant;
    data['supervisingUnit'] = supervisingUnit;
    data['supervisingUnitName'] = supervisingUnitName;
    data['warningStatus'] = warningStatus;
    data['eventMethodName'] = eventMethodName;
    data['eventTypeName'] = eventTypeName;
    data['rejectStatus'] = rejectStatus;
    return data;
  }
}

class EventLogVos {
  String? createTime;
  String? doContent;
  String? eventId;
  int? id;
  String? operator;
  String? operatorName;
  String? operatorUnit;
  int? recordType;

  EventLogVos(
      {this.createTime,
      this.doContent,
      this.eventId,
      this.id,
      this.operator,
      this.operatorName,
      this.operatorUnit,
      this.recordType});

  EventLogVos.fromJson(Map<String, dynamic> json) {
    createTime = json['createTime'];
    doContent = json['doContent'];
    eventId = json['eventId'];
    id = json['id'];
    operator = json['operator'];
    operatorName = json['operatorName'];
    operatorUnit = json['operatorUnit'];
    recordType = json['recordType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createTime'] = createTime;
    data['doContent'] = doContent;
    data['eventId'] = eventId;
    data['id'] = id;
    data['operator'] = operator;
    data['operatorName'] = operatorName;
    data['operatorUnit'] = operatorUnit;
    data['recordType'] = recordType;
    return data;
  }
}
