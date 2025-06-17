import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:remburshiment_app/constant/color_code.dart';
import 'package:remburshiment_app/helper/permission_helper.dart';
import 'package:remburshiment_app/utils/app_navigation.dart';
import 'package:remburshiment_app/utils/app_toast.dart';
import 'package:remburshiment_app/widgets/app_background.dart';
import 'package:remburshiment_app/widgets/app_loader.dart';

class CameraScreen extends StatefulWidget {
  final void Function(XFile?) image;
  CameraScreen({super.key, required this.image});
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  List<CameraDescription>? cameras;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async {
    var isGranted = await PermissionHelper.requestCameraPermission();
    if (isGranted) {
      cameras = await availableCameras();
      if (cameras != null && cameras!.isNotEmpty) {
        _controller = CameraController(cameras![0], ResolutionPreset.high);
        await _controller!.initialize();
        if (mounted) {
          setState(() {});
        }
      }
    } else {
      AppToast.showErrorToast(context, 'Camera Permission Not Allowed');
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return AppBackground(
        navBarTitle: 'Camera',
        child: Center(
          child: AppLoader(
            color: HexColor(ColorCode.primaryColor),
          ),
        ),
      );
    }

    return AppBackground(
      navBarTitle: 'Camera',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: CameraPreview(_controller!),
          ),
          FloatingActionButton(
            onPressed: captureImage,
            child: const Icon(Icons.camera_alt),
          ),
        ],
      ),
    );
  }

  Future<void> captureImage() async {
    try {
      final XFile file = await _controller!.takePicture();

      widget.image(file);
      NavigationHelper.pop(context);
    } catch (e) {
      AppToast.showErrorToast(context, "Error capturing image: $e");
    }
  }
}
