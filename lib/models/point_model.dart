import 'dart:convert';

class PointModel {
  final String id;
  final String name;
  final String address;
  final String phone;
  final String lat;
  final String lng;
  PointModel({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.lat,
    required this.lng,
  });

  PointModel copyWith({
    String? id,
    String? name,
    String? address,
    String? phone,
    String? lat,
    String? lng,
  }) {
    return PointModel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'phone': phone,
      'lat': lat,
      'lng': lng,
    };
  }

  factory PointModel.fromMap(Map<String, dynamic> map) {
    return PointModel(
      id: map['id'],
      name: map['name'],
      address: map['address'],
      phone: map['phone'],
      lat: map['lat'],
      lng: map['lng'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PointModel.fromJson(String source) => PointModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PointModel(id: $id, name: $name, address: $address,  phone: $phone, lat: $lat, lng: $lng)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is PointModel &&
      other.id == id &&
      other.name == name &&
      other.address == address &&
      other.phone == phone &&
      other.lat == lat &&
      other.lng == lng;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      address.hashCode ^
      phone.hashCode ^
      lat.hashCode ^
      lng.hashCode;
  }
}
