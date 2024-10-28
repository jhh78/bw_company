import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/collections/company.dart';
import 'package:flutter_application_1/models/company_register_form_model.dart';
import 'package:flutter_application_1/providers/systems.dart';
import 'package:flutter_application_1/screens/corporate_info.dart';
import 'package:flutter_application_1/services/company.dart';
import 'package:flutter_application_1/services/exception.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/widgets/common/custom_snackbar.dart';
import 'package:flutter_application_1/widgets/register/rating_input_form.dart';
import 'package:flutter_application_1/widgets/register/custom_text_input_field.dart';
import 'package:flutter_application_1/widgets/register/search_tag_input_field.dart';
import 'package:get/get.dart';

const String location = "lib/screens/comment_register.dart";

class CommentRegister extends StatefulWidget {
  const CommentRegister({super.key, required this.company});
  final Company company;

  @override
  State<CommentRegister> createState() => _CommentRegisterState();
}

class _CommentRegisterState extends State<CommentRegister> {
  final SystemsProvider _validateionProvider = Get.put(SystemsProvider());
  final CompanyRegisterFormModel _companyRegisterModel = CompanyRegisterFormModel();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _careerController = TextEditingController();
  final TextEditingController _workingEnvironmentController = TextEditingController();
  final TextEditingController _salaryWelfareController = TextEditingController();
  final TextEditingController _corporateCultureController = TextEditingController();
  final TextEditingController _managementController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _careerRatingUpdate(double rating) {
    _companyRegisterModel.companyRating.careerRating = rating;
  }

  void _workingEnvironmentRatingUpdate(double rating) {
    _companyRegisterModel.companyRating.workingEnvironmentRating = rating;
  }

  void _salaryWelfareRatingUpdate(double rating) {
    _companyRegisterModel.companyRating.salaryWelfareRating = rating;
  }

  void _corporateCultureRatingUpdate(double rating) {
    _companyRegisterModel.companyRating.corporateCultureRating = rating;
  }

  void _managementRatingUpdate(double rating) {
    _companyRegisterModel.companyRating.managementRating = rating;
  }

  void _registerComment() async {
    try {
      _validateionProvider.formValidate.clear();
      if (_titleController.text.isEmpty) {
        _validateionProvider.formValidate['title'] = true;
      }

      if (_careerController.text.isEmpty) {
        _validateionProvider.formValidate['career'] = true;
      }

      if (_workingEnvironmentController.text.isEmpty) {
        _validateionProvider.formValidate['workingEnvironment'] = true;
      }

      if (_salaryWelfareController.text.isEmpty) {
        _validateionProvider.formValidate['salaryWelfare'] = true;
      }

      if (_corporateCultureController.text.isEmpty) {
        _validateionProvider.formValidate['corporateCulture'] = true;
      }

      if (_managementController.text.isEmpty) {
        _validateionProvider.formValidate['management'] = true;
      }

      _companyRegisterModel.company = widget.company;
      _companyRegisterModel.companyComment.title = _titleController.text;
      _companyRegisterModel.companyComment.career = _careerController.text;
      _companyRegisterModel.companyComment.workingEnvironment = _workingEnvironmentController.text;
      _companyRegisterModel.companyComment.salaryWelfare = _salaryWelfareController.text;
      _companyRegisterModel.companyComment.corporateCulture = _corporateCultureController.text;
      _companyRegisterModel.companyComment.management = _managementController.text;

      if (_validateionProvider.formValidate.isNotEmpty) {
        CustomSnackbar(
          title: 'errorText'.tr,
          message: "needRequiredField".tr,
          status: ObserveSnackbarStatus.ERROR,
        ).showSnackbar();
        return;
      }

      await registerComment(_companyRegisterModel);

      Get.offAll(
        () => CorporateInfoScreen(company: widget.company),
        transition: Transition.rightToLeft,
      );
    } catch (e) {
      writeLogs(location, e.toString());

      CustomSnackbar(
        title: "errorText".tr,
        message: "unknownExcetipn".tr,
        status: ObserveSnackbarStatus.ERROR,
      ).showSnackbar();
    }
  }

  void _changeTagList(List<String> tagList) {
    widget.company.tags = tagList.join(SEARCH_TAG_SEPARATOR);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text("commentRegisterTitle".tr),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                alignment: Alignment.center,
                child: Text(
                  widget.company.name,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              RatingInputForm(title: "descriptionCareer".tr, onRatingUpdate: _careerRatingUpdate),
              RatingInputForm(title: "descriptionWorkEnvironment".tr, onRatingUpdate: _workingEnvironmentRatingUpdate),
              RatingInputForm(title: "descriptionSalaryWelfare".tr, onRatingUpdate: _salaryWelfareRatingUpdate),
              RatingInputForm(title: "descriptionCompanyCulture".tr, onRatingUpdate: _corporateCultureRatingUpdate),
              RatingInputForm(title: "descriptionManagement".tr, onRatingUpdate: _managementRatingUpdate),
              Container(
                padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                child: SearchTagInputField(tags: "", onTagChange: _changeTagList),
              ),
              Obx(() => CustomTextInputField(
                    hintText: "companyRegisterInputFormTitleHintText".tr,
                    helperText: "companyRegisterInputFormTitleHintText".tr,
                    controller: _titleController,
                    isValidate: _validateionProvider.formValidate['title'] ?? false,
                  )),
              Obx(() => CustomTextInputField(
                    hintText: "companyRegisterInputFormCareerHintText".tr,
                    helperText: "companyRegisterInputFormCareerHintText".tr,
                    controller: _careerController,
                    isValidate: _validateionProvider.formValidate['career'] ?? false,
                  )),
              Obx(() => CustomTextInputField(
                    hintText: "companyRegisterInputFormWorkingEnvironmentHintText".tr,
                    helperText: "companyRegisterInputFormWorkingEnvironmentHintText".tr,
                    controller: _workingEnvironmentController,
                    isValidate: _validateionProvider.formValidate['workingEnvironment'] ?? false,
                  )),
              Obx(() => CustomTextInputField(
                    hintText: "companyRegisterInputFormSalaryWelfareHintText".tr,
                    helperText: "companyRegisterInputFormSalaryWelfareHintText".tr,
                    controller: _salaryWelfareController,
                    isValidate: _validateionProvider.formValidate['salaryWelfare'] ?? false,
                  )),
              Obx(() => CustomTextInputField(
                    hintText: "companyRegisterInputFormCorporateCultureHintText".tr,
                    helperText: "companyRegisterInputFormCorporateCultureHintText".tr,
                    controller: _corporateCultureController,
                    isValidate: _validateionProvider.formValidate['corporateCulture'] ?? false,
                  )),
              Obx(() => CustomTextInputField(
                    hintText: "companyRegisterInputFormManagementHintText".tr,
                    helperText: "companyRegisterInputFormManagementHintText".tr,
                    controller: _managementController,
                    isValidate: _validateionProvider.formValidate['management'] ?? false,
                  )),
              Container(
                padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                child: ElevatedButton(
                  onPressed: _registerComment,
                  child: Text("registerButton".tr),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
