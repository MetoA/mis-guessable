import 'package:camera/camera.dart';

/// Events that occur related to creating guesses and afterwards cause side effects and state transitions
abstract class CreateGuessEvent {}

/// An event that occurs when the create guess screen is initialized
class CreateGuessInitializedEvent extends CreateGuessEvent {}

/// And event that occurs when a [locationImage] is taken from the camera
class CreateGuessLocationImageAddedEvent extends CreateGuessEvent {
  final XFile locationImage;

  CreateGuessLocationImageAddedEvent({required this.locationImage});
}
