import 'package:equatable/equatable.dart';

import '../../domain/guess.dart';

/// State in the application related to existing guesses
///
/// [guesses] are the existing guesses for the user
abstract class GuessesState extends Equatable {
  final List<Guess> guesses;

  const GuessesState({required this.guesses});
}

/// State of the application where the guesses screen is initialized
class GuessesInitialState extends GuessesState {
  GuessesInitialState() : super(guesses: []);

  @override
  List<Object?> get props => [guesses];
}

/// State of the application where there are no guesses for the current user
class GuessesEmptyState extends GuessesState {
  GuessesEmptyState() : super(guesses: []);

  @override
  List<Object?> get props => [guesses];
}

/// State of the application where there are existing guesses created by the user
class GuessesPopulatedState extends GuessesState {
  const GuessesPopulatedState({guesses}) : super(guesses: guesses);

  @override
  List<Object?> get props => [guesses];
}

/// State of the application where a guess has been selected and more information is being previewed for it
class GuessSelectedState extends GuessesState {
  final Guess guess;

  GuessSelectedState(this.guess) : super(guesses: []);

  @override
  List<Object?> get props => [guess];
}

/// State of the application where there has been an error related to the guesses
class GuessesErrorState extends GuessesState {
  final String error;

  GuessesErrorState({required this.error}) : super(guesses: []);

  @override
  List<Object?> get props => [error, guesses];
}
