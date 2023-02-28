import 'package:camera/camera.dart';

abstract class CreateGuessEvent {}

class CreateGuessInitializedEvent extends CreateGuessEvent {}

class CreateGuessLocationImageAddedEvent extends CreateGuessEvent {
  final XFile locationImage;

  CreateGuessLocationImageAddedEvent({required this.locationImage});
}
