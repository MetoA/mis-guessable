import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guessable/blocs/create_guess_bloc/create_guess_bloc.dart';
import 'package:guessable/blocs/create_guess_bloc/create_guess_event.dart';

class CameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  const CameraScreen({super.key, required this.cameras});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;

  @override
  void initState() {
    super.initState();
    initCamera(widget.cameras[0]);
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _cameraController.value.isInitialized
            ? CameraPreview(
                _cameraController,
                child: IconButton(
                  onPressed: takePicture,
                  iconSize: 50,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(Icons.circle, color: Colors.white),
                ),
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Future initCamera(CameraDescription cameraDescription) async {
    _cameraController = CameraController(cameraDescription, ResolutionPreset.high);

    try {
      await _cameraController.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      });
    } on CameraException catch (e) {
      debugPrint("Camera error $e");
    }
  }

  Future takePicture() async {
    if (!_cameraController.value.isInitialized || _cameraController.value.isTakingPicture) {
      return null;
    }

    try {
      await _cameraController.setFlashMode(FlashMode.off);
      XFile picture = await _cameraController.takePicture();
      // TODO context should not be in async...
      BlocProvider.of<CreateGuessBloc>(context).add(CreateGuessLocationImageAddedEvent(locationImage: picture));
      Navigator.pop(context);
      // Navigator.pushNamedAndRemoveUntil(context, CreateScreen.route, (route) => false);
    } on CameraException catch (e) {
      debugPrint("Error occurred while taking picture $e");
      return null;
    }
  }
}
