import 'package:guessable/domain/guess.dart';

abstract class GuessesEvent {}

class GuessesInitializedEvent extends GuessesEvent {}

class GuessSelectedEvent extends GuessesEvent {
  final Guess guess;

  GuessSelectedEvent(this.guess);
}

class GuessAddedEvent extends GuessesEvent {
  final Guess guess;

  GuessAddedEvent({required this.guess});
}
