import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mps_app/utils/classes/custom_shared_preferences.dart';
import 'package:mps_app/utils/utility.dart';
import 'dart:io';
import 'dart:convert';
import 'package:mps_app/widgets/bottom_navigation.dart';
import 'package:mps_app/widgets/navigation_drawer.dart';
import 'package:mps_app/widgets/reuseable_widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class CollaborationForm extends StatefulWidget {
  final String dataId;
  const CollaborationForm({Key? key, required this.dataId}) : super(key: key);

  @override
  _CollaborationFormState createState() => _CollaborationFormState();
}

class _CollaborationFormState extends State<CollaborationForm> {
  List<XFile>? _imageFileList;
  String? baseimage;

  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : [value];
  }

  dynamic _pickImageError;

  String? _retrieveDataError;

  final ImagePicker _picker = ImagePicker();

  void _onImageButtonPressed(ImageSource source,
      {BuildContext? context}) async {
    try {
      final pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 250,
        maxHeight: 250,
      );
      var imageBytes = await pickedFile?.readAsBytes();
      setState(() {
        _imageFile = pickedFile;
        baseimage = base64Encode(imageBytes!);
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  Widget _previewImages() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFileList != null) {
      return Semantics(
          child: ListView.builder(
            key: UniqueKey(),
            itemBuilder: (context, index) {
              return Semantics(
                label: 'image_picker_example_picked_image',
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    kIsWeb
                        ? Image.network(_imageFileList![index].path)
                        : Image.file(File(_imageFileList![index].path)),
                    ElevatedButton(
                        onPressed: () async {
                          var token = CustomSharedPreferences.getToken();
                          final filename =
                              _imageFileList![index].path.split("/").last;
                          var response = await http.post(
                              Uri.parse(Utility.baseUrl +
                                  "collaboration/uploadImage"),
                              body: {
                                "id": widget.dataId,
                                "image": baseimage,
                                "filename": filename,
                              },
                              headers: {
                                'Authorization': 'Bearer $token',
                              });
                          if (response.statusCode == 200) {
                            // var jsonResponse = json.decode(response.body);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text("Image Uploaded Successfully...!")),
                            );
                            Navigator.pop(context, true);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "Error during connection to server")),
                            );
                          }
                        },
                        child: const Text("Upload Image")),
                  ],
                ),
              );
            },
            itemCount: _imageFileList!.length,
          ),
          label: 'picked_images');
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
  }

  Widget _handlePreview() {
    return _previewImages();
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _imageFile = response.file;
        _imageFileList = response.files;
      });
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ReusableWidgets.getAppBar(),
        drawer: const NavigationDrawerWidget(),
        body: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "Collaborations",
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white38,
          ),
          body: Center(
            child: !kIsWeb && defaultTargetPlatform == TargetPlatform.android
                ? FutureBuilder<void>(
                    future: retrieveLostData(),
                    builder:
                        (BuildContext context, AsyncSnapshot<void> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return const Text(
                            'You have not yet picked an image.',
                            textAlign: TextAlign.center,
                          );
                        case ConnectionState.done:
                          return _handlePreview();
                        default:
                          if (snapshot.hasError) {
                            return Text(
                              'Pick image error: ${snapshot.error}}',
                              textAlign: TextAlign.center,
                            );
                          } else {
                            return const Text(
                              'You have not yet picked an image.',
                              textAlign: TextAlign.center,
                            );
                          }
                      }
                    },
                  )
                : _handlePreview(),
          ),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: FloatingActionButton(
                  onPressed: () {
                    _onImageButtonPressed(ImageSource.camera, context: context);
                  },
                  heroTag: 'image2',
                  tooltip: 'Take a Photo',
                  child: const Icon(Icons.camera_alt),
                ),
              ),
            ],
          ),
          bottomNavigationBar: const BottomNavigationWidget(),
        ));
  }

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }
}
