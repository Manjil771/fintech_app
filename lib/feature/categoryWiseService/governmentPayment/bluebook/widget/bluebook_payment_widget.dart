import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/constant/fonts.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/util/snackbar_utils.dart';
import 'package:ismart/common/widget/common_bill_details_screen.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_loading_widget.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/custom_checkbox.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/categoryWiseService/governmentPayment/bluebook/cubit/bluebook_payment_cubit.dart';
import 'package:ismart/feature/categoryWiseService/governmentPayment/bluebook/screen/bluebook_details_page.dart';
import 'package:ismart/feature/categoryWiseService/governmentPayment/bluebook/widget/bluebook_bottomsheet_districts.dart';
import 'package:ismart/feature/categoryWiseService/governmentPayment/bluebook/widget/bluebook_bottomsheet_widget.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:nepali_utils/nepali_utils.dart';

class BlueBookRenewalWidget extends StatefulWidget {
  final ServiceList service;
  const BlueBookRenewalWidget({Key? key, required this.service})
      : super(key: key);

  @override
  State<BlueBookRenewalWidget> createState() => _BlueBookRenewalWidgetState();
}

class _BlueBookRenewalWidgetState extends State<BlueBookRenewalWidget> {
  final _formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final provinceController = TextEditingController();
  final districtController = TextEditingController();
  final pickUpLocationController = TextEditingController();
  final lanmarkLocationController = TextEditingController();
  final emailController = TextEditingController();
  bool isInsurance = false;
  bool isSameDayDelivery = false;
  final vehicleTypeController = TextEditingController();
  final vehicleNatureController = TextEditingController();
  final vehicleCubicCapacity = TextEditingController();
  final vehicleSeatCapacity = TextEditingController();
  final mobileNumberController = TextEditingController();

  DateTime? toDate;
  DateTime? fromDate;
  DateTime filtertoDate = DateTime.now();
  DateTime filterfromDate = DateTime.now().subtract(const Duration(days: 360));

  String? provincevalue;
  int? distrcitvalue;
  String? pickupLocationValue;
  String? officevalue;
  String? officeCodevalue;
  String? zoneValue;
  String? symbolvalue;
  String? vehicleTypevalue;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
      body: BlocListener<BluebookPaymentCubit, CommonState>(
        listener: (context, state) {
          if (state is CommonLoading && _isLoading == false) {
            _isLoading = true;
            showLoadingDialogBox(context);
          } else if (state is! CommonLoading && _isLoading) {
            _isLoading = false;
            NavigationService.pop();
          }
          if (state is CommonError) {
            showPopUpDialog(
              context: context,
              message: state.message,
              title: "Error",
              showCancelButton: false,
              buttonCallback: () {
                NavigationService.pop();
              },
            );
          }
          if (state is CommonStateSuccess<UtilityResponseData>) {
            final UtilityResponseData _response = state.data;
            if (_response.code == "M0000" &&
                _response.status.toLowerCase() == "success") {
              // NavigationService.push(
              //     target: BlueBookDetailsPage(
              //   response: _response,
              // ));
              NavigationService.push(
                  target: CommonBillDetailPage(
                      serviceName: widget.service.service,
                      body: Column(
                        children: [
                          KeyValueTile(
                              title: "Full Name",
                              value:
                                  _response.findValue(primaryKey: "fullName")),
                          KeyValueTile(
                              title: "Email",
                              value: _response.findValue(primaryKey: "email")),
                          KeyValueTile(
                              title: "Pick Up Location",
                              value: _response.findValue(
                                  primaryKey: "pickupLocation")),
                          KeyValueTile(
                              title: "Vehicle Type/Nature",
                              value:
                                  "${_response.findValue(primaryKey: "vehicleType")}/${_response.findValue(primaryKey: "vehicleNature")}"),
                          KeyValueTile(
                              title: "Blue Book No",
                              value: _response.findValue(
                                  primaryKey: "blueBookNo")),
                          KeyValueTile(
                              title: "Registered Date",
                              value: _response.findValue(
                                  primaryKey: "registerDate")),
                          const Divider(),
                          KeyValueTile(
                              title: "Vehicle Total Tax",
                              value: _response.findValue(
                                  primaryKey: "vehicleTaxTotal")),
                          KeyValueTile(
                              title: "Renewal Charge",
                              value: _response.findValue(
                                  primaryKey: "renewalCharge")),
                          KeyValueTile(
                              title: "Service Charge",
                              value: _response.findValue(
                                  primaryKey: "serviceCharge")),
                          KeyValueTile(
                              title: "Vehicle Total Fine",
                              value: _response.findValue(
                                  primaryKey: "vehicleFineTotal")),
                          KeyValueTile(
                              title: "Total Income Tax",
                              value: _response.findValue(
                                  primaryKey: "incomeTaxTotal")),
                          KeyValueTile(
                              title: "Total Income Fine",
                              value: _response.findValue(
                                  primaryKey: "incomeFineTotal")),
                          KeyValueTile(
                              title: "Renewal Fine",
                              value: _response.findValue(
                                  primaryKey: "renewalFine")),
                          KeyValueTile(
                              title: "Insurance Amount",
                              value: _response.findValue(
                                  primaryKey: "insuranceAmount")),
                          KeyValueTile(
                              title: "Discount",
                              value:
                                  _response.findValue(primaryKey: "discount")),
                          KeyValueTile(
                              title: "Total Payable Amount",
                              value: _response.findValue(
                                  primaryKey: "totalPayableAmount")),
                        ],
                      ),
                      accountDetails: {
                        "accountNumber":
                            RepositoryProvider.of<CustomerDetailRepository>(
                                    context)
                                .selectedAccount
                                .value!
                                .accountNumber,
                      },
                      apiEndpoint: "/api/vehicle/registration/pay",
                      apiBody: {
                        // "accountNumber":
                        //     RepositoryProvider.of<CustomerDetailRepository>(
                        //             context)
                        //         .selectedAccount
                        //         .value!
                        //         .accountNumber,
                        // "mobileNumber":
                        //     _response.findValue(primaryKey: "phone"),
                        "amount": _response.findValue(
                            primaryKey: "totalPayableAmount"),
                        // "remarks": "Bluebook Payment",
                        // "transactionIdentifier": "TXN123456",
                        // "bankName": "Nabil Bank",
                        // "verificationUniqueId": "VERIF123456",
                        // "customerName":
                        //     _response.findValue(primaryKey: "fullName"),
                        // "address": "Kathmandu",
                        // "orderId": "BB-55BB65",
                        // "partnerTransactionId": "PTX-7890"
                        "sessionId": _response.findValue(primaryKey: "Orderid"),
                      },
                      service: widget.service,
                      serviceIdentifier: widget.service.uniqueIdentifier));
            } else {
              showPopUpDialog(
                context: context,
                message: _response.message,
                title: _response.status,
                showCancelButton: false,
                buttonCallback: () {
                  NavigationService.pop();
                },
              );
            }
          }
        },
        child: BlocConsumer<UtilityPaymentCubit, CommonState>(
          builder: (context, state) {
            if (state is CommonStateSuccess<UtilityResponseData>) {
              final List provincesList =
                  state.data.findValue(primaryKey: "provinces");
              final List districtList =
                  state.data.findValue(primaryKey: "district");
              final List pickUplocationList =
                  state.data.findValue(primaryKey: "pickup_location");
              return CommonContainer(
                onButtonPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<BluebookPaymentCubit>().fetchBluebookDetail(
                        serviceIdentifier: "",
                        accountDetails: {},
                        body: {
                          "full_name": fullNameController.text,
                          "email": emailController.text,
                          "mobile_number": mobileNumberController.text,
                          // "mobile_number": "9865453082",
                          "pickup_location": pickupLocationValue ?? '',
                          "landmark": lanmarkLocationController.text,
                          "city": districtController.text,
                          "province_id": provinceController.text,
                          "vehicle_nature": vehicleNatureController.text,
                          "vehicle_type": vehicleTypeController.text,
                          "is_insurance": isInsurance,
                          "vehicle_cubic_capacity":
                              int.tryParse(vehicleCubicCapacity.text),
                          "seat_capacity":
                              int.tryParse(vehicleSeatCapacity.text),
                          "same_day_delivery": isSameDayDelivery,
                          "start_date":
                              "${fromDate?.year}-${fromDate?.month}-${fromDate?.day}",
                          "end_date":
                              "${toDate?.year}-${toDate?.month}-${toDate?.day}",
                          "citizenship_front_image":
                              fileToBase64(_citizenshipFront) ?? "",
                          "citizenship_back_image":
                              fileToBase64(_citizenshipBack) ?? "",
                          "latest_owner_info_page_image":
                              fileToBase64(_ownerInfo) ?? "",
                          "vehicle_info_page_image":
                              fileToBase64(_vehicleInfo) ?? "",
                          "vehicle_number_image":
                              fileToBase64(_vehicleNumberImage) ?? "",
                        },
                        apiEndpoint: "api/vehicle/registration/vehicle/details",
                        mPin: "");
                  }
                },
                showDetail: true,
                buttonName: "Proceed",
                topbarName: widget.service.serviceCategoryName,
                title: widget.service.service,
                detail: widget.service.instructions,
                body: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        controller: fullNameController,
                        validator: (value) =>
                            FormValidator.validateFieldNotEmpty(
                                value, "Full Name"),
                        title: "Full Name",
                        hintText: "Full Name*",
                      ),
                      CustomTextField(
                        onTap: () {
                          showBottomSheet(
                            context: context,
                            builder: (context) => Container(
                              child: BlueBookBottomSheet(
                                onPress: (name, id) {
                                  setState(() {
                                    provinceController.text = name;
                                    provincevalue = id;
                                    pickUpLocationController.clear();
                                    districtController.clear();
                                  });
                                },
                                showCancelButton: true,
                                showTopDivider: true,
                                title: "Province",
                                items: provincesList,
                              ),
                            ),
                          );
                        },
                        validator: (value) =>
                            FormValidator.validateFieldNotEmpty(
                                value, "Province"),
                        readOnly: true,
                        title: "Province",
                        controller: provinceController,
                        hintText: "Select From List",
                      ),
                      CustomTextField(
                        validator: (value) =>
                            FormValidator.validateFieldNotEmpty(
                                value, "district"),
                        onTap: () {
                          if (provincevalue != null) {
                            if (districtList.any((key) =>
                                key["provience_id"] ==
                                int.tryParse(provincevalue!))) {
                              showBottomSheet(
                                context: context,
                                builder: (context) => Container(
                                  child: BluebookBottomsheetDistricts(
                                    onPress: (name, id) {
                                      setState(() {
                                        districtController.text = name;
                                        distrcitvalue = int.tryParse(id);
                                        pickUpLocationController.clear();
                                      });
                                    },
                                    items: districtList.firstWhere((key) =>
                                            key["provience_id"] ==
                                            int.tryParse(provincevalue!))[
                                        "districts"] as List,
                                  ),
                                ),
                              );
                            } else {
                              SnackBarUtils.showErrorBar(
                                  context: context,
                                  message:
                                      "There are no district available in this province!");
                            }
                          } else {
                            SnackBarUtils.showErrorBar(
                                context: context,
                                message: "Select the province first!");
                          }
                        },
                        readOnly: true,
                        title: "Districts",
                        controller: districtController,
                        hintText: "Select From List",
                      ),
                      CustomTextField(
                        validator: (value) =>
                            FormValidator.validateFieldNotEmpty(
                                value, "pickUp location"),
                        onTap: () {
                          if (distrcitvalue != null) {
                            if (pickUplocationList.any((key) =>
                                key["district_id"] == distrcitvalue!)) {
                              showBottomSheet(
                                context: context,
                                builder: (context) => Container(
                                  child: BluebookBottomsheetDistricts(
                                    isPickUplocation: true,
                                    onPress: (name, id) {
                                      setState(() {
                                        pickUpLocationController.text = name;
                                        pickupLocationValue = name;
                                      });
                                    },
                                    items: pickUplocationList.firstWhere(
                                            (key) =>
                                                key["district_id"] ==
                                                distrcitvalue!)[
                                        "pickup_location"] as List,
                                  ),
                                ),
                              );
                            } else {
                              SnackBarUtils.showErrorBar(
                                  context: context,
                                  message:
                                      "There is no pickup location available here!");
                            }
                          } else {
                            SnackBarUtils.showErrorBar(
                                context: context,
                                message: "Select the district first!");
                          }
                        },
                        readOnly: true,
                        title: "PickUp Location",
                        controller: pickUpLocationController,
                        hintText: "Select From List",
                      ),
                      CustomTextField(
                        controller: lanmarkLocationController,
                        validator: (value) =>
                            FormValidator.validateFieldNotEmpty(
                                value, "Lanmark Location"),
                        title: "Landmark Location",
                        hintText: "***buddhanagar",
                      ),
                      CustomTextField(
                        controller: mobileNumberController,
                        validator: (value) =>
                            FormValidator.validatePhoneNumber(value),
                        title: "Mobile Number",
                        hintText: "9866######",
                      ),
                      CustomTextField(
                        controller: emailController,
                        validator: (value) =>
                            FormValidator.validateEmail(value),
                        title: "Email",
                        hintText: "****@gmail.com",
                      ),
                      CustomCheckbox(
                        selected: isInsurance,
                        onChanged: (val) {
                          setState(() {
                            isInsurance = !isInsurance;
                          });
                        },
                        title: "Has Insurance",
                      ),
                      CustomTextField(
                        validator: (value) =>
                            FormValidator.validateFieldNotEmpty(
                                value, "Vehicles Type"),
                        onTap: () {
                          showBottomSheet(
                            context: context,
                            builder: (context) => Container(
                                child: BluebookBottomsheetDistricts(
                              isPickUplocation: true,
                              onPress: (name, id) {
                                setState(() {
                                  vehicleTypeController.text = name;
                                  vehicleTypevalue = id;
                                });
                              },
                              showTopDivider: true,
                              title: "Vehicle Type",
                              items: const [
                                "2 Wheeler",
                                "3 Wheeler",
                                "4 Wheeler"
                              ],
                            )),
                          );
                        },
                        readOnly: true,
                        title: "Vehicle Type",
                        controller: vehicleTypeController,
                        hintText: "Select From List",
                      ),
                      CustomTextField(
                        validator: (value) =>
                            FormValidator.validateFieldNotEmpty(
                                value, "Vehicles Nature"),
                        onTap: () {
                          showBottomSheet(
                            context: context,
                            builder: (context) => Container(
                                child: BluebookBottomsheetDistricts(
                              isPickUplocation: true,
                              onPress: (name, id) {
                                setState(() {
                                  vehicleNatureController.text = name;
                                });
                              },
                              showTopDivider: true,
                              title: "Vehicle nature",
                              items: const [
                                "Electric",
                                "Non-Electric",
                              ],
                            )),
                          );
                        },
                        readOnly: true,
                        title: "Vehicle Nature",
                        controller: vehicleNatureController,
                        hintText: "Select From List",
                      ),
                      CustomTextField(
                        textInputType: TextInputType.number,
                        controller: vehicleCubicCapacity,
                        validator: (value) =>
                            FormValidator.validateFieldNotEmpty(
                                value, "Vehicle Cubic Capacity"),
                        title: "Vehicle Cubic Capacity",
                        hintText: "220",
                      ),
                      CustomTextField(
                        textInputType: TextInputType.number,
                        controller: vehicleSeatCapacity,
                        validator: (value) =>
                            FormValidator.validateFieldNotEmpty(
                                value, "Vehicle Seat Capacity"),
                        title: "Vehicle Seat Capacity",
                        hintText: "4",
                      ),
                      CustomTextField(
                        validator: (value) {
                          if (fromDate == null) {
                            return "Enter date here!";
                          }
                          return null;
                        },
                        readOnly: true,
                        onTap: () async {
                          DateTime? picked;
                          final NepaliDateTime? pickedDate =
                              await showMaterialDatePicker(
                            builder: (context, child) => Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: CustomTheme.primaryColor,
                                  onPrimary: Colors.white,
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    foregroundColor: CustomTheme.primaryColor,
                                  ),
                                ),
                              ),
                              child: child!,
                            ),
                            context: context,
                            initialDate: NepaliDateTime.now(),
                            firstDate: NepaliDateTime(2070),
                            lastDate: NepaliDateTime(2090),
                            initialDatePickerMode: DatePickerMode.day,
                          );
                          picked = pickedDate;

                          if (picked != null) {
                            setState(() {
                              fromDate = picked!;
                            });
                          }
                        },
                        title: "From Date(BS)",
                        hintText:
                            "${filtertoDate.year}-${filtertoDate.month.toString().padLeft(2, '0')}-${filtertoDate.day.toString().padLeft(2, '0')}",
                        showSuffixImage: true,
                      ),
                      CustomTextField(
                        validator: (value) {
                          if (toDate == null) {
                            return "Enter date here!";
                          }
                          return null;
                        },
                        readOnly: true,
                        onTap: () async {
                          DateTime? picked;
                          final NepaliDateTime? pickedDate =
                              await showMaterialDatePicker(
                            builder: (context, child) => Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: CustomTheme.primaryColor,
                                  onPrimary: Colors.white,
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    foregroundColor: CustomTheme.primaryColor,
                                  ),
                                ),
                              ),
                              child: child!,
                            ),
                            context: context,
                            initialDate: NepaliDateTime.now(),
                            firstDate: NepaliDateTime(2070),
                            lastDate: NepaliDateTime(2090),
                            initialDatePickerMode: DatePickerMode.day,
                          );
                          picked = pickedDate;
                          if (picked != null) {
                            setState(() {
                              toDate = picked!;
                            });
                          }
                        },
                        title: "To Date(BS)",
                        hintText:
                            "${filtertoDate.year}-${filtertoDate.month.toString().padLeft(2, '0')}-${filtertoDate.day.toString().padLeft(2, '0')}",
                        showSuffixImage: true,
                      ),
                      CustomCheckbox(
                        selected: isSameDayDelivery,
                        onChanged: (val) {
                          setState(() {
                            isSameDayDelivery = !isSameDayDelivery;
                          });
                        },
                        title: "Same Day Delivery",
                      ),
                      const Text(
                        "Citizenship Front Image",
                        style: TextStyle(
                          fontFamily: Fonts.poppin,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: CustomTheme.lightTextColor,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _pickImage((file) => _citizenshipFront = file);
                        },
                        child: _citizenshipFront == null
                            ? Container(
                                width: _width,
                                decoration: BoxDecoration(
                                    color:
                                        _theme.primaryColor.withOpacity(0.05),
                                    borderRadius: BorderRadius.circular(18)),
                                height: _height * 0.2,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        Assets.uploadImageIcon,
                                        height: 50.hp,
                                      ),
                                      SizedBox(height: 10.hp),
                                      Text(
                                        "Upload Picture(Optional)",
                                        style: _textTheme.titleSmall,
                                      )
                                    ]),
                              )
                            : Container(
                                alignment: Alignment.center,
                                height: 140.hp,
                                child: Image.file(_citizenshipFront!),
                              ),
                      ),
                      SizedBox(
                        height: 6.hp,
                      ),
                      const Text(
                        "Citizenship Back Image",
                        style: TextStyle(
                          fontFamily: Fonts.poppin,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: CustomTheme.lightTextColor,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _pickImage((file) => _citizenshipBack = file);
                        },
                        child: _citizenshipBack == null
                            ? Container(
                                width: _width,
                                decoration: BoxDecoration(
                                    color:
                                        _theme.primaryColor.withOpacity(0.05),
                                    borderRadius: BorderRadius.circular(18)),
                                height: _height * 0.2,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        Assets.uploadImageIcon,
                                        height: 50.hp,
                                      ),
                                      SizedBox(height: 10.hp),
                                      Text(
                                        "Upload Picture(Optional)",
                                        style: _textTheme.titleSmall,
                                      )
                                    ]),
                              )
                            : Container(
                                alignment: Alignment.center,
                                height: 140.hp,
                                child: Image.file(_citizenshipBack!),
                              ),
                      ),
                      SizedBox(
                        height: 6.hp,
                      ),
                      const Text(
                        "Owner Info Image",
                        style: TextStyle(
                          fontFamily: Fonts.poppin,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: CustomTheme.lightTextColor,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _pickImage((file) => _ownerInfo = file);
                        },
                        child: _ownerInfo == null
                            ? Container(
                                width: _width,
                                decoration: BoxDecoration(
                                    color:
                                        _theme.primaryColor.withOpacity(0.05),
                                    borderRadius: BorderRadius.circular(18)),
                                height: _height * 0.2,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        Assets.uploadImageIcon,
                                        height: 50.hp,
                                      ),
                                      SizedBox(height: 10.hp),
                                      Text(
                                        "Upload Picture(Optional)",
                                        style: _textTheme.titleSmall,
                                      )
                                    ]),
                              )
                            : Container(
                                alignment: Alignment.center,
                                height: 140.hp,
                                child: Image.file(_ownerInfo!),
                              ),
                      ),
                      SizedBox(
                        height: 6.hp,
                      ),
                      const Text(
                        "Vehicle Info Image",
                        style: TextStyle(
                          fontFamily: Fonts.poppin,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: CustomTheme.lightTextColor,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _pickImage((file) => _vehicleInfo = file);
                        },
                        child: _vehicleInfo == null
                            ? Container(
                                width: _width,
                                decoration: BoxDecoration(
                                    color:
                                        _theme.primaryColor.withOpacity(0.05),
                                    borderRadius: BorderRadius.circular(18)),
                                height: _height * 0.2,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        Assets.uploadImageIcon,
                                        height: 50.hp,
                                      ),
                                      SizedBox(height: 10.hp),
                                      Text(
                                        "Upload Picture(Optional)",
                                        style: _textTheme.titleSmall,
                                      )
                                    ]),
                              )
                            : Container(
                                alignment: Alignment.center,
                                height: 140.hp,
                                child: Image.file(_vehicleInfo!),
                              ),
                      ),
                      SizedBox(
                        height: 6.hp,
                      ),
                      const Text(
                        "Vehicle Number Image",
                        style: TextStyle(
                          fontFamily: Fonts.poppin,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: CustomTheme.lightTextColor,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _pickImage((file) => _vehicleNumberImage = file);
                        },
                        child: _vehicleNumberImage == null
                            ? Container(
                                width: _width,
                                decoration: BoxDecoration(
                                    color:
                                        _theme.primaryColor.withOpacity(0.05),
                                    borderRadius: BorderRadius.circular(18)),
                                height: _height * 0.2,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        Assets.uploadImageIcon,
                                        height: 50.hp,
                                      ),
                                      SizedBox(height: 10.hp),
                                      Text(
                                        "Upload Picture(Optional)",
                                        style: _textTheme.titleSmall,
                                      )
                                    ]),
                              )
                            : Container(
                                alignment: Alignment.center,
                                height: 140.hp,
                                child: Image.file(_vehicleNumberImage!),
                              ),
                      ),
                    ],
                  ),
                ),
              );
            }
            if (state is CommonLoading) {
              return const CommonLoadingWidget();
            } else {
              return Container();
            }
          },
          listener: (context, state) {
            if (state is CommonLoading && _isLoading == false) {
              _isLoading = true;
              showLoadingDialogBox(context);
            } else if (state is! CommonLoading && _isLoading) {
              _isLoading = false;
              NavigationService.pop();
            }
            if (state is CommonError) {
              showPopUpDialog(
                context: context,
                message: state.message,
                title: "Error",
                showCancelButton: false,
                buttonCallback: () {
                  NavigationService.pop();
                },
              );
            }
          },
        ),
      ),
    );
  }

  File? _citizenshipFront;
  File? _citizenshipBack;
  File? _ownerInfo;
  File? _vehicleInfo;
  File? _vehicleNumberImage;
  Future<void> _pickImage(Function(File) onImagePicked) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        onImagePicked(File(pickedFile.path));
      });
    } else {
      NavigationService.pop();
    }
  }

  String? fileToBase64(File? file) {
    if (file == null) return null;
    final bytes = file.readAsBytesSync();
    return base64Encode(bytes);
  }
}
