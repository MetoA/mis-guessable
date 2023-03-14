import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guessable/api/guess_api.dart';
import 'package:guessable/blocs/guesses_bloc/guesses_event.dart';
import 'package:guessable/blocs/guesses_bloc/guesses_state.dart';

import '../../domain/guess.dart';

/// Bloc for guesses events with side effects and state transitions
///
/// [_guesses] are the existing guesses the user has made
class GuessesBloc extends Bloc<GuessesEvent, GuessesState> {
  List<Guess> _guesses = [];

  GuessesBloc() : super(GuessesInitialState()) {

    /// An event that occurs when the screen is initialized. An API call gets made to get all of the user's guesses and populates the state
    on<GuessesInitializedEvent>((event, emit) async {
      try {
        _guesses = await GuessAPI.myGuesses();
        if (_guesses.isEmpty) {
          emit(GuessesEmptyState());
        } else {
          emit(GuessesPopulatedState(guesses: _guesses));
        }
      } catch (e) {
        emit(GuessesErrorState(error: e.toString()));
      }
    });

    /// An event that occurs when an existing guess gets selected to have more information previewed about it
    on<GuessSelectedEvent>((event, emit) {
      emit(GuessSelectedState(event.guess));
    });

    /// An event that occurs when a new guess has been made
    on<GuessAddedEvent>((event, emit) async {
      _guesses.add(event.guess);
      emit(GuessesPopulatedState(guesses: _guesses));
    });
  }
}
