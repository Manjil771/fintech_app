// lib/services/category_service.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/constant/slugs.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/widget/common_bill_details_screen.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/feature/categoryWiseService/Topup/ui/screens/mobile_topup_page.dart';
import 'package:ismart/feature/categoryWiseService/airlines/screen/airline_page.dart';
import 'package:ismart/feature/categoryWiseService/broker/screen/broker_payment_page.dart';
import 'package:ismart/feature/categoryWiseService/busBooking/screen/bus_booking_page.dart';
// import 'package:ismart/feature/categoryWiseService/creditCard/screen/credit_card_payment_page.dart';
import 'package:ismart/feature/categoryWiseService/electricity/screen/electricity_payment_page.dart';
import 'package:ismart/feature/categoryWiseService/landline/screen/landline_payment_page.dart';
// import 'package:ismart/feature/categoryWiseService/landline/screen/landline_payment_page.dart';
import 'package:ismart/feature/categoryWiseService/movie/screen/movie_page.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/cubit/category_cubit.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
// import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/screen/category_wise_services_page.dart';

class CategoryService {
  static final CategoryService _instance = CategoryService._internal();
  factory CategoryService() => _instance;
  CategoryService._internal();

  List<CategoryList> _categoryList = [];
  bool _isInitialized = false;

  CategoryList? categoryList;

  List<ServiceList> selectedService = [];
  List<ServiceList> getTopupType(String phoneNumber) {
    if (phoneNumber.startsWith("+977")) {
      phoneNumber = phoneNumber.substring(4);
    }

    final String firstThreeDigits = phoneNumber.substring(0, 3);

    final List<ServiceList> services = categoryList!.services;

    final List<ServiceList> filteredServices = services.where((service) {
      final List<String> prefixes = service.labelPrefix.split(',');
      return prefixes.any((prefix) => prefix == firstThreeDigits);
    }).toList();
    selectedService = filteredServices;
    return filteredServices;
  }

  Future<void> initialize(BuildContext context) async {
    if (!_isInitialized) {
      await context.read<CategoryCubit>().fetchCategory();
      _isInitialized = true;
    }
  }

  void updateCategoryList(List<CategoryList> categories) {
    _categoryList = categories;
    _isInitialized = true;
  }

  CategoryList? getCategoryByIdentifier(String identifier) {
    try {
      return _categoryList.firstWhere(
        (category) =>
            category.uniqueIdentifier.toLowerCase() == identifier.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  // void navigateToMobileTopup(BuildContext context) {
  //   final category = getCategoryByIdentifier(Slugs.topup);
  //   if (category != null) {
  //     NavigationService.push(target: MobileTopupPage(categoryList: category));
  //   }
  // }

  void navigateToMobileTopup(BuildContext context) {
    final topupCategory = _categoryList.firstWhere(
      (category) =>
          category.uniqueIdentifier.toLowerCase() == Slugs.topup.toLowerCase(),
      // orElse: () => null,
    );

    if (topupCategory != null) {
      NavigationService.push(
          target: MobileTopupPage(categoryList: topupCategory));
    }
  }

  void topupWithAmount(
    BuildContext context,
    String amount,
    String mobileNumber,
  ) {
    final topupCategory = _categoryList.firstWhere(
      (category) =>
          category.uniqueIdentifier.toLowerCase() == Slugs.topup.toLowerCase(),
    );

    categoryList = topupCategory;
    getTopupType(mobileNumber);
    if (topupCategory != null) {
      NavigationService.push(
          target: CommonBillDetailPage(
        verificationAmount: amount,
        serviceName: selectedService.first.service,
        service: getTopupType(mobileNumber).first,
        apiBody: const {},
        serviceIdentifier: getTopupType(mobileNumber).first.uniqueIdentifier,
        accountDetails: {
          "account_number":
              RepositoryProvider.of<CustomerDetailRepository>(context)
                  .selectedAccount
                  .value!
                  .accountNumber,
          "phone_number": mobileNumber,
          "amount": amount
        },
        apiEndpoint: "/api/topup",
        body: Column(
          children: [
            KeyValueTile(title: "Target Number", value: mobileNumber),
            KeyValueTile(title: "Amount", value: amount),
          ],
        ),
      ));
    }
  }

  void navigateToBrokerPayment(BuildContext context) {
    final category = _categoryList.firstWhere(
      (category) =>
          category.uniqueIdentifier.toLowerCase() ==
          Slugs.brokerPage.toLowerCase(),
    );

    if (category != null) {
      NavigationService.push(
          target: BrokerPaymentPage(service: category.services.first));
    }
  }

  void navigateToElectricityPayment(BuildContext context) {
    final category = _categoryList.firstWhere(
      (category) => category.uniqueIdentifier.toLowerCase() == "electricity",
    );

    if (category != null) {
      NavigationService.push(
          target: ElectricityPaymentPage(service: category.services[0]));
    }
  }

  void navigateToAirlines(BuildContext context) {
    final category = _categoryList.firstWhere(
      (category) => category.uniqueIdentifier.toLowerCase() == "airlines",
    );

    if (category != null) {
      NavigationService.push(
          target: AirlinesIntroPage(service: category.services[0]));
    }
  }

  void navigateToMovie(BuildContext context) {
    final category = _categoryList.firstWhere(
      (category) => category.uniqueIdentifier.toLowerCase() == "movies",
    );

    if (category != null) {
      NavigationService.push(target: MoviePage(category: category));
    }
  }

  void navigateToLandline(BuildContext context) {
    final category = _categoryList.firstWhere(
      (category) =>
          category.uniqueIdentifier.toLowerCase() == "landline" ||
          category.uniqueIdentifier.toString().toLowerCase() ==
              "category".toLowerCase(),
    );

    if (category != null) {
      NavigationService.push(target: LandlinePaymentPage(category: category));
    }
  }

  void navigateToBusBooking(BuildContext context) {
    final category = _categoryList.firstWhere(
      (category) => category.uniqueIdentifier.toLowerCase() == Slugs.busTicket,
    );

    if (category != null) {
      NavigationService.push(
          target: BusBookingPage(service: category.services.first));
    }
  }

  // void navigateToService(BuildContext context, String identifier) {
  //   final category = getCategoryByIdentifier(identifier);
  //   if (category != null) {
  //     NavigationService.push(
  //       target: CategoriesWiseServicePage(
  //         uniqueIdentifier: category.uniqueIdentifier,
  //         services: category.services,
  //         topBarName: category.name,
  //       ),
  //     );
  //   }
  // }
}
