import 'dart:io';

import 'package:camera/camera.dart';

abstract class MainPageState {}

class MainPageInitialState extends MainPageState {}

class MainPageFileSelectedState extends MainPageState {
  File file;

  MainPageFileSelectedState(this.file);
}

class MainPageCameraInitializedState extends MainPageState {
  CameraController controller;

  MainPageCameraInitializedState(this.controller);
}
