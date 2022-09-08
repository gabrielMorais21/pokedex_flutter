import 'package:equatable/equatable.dart';

class PokemonEntity extends Equatable {
  final int id;
  final String name;
  final int height;
  List<dynamic> type;
  List<dynamic> abilities;
  List<dynamic> form;
  List<dynamic> atacks;
  List<dynamic> stats;
  PokemonEntity({
    required this.id,
    required this.name,
    required this.height,
    required this.type,
    required this.abilities,
    required this.form,
    required this.atacks,
    required this.stats,
  });

  @override
  List<Object?> get props =>
      [id, name, height, type, abilities, form, atacks, stats];
}

class Types {
  int? slot;
  Ability? type;

  Types({this.slot, this.type});

  Types.fromJson(Map<String, dynamic> json) {
    slot = json['slot'];
    type = json['type'] != null ? new Ability.fromJson(json['type']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slot'] = this.slot;
    if (this.type != null) {
      data['type'] = this.type!.toJson();
    }
    return data;
  }
}

class Ability {
  String? name;
  String? url;

  Ability({this.name, this.url});

  Ability.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}
