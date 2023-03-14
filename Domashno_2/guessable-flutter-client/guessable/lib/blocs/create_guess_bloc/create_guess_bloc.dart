import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guessable/blocs/create_guess_bloc/create_guess_event.dart';
import 'package:guessable/blocs/create_guess_bloc/create_guess_state.dart';

/// Bloc for creating guess events with side effects and state transitions
///
/// [locationImage] is the current image taken by the camera when creating a guessable location
class CreateGuessBloc extends Bloc<CreateGuessEvent, CreateGuessState> {
  XFile? locationImage;

  /// On initialization of the create guess screen, transition to the correct state depending if an image was already taken
  CreateGuessBloc() : super(const CreateGuessInitialState()) {
    on<CreateGuessInitializedEvent>((event, emit) {
      if (locationImage == null) {
        emit(const CreateGuessEmptyState());
      } else {
        emit(CreateGuessPopulatedState(locationImage: locationImage));
      }
    });

    /// When taking an image from the camera, transition to the correct state
    on<CreateGuessLocationImageAddedEvent>((event, emit) {
      locationImage = event.locationImage;
      emit(const CreateGuessPopulatedState());
    });
  }
}
