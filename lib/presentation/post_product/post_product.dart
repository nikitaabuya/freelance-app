import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/models/service_category.dart';
import 'package:freelance_app/models/service_subcategory.dart';
import 'package:freelance_app/res/widgets/buttons.dart';
import 'package:freelance_app/res/widgets/snackbar.dart';
import 'package:freelance_app/services/get_remote_services.dart';
import 'package:freelance_app/services/post_remote_services.dart';
import 'package:freelance_app/services/upload_image.dart';
import '../../../../res/constants/colors.dart';
import '../../models/users.dart';
import '../../res/widgets/appbar.dart';
import '../../res/widgets/text_widget.dart';
import '../../res/widgets/loading_indicator.dart';
import '../../services/pick_image.dart';
import '../global/checkout/widget/text_field.dart';

class FreelancePost extends StatefulWidget {
  const FreelancePost({super.key});

  @override
  State<FreelancePost> createState() => _FreelancePostState();
}

class _FreelancePostState extends State<FreelancePost> {
  // variables
  bool isLoading = false;
  int currentStep = 0;
  bool isNetworkImage = true;

  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
  final _formKey4 = GlobalKey<FormState>();

  // controllers
  File? galleryFile1;
  File? galleryFile2;
  File? galleryFile3;
  File? galleryFile4;
  File? galleryFile5;

  final TextEditingController _category = TextEditingController();
  final TextEditingController _subCategory = TextEditingController();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _deliveryTime = TextEditingController();
  final TextEditingController _productDescrition = TextEditingController();
  final TextEditingController _serviceProvided = TextEditingController();
  final TextEditingController _toolTechUsed = TextEditingController();

  final TextEditingController _gallery1 = TextEditingController();
  final TextEditingController _gallery2 = TextEditingController();
  final TextEditingController _gallery3 = TextEditingController();
  final TextEditingController _gallery4 = TextEditingController();
  final TextEditingController _gallery5 = TextEditingController();

  //
  final TextEditingController _faq1 = TextEditingController();
  final TextEditingController _faq2 = TextEditingController();
  final TextEditingController _faq3 = TextEditingController();
  final TextEditingController _faq4 = TextEditingController();
  final TextEditingController _faq5 = TextEditingController();

  final List<String> options = [
    'Beginner',
    'Intermediate',
    'Advanced',
    'Fluent',
  ];

  List<ServiceCategory>? serviceCategory = [];
  List<ServiceSubcategory>? serviceSubCategory = [];
  List<Users>? userInfo = [];

  // get category
  getCategory() async {
    List<ServiceCategory>? response =
        await GetRemoteService().getCategoriesInfo('', '', '', '', '');

    setState(() {
      _subCategory.clear();
      serviceSubCategory = [];

      serviceCategory = response;
    });
  }

  // get Sub category
  getSubCategory(String parentId) async {
    List<ServiceSubcategory>? response =
        await GetRemoteService().getSubserviceInfo(parentCategoryId: parentId);

    setState(() {
      serviceSubCategory = response;
    });
  }

  String? selectedCategory;

  // upload functions

  Future<String> uploadImage(
      File profilePictureFile, String profilePictureUrl) async {
    // upload image

    var imgResponse =
        await ImageUpload().uploadImage(profilePictureFile, profilePictureUrl);

    if (imgResponse.trim() == '"Image uploaded successfully"') {
      setState(() {
        customSnackBar(
          context,
          'Image updated successfully!',
          CustomColors.success,
          Colors.white,
        );
      });

      return '';
    } else {
      setState(() {
        isLoading = false;
        customSnackBar(
          context,
          'Something went wrong!',
          CustomColors.danger,
          CustomColors.primaryTextColor,
        );
      });

      return '';
    }
  }

  Future<String> uploadProduct(
    userId,
    projectCategory,
    projectSubcategory,
    projectTitle,
    projectMinDelivery,
    projctDescription,
    servicesProvided,
    toolsTechUsed,
    projectServiceId,
  ) async {
    var response = await PostRemoteService().postProducts(
      userId,
      projectCategory,
      projectSubcategory,
      projectTitle,
      projectMinDelivery,
      projctDescription,
      servicesProvided,
      toolsTechUsed,
      projectServiceId,
    );
    setState(() {
      isLoading = false;
    });

    if (response == 'Data updated successfully') {
      debugPrint('uploaded');
    }
    return response;
  }

  @override
  void initState() {
    getCategory();
    super.initState();
  }

  @override
  void dispose() {
    _category.dispose();
    _subCategory.dispose();
    _title.dispose();
    _deliveryTime.dispose();
    _productDescrition.dispose();
    _serviceProvided.dispose();
    _toolTechUsed.dispose();
    _faq1.dispose();
    _faq2.dispose();
    _faq3.dispose();
    _faq4.dispose();
    _faq5.dispose();
    super.dispose();
  }

  // void selectPhotoFunc() async {
  //   final result = await selectPhoto();
  //   setState(() {
  //     isNetworkImage = false;
  //     _profilePicture.text = result.fileName;
  //     profilePictureFile = File(result.filePath);
  //     if (_profilePicture.text.isNotEmpty) {
  //       uploadImage(profilePictureFile!, _profilePicture.text);
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                TopAppBar(
                  onTap: () {},
                ),
              ],
              body: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: CustomText(
                          title: 'Upload Product Details',
                          size: 18.0,
                          color: CustomColors.primaryTextColor,
                          weight: FontWeight.bold,
                        ),
                      ),
                      Theme(
                        data: Theme.of(context).copyWith(
                            colorScheme: const ColorScheme.light(
                          primary: CustomColors.buttonColor,
                        )),
                        child: Stepper(
                          controlsBuilder:
                              (BuildContext context, ControlsDetails details) {
                            final isLastStep =
                                currentStep == getSteps().length - 1;
                            return Container(
                              margin: const EdgeInsets.only(top: 50.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: CustomButton(
                                      color: CustomColors.buttonColor,
                                      title: isLastStep ? 'Save' : 'Next',
                                      textColor: Colors.white,
                                      onPressed: () =>
                                          details.onStepContinue!(),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15.0,
                                  ),
                                  if (currentStep != 0)
                                    Expanded(
                                      child: CustomButton(
                                        color: CustomColors.danger,
                                        title: 'Cancel',
                                        textColor: Colors.white,
                                        onPressed: () =>
                                            details.onStepCancel!(),
                                      ),
                                    ),
                                ],
                              ),
                            );
                          },
                          physics: const BouncingScrollPhysics(),
                          currentStep: currentStep,
                          steps: getSteps(),
                          onStepContinue: () {
                            final isLastStep =
                                currentStep == getSteps().length - 1;

                            switch (currentStep) {
                              case 0:
                                // do something for step 0 basic information

                                if (_formKey1.currentState!.validate()) {
                                  // isLoading = true;
                                  // ! step 1 fill up
                                  setState(() {
                                    currentStep = currentStep + 1;
                                  });
                                } else {
                                  customSnackBar(
                                    context,
                                    'Fields missing or Invalid input',
                                    CustomColors.danger,
                                    Colors.white,
                                  );
                                }

                                break;
                              case 1:
                                // do something for step 1 product information

                                if (_formKey2.currentState!.validate()) {
                                  setState(() {
                                    currentStep = currentStep + 1;
                                  });
                                }

                                break;
                              case 2:
                                // do something for step 2 additional information
                                if (_formKey3.currentState!.validate()) {
                                  setState(() {
                                    currentStep = currentStep + 1;
                                  });
                                }

                                break;
                              case 3:
                                // do something for step 3 images
                                setState(() {
                                  currentStep = currentStep + 1;
                                });
                                break;
                              case 4:
                                // do something for step 4 faq
                                if (_formKey4.currentState!.validate()) {
                                  setState(() {
                                    isLoading = true;
                                    uploadProduct(
                                      '18',
                                      _category.text,
                                      _subCategory.text,
                                      _title.text,
                                      _deliveryTime.text,
                                      _productDescrition.text,
                                      _toolTechUsed.text,
                                      _serviceProvided.text,
                                      // ,projectServiceId,
                                      '1',
                                    );
                                    // currentStep = currentStep + 1;
                                    // save it
                                  });
                                } else {
                                  customSnackBar(context, 'Fields missing',
                                      CustomColors.danger, Colors.white);
                                }

                                break;
                              default:
                              // Handle cases not covered by the above steps
                            }

                            // -----------------------------------------------------------
                            if (isLastStep) {
                              // submit form
                              debugPrint('Completed');
                            }
                            //  else {
                            //   setState(() => currentStep += 1);
                            // }
                          },
                          onStepCancel: currentStep == 0
                              ? null
                              : () {
                                  setState(() => currentStep -= 1);
                                },
                        ),
                      ),
                      const SizedBox(height: 14.0),
                    ],
                  ),
                ),
              ),
            ),
            if (isLoading) const LoadingIndicator(),
          ],
        ),
      ),
    );
  }

  List<Step> getSteps() => [
        /* ------------------------------------------------ */
        // ^ Product information
        /* ------------------------------------------------ */

        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: const CustomText(
            title: 'Product Information',
            size: 18.0,
            color: CustomColors.primaryTextColor,
            weight: FontWeight.bold,
          ),
          content: Form(
            key: _formKey1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ^ parent category
                DropdownButtonFormField2<String>(
                  isExpanded: true,
                  decoration: InputDecoration(
                    // Add Horizontal padding using menuItemStyleData.padding so it matches
                    // the menu padding when button's width is not specified.
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    // Add more decoration..
                  ),
                  hint: const Text(
                    'Choose category',
                    style: TextStyle(fontSize: 14),
                  ),
                  items: serviceCategory?.map((category) {
                        return DropdownMenuItem<String>(
                          value: category.categoryId,
                          child: Text(category.categoryName),
                        );
                      }).toList() ??
                      [],
                  validator: (value) {
                    if (value == null) {
                      return 'Please select any one option.';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    //Do something when selected item is changed.
                    setState(() {
                      _category.text = value.toString();
                      getSubCategory(_category.text);
                    });
                  },
                  buttonStyleData: const ButtonStyleData(
                    padding: EdgeInsets.only(right: 8),
                  ),
                  iconStyleData: const IconStyleData(
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black45,
                    ),
                    iconSize: 24,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
                const SizedBox(height: 24.0),

                // ^ sub categories
                DropdownButtonFormField2<String>(
                  isExpanded: true,
                  decoration: InputDecoration(
                    // Add Horizontal padding using menuItemStyleData.padding so it matches
                    // the menu padding when button's width is not specified.
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  hint: const Text(
                    'Choose Sub Category',
                    style: TextStyle(fontSize: 14),
                  ),
                  items: serviceSubCategory?.map((subCategory) {
                        return DropdownMenuItem<String>(
                          value: subCategory.subcategoryId,
                          child: Text(subCategory.subcategoryName),
                        );
                      }).toList() ??
                      [],
                  validator: (value) {
                    if (value == null) {
                      return 'Please select any one option.';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    //Do something when selected item is changed.
                    setState(() {
                      _subCategory.text = value.toString();
                    });
                  },
                  buttonStyleData: const ButtonStyleData(
                    padding: EdgeInsets.only(right: 8),
                  ),
                  iconStyleData: const IconStyleData(
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black45,
                    ),
                    iconSize: 24,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),

                // ^ product title
                const SizedBox(height: 24.0),
                CheckoutFormWidget(
                  width: 1.0,
                  label: 'Title',
                  controller: _title,
                  hintText: 'Enter the project title',
                  isImp: true,
                  textInputType: TextInputType.name,
                  maxLines: 1,
                  errorText: 'Please enter the title of the project',
                ),

                // ^ project minimum delivery time
                const SizedBox(height: 24.0),
                CheckoutFormWidget(
                  width: 1.0,
                  label: 'Project minimum delivery time',
                  controller: _deliveryTime,
                  hintText: 'Enter the minimum delivery time (in days)',
                  isImp: true,
                  textInputType: TextInputType.number,
                  maxLines: 1,
                  errorText: 'Enter minimum delivery time in days',
                ),

                // ^ project description
                const SizedBox(height: 24.0),
                CheckoutFormWidget(
                  width: 1.0,
                  label: 'Description',
                  controller: _productDescrition,
                  hintText: 'Describe your product in detail',
                  isImp: true,
                  textInputType: TextInputType.multiline,
                  maxLines: 5,
                  errorText: 'Provide description for the product',
                ),
              ],
            ),
          ),
        ),

        /* ------------------------------------------------ */
        // ^ additional information
        /* ------------------------------------------------ */
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: const CustomText(
            title: 'Additional Information',
            size: 18.0,
            color: CustomColors.primaryTextColor,
            weight: FontWeight.bold,
          ),
          content: Form(
            key: _formKey2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const TagsTextField(
                //   label: 'Services Offered',
                //   isImp: true,
                // ),

                // services provided
                const SizedBox(height: 24.0),
                CheckoutFormWidget(
                  width: 1.0,
                  label: 'Services',
                  controller: _serviceProvided,
                  hintText: 'List the services you will provide',
                  isImp: true,
                  textInputType: TextInputType.multiline,
                  maxLines: 2,
                  errorText: 'List all the services',
                ),

                // tools and technology used provided
                const SizedBox(height: 24.0),
                CheckoutFormWidget(
                  width: 1.0,
                  label: 'Tools and Technologies ',
                  controller: _toolTechUsed,
                  hintText: 'List the tools and technologies used (optional)',
                  isImp: false,
                  textInputType: TextInputType.multiline,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ),

        /* ------------------------------------------------ */
        // ^ add images
        /* ------------------------------------------------ */
        Step(
          state: currentStep > 2 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 2,
          title: const CustomText(
            title: 'Add Images',
            size: 18.0,
            color: CustomColors.primaryTextColor,
            weight: FontWeight.bold,
          ),
          content: Form(
            key: _formKey3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // images 1
                const SizedBox(height: 24.0),

                // gallery 1

                InkWell(
                  onTap: () async {
                    selectGalleryFunc(_gallery1, galleryFile1);
                  },
                  child: CheckoutFormWidget(
                    width: 1.0,
                    label: 'Pick image 1',
                    controller: _gallery1,
                    hintText: 'Pick image 1',
                    isImp: true,
                    textInputType: TextInputType.text,
                    maxLines: 1,
                    enabled: false,
                    errorText: 'Select 1 image to continue',
                  ),
                ),
                const SizedBox(height: 10.0),

                // gallery 2

                InkWell(
                  onTap: () async {
                    selectGalleryFunc(_gallery2, galleryFile1);
                  },
                  child: CheckoutFormWidget(
                    width: 1.0,
                    label: 'Pick image 2',
                    controller: _gallery2,
                    hintText: 'Pick image 2',
                    textInputType: TextInputType.text,
                    maxLines: 1,
                    enabled: false,
                  ),
                ),
                const SizedBox(height: 10.0),

                // gallery 3

                InkWell(
                  onTap: () async {
                    selectGalleryFunc(_gallery3, galleryFile3);
                  },
                  child: CheckoutFormWidget(
                    width: 1.0,
                    label: 'Pick image 3',
                    controller: _gallery3,
                    hintText: 'Pick image 3',
                    isImp: false,
                    textInputType: TextInputType.text,
                    maxLines: 1,
                    enabled: false,
                  ),
                ),
                const SizedBox(height: 10.0),

                // gallery 4

                InkWell(
                  onTap: () async {
                    selectGalleryFunc(_gallery4, galleryFile4);
                  },
                  child: CheckoutFormWidget(
                    width: 1.0,
                    label: 'Pick image 4',
                    controller: _gallery4,
                    hintText: 'Pick image 4',
                    textInputType: TextInputType.text,
                    maxLines: 1,
                    enabled: false,
                  ),
                ),
                const SizedBox(height: 10.0),

                // gallery 5

                InkWell(
                  onTap: () async {
                    selectGalleryFunc(_gallery5, galleryFile5);
                  },
                  child: CheckoutFormWidget(
                    width: 1.0,
                    label: 'Pick image 5',
                    controller: _gallery5,
                    hintText: 'Pick image 5',
                    textInputType: TextInputType.text,
                    maxLines: 1,
                    enabled: false,
                  ),
                ),
              ],
            ),
          ),
        ),

        /* ------------------------------------------------ */
        // ^ add FAQ
        /* ------------------------------------------------ */
        Step(
          state: currentStep > 3 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 3,
          title: const CustomText(
            title: 'FAQs',
            size: 18.0,
            color: CustomColors.primaryTextColor,
            weight: FontWeight.bold,
          ),
          content: Form(
            key: _formKey4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // FAQ 1
                const SizedBox(height: 24.0),
                CheckoutFormWidget(
                  width: 1.0,
                  label: 'What services do you offer as a freelancer?',
                  controller: _faq1,
                  hintText: '',
                  isImp: true,
                  textInputType: TextInputType.multiline,
                  maxLines: null,
                ),

                // FAQ 2
                const SizedBox(height: 24.0),
                CheckoutFormWidget(
                  width: 1.0,
                  label: 'What is your typical turnaround time for projects?',
                  controller: _faq2,
                  hintText: '',
                  isImp: true,
                  textInputType: TextInputType.multiline,
                  maxLines: null,
                ),

                // FAQ 3
                const SizedBox(height: 24.0),
                CheckoutFormWidget(
                  width: 1.0,
                  label: 'How do you handle revisions and feedback?',
                  controller: _faq3,
                  hintText: '',
                  isImp: false,
                  textInputType: TextInputType.multiline,
                  maxLines: null,
                ),

                // FAQ 4
                const SizedBox(height: 24.0),
                CheckoutFormWidget(
                  width: 1.0,
                  label: 'What sets you apart from other freelancers?',
                  controller: _faq4,
                  hintText: '',
                  isImp: false,
                  textInputType: TextInputType.multiline,
                  maxLines: null,
                ),

                // FAQ 5
                const SizedBox(height: 24.0),
                CheckoutFormWidget(
                  width: 1.0,
                  label: 'Can you share samples of your previous work?',
                  controller: _faq5,
                  hintText: '',
                  isImp: false,
                  textInputType: TextInputType.multiline,
                  maxLines: null,
                ),
              ],
            ),
          ),
        ),
      ];
  void selectGalleryFunc(TextEditingController fileName, File? file) async {
    final result = await selectPhoto();
    setState(() {
      fileName.text = result.fileName;
      file = File(result.filePath);
    });
  }
}

class DropdownItem {
  final String id;
  final String categoryName;

  DropdownItem(this.id, this.categoryName);
}
