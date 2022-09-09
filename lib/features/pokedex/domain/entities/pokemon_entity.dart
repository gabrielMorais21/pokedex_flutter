import 'package:equatable/equatable.dart';

class PokemonEntity extends Equatable {
  final int id;
  final String name;
  final int height;
  final Map sprites;
  List<dynamic> type;
  List<dynamic> abilities;
  List<dynamic> form;
  List<dynamic> atacks;
  List<dynamic> stats;
  PokemonEntity({
    required this.id,
    required this.name,
    required this.height,
    required this.sprites,
    required this.type,
    required this.abilities,
    required this.form,
    required this.atacks,
    required this.stats,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        height,
        sprites,
        type,
        abilities,
        form,
        atacks,
        stats,
      ];
}
