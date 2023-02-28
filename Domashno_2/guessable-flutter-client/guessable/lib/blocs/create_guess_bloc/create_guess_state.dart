import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';

abstract class CreateGuessState extends Equatable {
  final XFile? locationImage;

  const CreateGuessState({this.locationImage});
}

class CreateGuessInitialState extends CreateGuessState {
  const CreateGuessInitialState() : super();

  @override
  List<Object?> get props => [locationImage];
}

class CreateGuessEmptyState extends CreateGuessState {
  const CreateGuessEmptyState() : super();

  @override
  List<Object?> get props => [locationImage];
}

class CreateGuessPopulatedState extends CreateGuessState {
  const CreateGuessPopulatedState({locationImage}) : super(locationImage: locationImage);

  @override
  List<Object?> get props => [locationImage];
}

class CreateGuessErrorState extends CreateGuessState {
  final String error;

  const CreateGuessErrorState({required this.error}) : super();

  @override
  List<Object?> get props => [error, locationImage];
}
