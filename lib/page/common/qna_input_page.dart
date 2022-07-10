import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uplatform/components/border_rounded_button.dart';
import 'package:uplatform/components/custom_appbar.dart';
import 'package:uplatform/components/input_bottom_sheet.dart';
import 'package:uplatform/components/input_edit_paragraph_underline.dart';
import 'package:uplatform/components/input_edit_text_underline.dart';
import 'package:uplatform/components/input_image_picker.dart';
import 'package:uplatform/components/text_title.dart';
import 'package:uplatform/constants/constants.dart';
import 'package:uplatform/dialogs/notice_dialog.dart';
import 'package:uplatform/models/common_model.dart';
import 'package:uplatform/models/notice_model.dart';
import 'package:uplatform/services/network.dart';

class QnaInputPage extends StatefulWidget {
  const QnaInputPage({Key? key}) : super(key: key);

  static const routeName = '/QnaInputPage';

  @override
  _QnaInputPageState createState() => _QnaInputPageState();
}

class _QnaInputPageState extends State<QnaInputPage> {
  final _formKey = GlobalKey<FormState>(debugLabel: 'QnaInputPage');

  final TextEditingController _qnaTitleEditController = TextEditingController();
  final FocusNode _qnaTitleEditFocus = FocusNode();

  final TextEditingController _qnaMemoEditController = TextEditingController();
  final FocusNode _qnaMemoEditFocus = FocusNode();

  String _questionType = "";
  List<PickImageFile> _selectFiles = [];
  bool _isPressedAsked = false;

  QnaItemDetail? _qnaItemDetail;
  bool _isLoading = false;
  String? _qnaId;

  @override
  void initState() {
    _isPressedAsked = false;

    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (Get.arguments != null) {
        _qnaId = Get.arguments;
        debugPrint("QnaInputPage qnaId: $_qnaId");
        loadQnaDetail();
      }
    });
  }

  @override
  void dispose() {
    _qnaTitleEditController.dispose();
    _qnaTitleEditFocus.dispose();

    _qnaMemoEditController.dispose();
    _qnaMemoEditFocus.dispose();

    super.dispose();
  }

  Future loadQnaDetail() async {
    _isLoading = true;
    if (mounted) {
      setState(() {});
    }

    Map<String, dynamic> params = {};
    params['qna_id'] = _qnaId;

    _qnaItemDetail = await Network().reqQnaDetail(params);

    if (_qnaItemDetail == null) {
      _isLoading = false;
      Get.back();
      return;
    }

    _isLoading = false;
    setDefaultValue();

    if (mounted) {
      setState(() {});
    }
  }

  void setDefaultValue() {
    if (_qnaItemDetail == null) {
      return;
    }

    debugPrint("$_qnaItemDetail");

    _questionType = _qnaItemDetail!.type!;
    _qnaTitleEditController.text = _qnaItemDetail!.title!;
    _qnaMemoEditController.text = _qnaItemDetail!.content!;

    String fileSource = _qnaItemDetail!.fileSource!;
    if (fileSource.isNotEmpty) {
      fileSource = fileSource.replaceAll("[", "").replaceAll("]", "");
      List<String>? sourceFiles = fileSource.split(",");

      for (int i = 0; i < sourceFiles.length; i++) {
        if (sourceFiles[i].isEmpty) {
          continue;
        }

        _selectFiles.add(PickImageFile(fileType: PickImageFileType.networkFile, filePath: sourceFiles[i]));
      }
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(iconData: Icons.arrow_back),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 16),
              const TextTitle(
                titleText: "1:1 문의하기",
                cellHeight: 32,
                fontSize: 24,
                fontColor: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      InputBottomSheet(
                        title: "문의 유형",
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        items: const ["일반문의", "이벤트문의", "제휴문의"],
                        selectedItem: _questionType,
                        onChanged: (value) {
                          _questionType = value;
                          if (mounted) {
                            setState(() {});
                          }
                        },
                      ),
                      const SizedBox(height: 32),
                      InputEditTextUnderline(
                        editingController: _qnaTitleEditController,
                        focusNode: _qnaTitleEditFocus,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        title: "제목",
                        hintText: "제목 입력",
                        onSubmitted: (value) {
                          _qnaMemoEditFocus.requestFocus();
                        },
                        onChanged: (value) {
                          if (mounted) {
                            setState(() {});
                          }
                        },
                        isRequired: false,
                      ),
                      InputEditParagraphUnderline(
                        editingController: _qnaMemoEditController,
                        focusNode: _qnaMemoEditFocus,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        title: "내용",
                        hintText: "내용 입력",
                        isRequired: false,
                        onChanged: (value) {
                          if (mounted) {
                            setState(() {});
                          }
                        },
                      ),
                      const SizedBox(height: 32),
                      InputImagePicker(
                        key: GlobalKey(debugLabel: "Certificates"),
                        title: "파일 첨부",
                        isRequired: false,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        selectedImagesPath: _selectFiles,
                        showErrorText: false,
                        errorText: "",
                        onChanged: (values) {
                          _selectFiles = values;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: BorderRoundedButton(
                  text: (_qnaId != null) ? "수정하기" : "문의하기",
                  active: isActiveQuestionButton(),
                  buttonColor: kMainColor,
                  onPressed: () async {
                    if (_isPressedAsked) {
                      return;
                    }
                    _isPressedAsked = true;

                    List<dynamic> uploadFiles = [];

                    if (_selectFiles.isNotEmpty) {
                      uploadFiles = await Network().reqUploadImage(_selectFiles);
                    }

                    Map<String, dynamic> params = {};
                    params['type'] = _questionType;
                    params['title'] = _qnaTitleEditController.text;
                    params['content'] = _qnaMemoEditController.text;

                    if (uploadFiles.isNotEmpty) {
                      params['file_src'] = uploadFiles.toString();
                    }

                    if (_qnaId != null) {
                      params['qna_id'] = _qnaId;

                      CommonResponse commonResponse = await Network().reqModifyQuestion(params);
                      debugPrint("commonResponse $commonResponse");

                      String resultStr = await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const NoticeDialog(
                            title: "1:1 문의 수정",
                            subTitle: "",
                            contents: "수정되었습니다.",
                          );
                        },
                        barrierDismissible: false,
                      );

                      Get.back(result: "UPDATE");
                    } else {
                      CommonResponse commonResponse = await Network().reqRegisterQuestion(params);
                      debugPrint("commonResponse $commonResponse");

                      String resultStr = await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const NoticeDialog(
                            title: "서비스 1:1 문의",
                            subTitle: "1:1문의가 정상적으로 접수 되었습니다.",
                            contents: "문의 주신 내용을 정확하게 확인하여 빠르게\n답변 드릴 수 있도록 하겠습니다.",
                          );
                        },
                        barrierDismissible: false,
                      );

                      Get.back(result: "INSERT");
                    }
                  },
                ),
              ),
              const SizedBox(height: 32),
              buildBottomBar
            ],
          ),
        ),
      ),
    );
  }

  bool isActiveQuestionButton() {
    if (_questionType.isEmpty) {
      return false;
    }

    if (_qnaTitleEditController.text.isEmpty) {
      return false;
    }

    if (_qnaMemoEditController.text.isEmpty) {
      return false;
    }

    return true;
  }
}
