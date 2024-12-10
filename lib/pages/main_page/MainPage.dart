import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tesseract_ocr/android_ios.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:my_free_doc_reader/pages/main_page/MainPageBLoC.dart';
import 'package:my_free_doc_reader/pages/main_page/MainPageStates.dart';

import 'MainPageService.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late CameraController _controller;
  List<CameraDescription>? cameras;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    _controller = CameraController(
      cameras![1],
      ResolutionPreset.ultraHigh,
    );
    await _controller.initialize();
    if (mounted) {
      context.read<MainPageBLoC>().cameraIsOpenAndReady(_controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<MainPageBLoC, MainPageState>(
            builder: (BuildContext context, MainPageState state) {
          switch (state) {
            case MainPageInitialState():
              return const Center(
                child: CircularProgressIndicator(),
              );

            case MainPageCameraInitializedState():
              return Stack(
                children: [
                  Column(
                    children: [
                      Expanded(child: CameraPreview(_controller)),
                    ],
                  ),
                  Positioned(
                    right: 25,
                    top: 25,
                    child: GestureDetector(
                      onTap: () async {
                        _getImageFromDeviceButtomPressed(context);
                      },
                      child: const Icon(
                        CupertinoIcons.photo_fill,
                        color: Colors.black,
                        size: 50,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 40,
                    right: MediaQuery.sizeOf(context).width / 2 - 40,
                    child: GestureDetector(
                      onTap: () async {
                        _takePicture();
                      },
                      child: const Icon(
                        CupertinoIcons.circle,
                        color: Colors.black,
                        size: 80,
                      ),
                    ),
                  )
                ],
              );

            case MainPageFileSelectedState():
              return Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          child: Image.file(
                            File(state.file.path),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 30,
                    left: 20,
                    child: GestureDetector(
                      onTap: () async {
                        context
                            .read<MainPageBLoC>()
                            .cameraIsOpenAndReady(_controller);
                      },
                      child: Container(
                        color: Colors.red.withOpacity(0),
                        child: const Icon(
                          CupertinoIcons.back,
                          color: Colors.black,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 50,
                    right: MediaQuery.sizeOf(context).width / 2 - 80,
                    child: GestureDetector(
                      onTap: () async {
                        String response =
                            await _extractTextFromPicture(state.file);
                        context.go("/textpage", extra: response);
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(
                            0xff0000ff,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Copiar Texto",
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );

            default:
              return Container(
                color: Colors.red,
                child: const Center(
                  child: Text(
                      "Você não deveria estar vendo isso, por favor, reporte ao admnistrador"),
                ),
              );
          }
        }),
      ),
    );
  }

  Future<void> _getImageFromDeviceButtomPressed(BuildContext context) async {
    MainPageService service =
        GetIt.instance.get<MainPageService>(instanceName: "MainPageService");
    final xfile = await service.getImageFromDevice();
    context.read<MainPageBLoC>().exibitImageOnScreen(File(xfile!.path));
  }

  void _takePicture() async {
    MainPageService service =
        GetIt.instance.get<MainPageService>(instanceName: "MainPageService");
    final xfile = await service.takePictureUsingCamera(_controller);
    context.read<MainPageBLoC>().exibitImageOnScreen(File(xfile!.path));
  }

  Future<String> _extractTextFromPicture(File file) async {
    String response = await FlutterTesseractOcr.extractText(file.path);
    await Clipboard.setData(ClipboardData(text: response));
    return response;
  }
}
