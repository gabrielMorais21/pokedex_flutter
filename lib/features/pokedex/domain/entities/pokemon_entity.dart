import 'package:equatable/equatable.dart';

class PokemonEntity extends Equatable {
  final int id;
  final String name;
  final int height;
  final Map sprites;
  final List<dynamic> type;
  final List<dynamic> abilities;
  final List<dynamic> form;
  final List<dynamic> atacks;
  final List<dynamic> stats;
  const PokemonEntity({
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
