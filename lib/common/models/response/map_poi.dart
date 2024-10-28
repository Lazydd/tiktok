class MapPoiModel {
  dynamic id;
  dynamic address;
  dynamic name;
  dynamic location;
  dynamic distance;
  dynamic type;

  MapPoiModel({
    this.id,
    this.address,
    this.name,
    this.location,
    this.distance,
    this.type,
  });

  MapPoiModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    name = json['name'];
    location = json['location'];
    distance = json['distance'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['address'] = address;
    data['name'] = name;
    data['location'] = location;
    data['distance'] = distance;
    data['type'] = type;
    return data;
  }
}
