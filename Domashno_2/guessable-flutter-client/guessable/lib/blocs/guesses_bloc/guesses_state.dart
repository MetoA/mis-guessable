import 'package:equatable/equatable.dart';

import '../../domain/guess.dart';

abstract class GuessesState extends Equatable {
  final List<Guess> guesses;

  const GuessesState({required this.guesses});
}

class GuessesInitialState extends GuessesState {
  GuessesInitialState() : super(guesses: []);

  @override
  List<Object?> get props => [guesses];
}

class GuessesEmptyState extends GuessesState {
  GuessesEmptyState() : super(guesses: []);

  @override
  List<Object?> get props => [guesses];
}

class GuessesPopulatedState extends GuessesState {
  const GuessesPopulatedState({guesses}) : super(guesses: guesses);

  @override
  List<Object?> get props => [guesses];
}

class GuessesErrorState extends GuessesState {
  final String error;

  GuessesErrorState({required this.error}) : super(guesses: []);

  @override
  List<Object?> get props => [error, guesses];
}
