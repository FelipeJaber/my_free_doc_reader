import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_free_doc_reader/pages/main_page/MainPageStates.dart';

class MainPageBLoC extends Cubit<MainPageState> {
  MainPageBLoC() : super(MainPageInitialState());

  void exibitImageOnScreen(File? file) async {
    if (file != null) emit(MainPageFileSelectedState(file));
  }

  void cameraIsOpenAndReady(CameraController controller) {
    emit(MainPageCameraInitializedState(controller));
  }
}
