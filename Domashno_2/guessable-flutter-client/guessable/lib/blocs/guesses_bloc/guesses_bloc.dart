import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guessable/api/guess_api.dart';
import 'package:guessable/api/status_codes_extensions.dart';
import 'package:guessable/blocs/guesses_bloc/guesses_event.dart';
import 'package:guessable/blocs/guesses_bloc/guesses_state.dart';

import '../../domain/guess.dart';

class GuessesBloc extends Bloc<GuessesEvent, GuessesState> {
  List<Guess> _guesses = [];

  GuessesBloc() : super(GuessesInitialState()) {
    on<GuessesInitializedEvent>((event, emit) async {
      var response = await GuessAPI.myGuesses();

      if (response.statusCode.isSuccessful) {
        _guesses = List<String>.from(json.decode(response.body)).map((it) => Guess.fromJson(jsonDecode(it))).toList();
        if (_guesses.isEmpty) {
          emit(GuessesEmptyState());
        } else {
          emit(GuessesPopulatedState(guesses: _guesses));
        }
      } else {
        emit(GuessesErrorState(error: 'Error fetching guesses!'));
      }
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
