import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';

/// State in the application related to creating guesses
///
/// [locationImage] is the captured image from the camera
abstract class CreateGuessState extends Equatable {
  final XFile? locationImage;

  const CreateGuessState({this.locationImage});
}

/// State of the application where the create guess screen was just initialized
class CreateGuessInitialState extends CreateGuessState {
  const CreateGuessInitialState() : super();

  @override
  List<Object?> get props => [locationImage];
}

/// State of the application where an image has not been taken yet
class CreateGuessEmptyState extends CreateGuessState {
  const CreateGuessEmptyState() : super();

  @override
  List<Object?> get props => [locationImage];
}

/// State of the application where an image was taken
class CreateGuessPopulatedState extends CreateGuessState {
  const CreateGuessPopulatedState({locationImage}) : super(locationImage: locationImage);

  @override
  List<Object?> get props => [locationImage];
}

/// State of the application where an error has occurred while creating a guess
class CreateGuessErrorState extends CreateGuessState {
  final String error;

  const CreateGuessErrorState({required this.error}) : super();

  @override
  List<Object?> get props => [error, locationImage];
}
