import 'package:equatable/equatable.dart';

class PokemonTypeEntity extends Equatable {
  final String name;

  const PokemonTypeEntity({required this.name});

  @override
  List<Object?> get props => [name];
}
