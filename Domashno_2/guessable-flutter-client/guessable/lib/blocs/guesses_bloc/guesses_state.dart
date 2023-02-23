import '../../domain/guess.dart';

abstract class GuessesState {
  List<Guess> guesses;

  GuessesState({required this.guesses});
}

class GuessesInitialState extends GuessesState {
  GuessesInitialState() : super(guesses: []);
}

class GuessesEmptyState extends GuessesState {
  GuessesEmptyState() : super(guesses: []);
}

class GuessesPopulatedState extends GuessesState {
  GuessesPopulatedState({guesses}) : super(guesses: guesses);
}

class GuessesErrorState extends GuessesState {
  final String error;

  GuessesErrorState({required this.error}) : super(guesses: []);
}