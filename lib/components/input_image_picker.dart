import 'dart:io';
import 'dart:typed_data';

import 'package:extended_image/extended_image.dart' as Extended;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:universal_platform/universal_platform.dart';

import 'input_title.dart';

class InputImagePicker extends StatefulWidget {
  const InputImagePicker({
    Key? key,
    this.title = "",
    this.isRequired = false,
    this.padding,
    required this.selectedImagesPath,
    this.onChanged,
    this.showErrorText = false,
    this.errorText = "",
  }) : super(key: key);

  final String title;
  final bool isRequired;
  final EdgeInsetsGeometry? padding;
  final List<PickImageFile> selectedImagesPath;
  final ValueChanged<List<PickImageFile>>? onChanged;
  final bool showErrorText;
  final String errorText;

  @override
  State<InputImagePicker> createState() => _InputImagePickerState();
}

class _InputImagePickerState extends State<InputImagePicker> {
  List<Widget> _selectedImages = [];
  List<PickImageFile> _selectedImagesFiles = [];
  String _chooseWhere = "";

  @override
  void initState() {
    super.initState();
    _selectedImagesFiles = widget.selectedImagesPath;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    makeSelectedImageWidgets();
  }

  void makeSelectedImageWidgets() async {
    _selectedImages = [];
    _selectedImages.add(buildImagePicker());

    for (int i = 0; i < _selectedImagesFiles.length; i++) {
      _selectedImages.add(await buildSelectImage(_selectedImagesFiles[i]));
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputTitle(
          title: widget.title,
          isRequired: widget.isRequired,
          padding: widget.padding,
        ),
        const SizedBox(height: 8),
        Container(
          padding: widget.padding,
          alignment: Alignment.centerLeft,
          child: Wrap(
            spacing: 8,
            children: _selectedImages,
          ),
        ),
        const SizedBox(height: 8),
        if (widget.showErrorText)
          Container(
            height: 20,
            padding: widget.padding,
            alignment: Alignment.centerLeft,
            child: Text(
              widget.errorText,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        else
          const SizedBox(height: 20)
      ],
    );
  }

  Widget buildImagePicker() {
    return GestureDetector(
      onTap: () async {
        _chooseWhere = "";
        await buildBottomSheetPanel(context);

        XFile? imageFile = await ImagePicker().pickImage(
          source: (_chooseWhere == "갤러리에서 선택") ? ImageSource.gallery : ImageSource.camera,
          imageQuality: (_chooseWhere == "갤러리에서 선택") ? 50 : 25,
        );

        if (imageFile != null) {
          for (int i = 0; i < _selectedImagesFiles.length; i++) {
            if (_selectedImagesFiles[i].fileType == PickImageFileType.networkFile) {
              continue;
            }

            if (UniversalPlatform.isWeb) {
              if (_selectedImagesFiles[i].fileType == PickImageFileType.xFile) {
                if (_selectedImagesFiles[i].xFile == imageFile) {
                  return;
                }
              }
            } else {
              if (_selectedImagesFiles[i].fileType == PickImageFileType.selectFile) {
                if (_selectedImagesFiles[i].filePath == imageFile.path) {
                  return;
                }
              }
            }
          }

          if (UniversalPlatform.isWeb) {
            PickImageFile selImageFile = PickImageFile(fileType: PickImageFileType.xFile, xFile: imageFile);

            _selectedImages.add(await buildSelectImage(selImageFile));
            _selectedImagesFiles.add(selImageFile);
          } else {
            PickImageFile selImageFile =
                PickImageFile(fileType: PickImageFileType.selectFile, filePath: imageFile.path);

            _selectedImages.add(await buildSelectImage(selImageFile));
            _selectedImagesFiles.add(selImageFile);
          }

          widget.onChanged!(_selectedImagesFiles);
        }

        if (mounted) {
          setState(() {});
        }
      },
      child: Container(
        width: 74,
        height: 74,
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: const Color(0xFFC9CDD4),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        alignment: Alignment.center,
        child: const Icon(
          Icons.add,
          color: Color(0xFF898D93),
        ),
      ),
    );
  }

  Future<Widget> buildSelectImage(PickImageFile imageFile) async {
    ImageProvider? imageProvider;

    if (imageFile.fileType == PickImageFileType.networkFile) {
      const String imageRoot = 'https://uplatform.s3.ap-northeast-2.amazonaws.com/';

      String fullImagePath = imageRoot + imageFile.filePath!;
      debugPrint("fullImagePath $fullImagePath");

      imageProvider = Extended.ExtendedNetworkImageProvider(fullImagePath, cache: true);
    } else if (imageFile.fileType == PickImageFileType.selectFile) {
      try {
        imageProvider = FileImage(
          File(imageFile.filePath!),
        );
      } catch (e) {
        return Container();
      }
    } else if (imageFile.fileType == PickImageFileType.xFile) {
      try {
        imageProvider = Image.memory(
          await imageFile.xFile!.readAsBytes(),
        ).image;
      } catch (e) {
        return Container();
      }
    } else {
      return Container();
    }

    return Container(
      width: 74,
      height: 74,
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFFC9CDD4),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8.0),
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
      ),
      alignment: Alignment.topRight,
      child: GestureDetector(
        onTap: () {
          _selectedImagesFiles.remove(imageFile);
          widget.onChanged!(_selectedImagesFiles);

          makeSelectedImageWidgets();

          if (mounted) {
            setState(() {});
          }
        },
        child: Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(8),
              bottomLeft: Radius.circular(8),
            ),
          ),
          alignment: Alignment.center,
          child: const Icon(
            Icons.close,
            size: 10,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Future<dynamic> buildBottomSheetPanel(BuildContext context) async {
    List<String> items = ["갤러리에서 선택", "사진 촬영"];

    await showMaterialModalBottomSheet(
      expand: false,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Material(
          color: Colors.transparent,
          child: SafeArea(
            top: false,
            bottom: false,
            child: Container(
              color: Colors.transparent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 32,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    padding: const EdgeInsets.only(top: 12),
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 4,
                      width: 40,
                      color: const Color(0xFFE4E7ED),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: ListView.builder(
                      padding: EdgeInsets.only(bottom: UniversalPlatform.isIOS ? 48 : 32),
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: 2,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            _chooseWhere = items[index];
                            Navigator.of(context).pop(items[index]);
                          },
                          child: Container(
                            height: 46,
                            alignment: Alignment.center,
                            color: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              color: Colors.transparent,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                items[index],
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

enum PickImageFileType { networkFile, selectFile, xFile }

class PickImageFile {
  PickImageFileType fileType; // 0 : Network Image File, 1: using filePath for Android/iOS, 2: using XFile for Web
  String? filePath;
  XFile? xFile;

  PickImageFile({required this.fileType, this.filePath, this.xFile});

  @override
  String toString() {
    return 'PickImageFile{fileType: $fileType, filePath: $filePath, xFile: $xFile}';
  }
}
