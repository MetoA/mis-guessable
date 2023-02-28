import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guessable/blocs/create_guess_bloc/create_guess_event.dart';
import 'package:guessable/blocs/create_guess_bloc/create_guess_state.dart';

class CreateGuessBloc extends Bloc<CreateGuessEvent, CreateGuessState> {
  XFile? locationImage;

  CreateGuessBloc() : super(const CreateGuessInitialState()) {
    on<CreateGuessInitializedEvent>((event, emit) {
      if (locationImage == null) {
        emit(const CreateGuessEmptyState());
      } else {
        emit(CreateGuessPopulatedState(locationImage: locationImage));
      }
    });

    on<CreateGuessLocationImageAddedEvent>((event, emit) {
      locationImage = event.locationImage;
      emit(const CreateGuessPopulatedState());
    });
  }
}
