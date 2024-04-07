/// cityEntity : [{"province":"北京市","name":"市辖区","id":"110100000000"}]
library;

class CityListMap {
  CityListMap({this.cityEntity});

  CityListMap.fromJson(Map<String, dynamic> json) {
    if (json['cityEntity'] != null) {
      cityEntity = [];
      for (var v in json['cityEntity']!) {
        cityEntity?.add(CityEntity.fromJson(v));
      }
    }
  }
  List<CityEntity>? cityEntity;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (cityEntity != null) {
      map['cityEntity'] = cityEntity?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// province : "北京市"
/// name : "市辖区"
/// id : "110100000000"

class CityEntity {
  CityEntity({
    this.province,
    this.name,
    this.id,
  });

  CityEntity.fromJson(json) {
    province = json['province'] as String;
    name = json['name'] as String;
    id = json['id'] as String;
  }
  String? province;
  String? name;
  String? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['province'] = province;
    map['name'] = name;
    map['id'] = id;
    return map;
  }
}
