import 'package:guessable/domain/guess.dart';

abstract class GuessesEvent {}

class GuessesInitializedEvent extends GuessesEvent {}

class GuessAddedEvent extends GuessesEvent {
  final Guess guess;

  GuessAddedEvent({required this.guess});
}