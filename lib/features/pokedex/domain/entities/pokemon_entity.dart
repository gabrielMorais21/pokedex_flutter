import 'package:equatable/equatable.dart';

class PokemonEntity extends Equatable {
  final int id;
  final String name;
  final int height;
  List<Map> type;
  List<Map> abilities;
  List<Map> form;
  List<Map> atacks;
  List<Map> stats;
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
