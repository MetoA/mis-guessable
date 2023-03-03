import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guessable/api/guess_api.dart';
import 'package:guessable/blocs/guesses_bloc/guesses_event.dart';
import 'package:guessable/blocs/guesses_bloc/guesses_state.dart';

import '../../domain/guess.dart';

class GuessesBloc extends Bloc<GuessesEvent, GuessesState> {
  List<Guess> _guesses = [];

  GuessesBloc() : super(GuessesInitialState()) {
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

    on<GuessSelectedEvent>((event, emit) {
      emit(GuessSelectedState(event.guess));
    });

    on<GuessAddedEvent>((event, emit) async {
      // TODO
      // make api call
      // if successful add guess to list
      _guesses.add(event.guess);
      emit(GuessesPopulatedState(guesses: _guesses));
      // else error state
      // emit(GuessesErrorState(error: 'Error creating guess'));
    });
  }
}
