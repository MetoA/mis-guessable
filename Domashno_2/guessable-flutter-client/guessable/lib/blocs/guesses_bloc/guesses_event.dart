import 'package:guessable/domain/guess.dart';

/// Events that occur related to existing guesses and afterwards cause side effects and state transitions
abstract class GuessesEvent {}

/// An event that occurs when the guesses screen gets initialized
class GuessesInitializedEvent extends GuessesEvent {}

/// An event that occurs when a [guess] has been selected for previewing more information
class GuessSelectedEvent extends GuessesEvent {
  final Guess guess;

  GuessSelectedEvent(this.guess);
}

/// An event that occurs when a new [guess] has been created
class GuessAddedEvent extends GuessesEvent {
  final Guess guess;

  GuessAddedEvent({required this.guess});
}
