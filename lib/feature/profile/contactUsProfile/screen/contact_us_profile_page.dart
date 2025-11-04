import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/feature/appContact/resources/app_contact_repository.dart';
import 'package:ismart/feature/profile/contactUsProfile/screen/contact_us_wrapper.dart';
import 'package:ismart/feature/profile/contactUsProfile/widget/contact_us_profile_widget.dart';

class ContactUsProfilePage extends StatelessWidget {
  final _contactRepo =
      RepositoryProvider.of<AppContactRepository>(NavigationService.context);

  @override
  Widget build(BuildContext context) {
    final List detail = [
      _contactRepo.contactNumber,
      _contactRepo.appContactDetail
                      .findValueString("web")
                      .toString()
                      .toLowerCase() ==
                  "null" ||
              _contactRepo.appContactDetail
                  .findValueString("web")
                  .toString()
                  .isEmpty
          ? "https://devanasoft.com.np/"
          : _contactRepo.appContactDetail.findValueString("web").toString(),
      _contactRepo.appContactDetail
                      .findValueString("address")
                      .toString()
                      .toLowerCase() ==
                  "null" ||
              _contactRepo.appContactDetail.findValueString("address").isEmpty
          ? "Gaurighatmarg , KTM"
          : _contactRepo.appContactDetail.findValueString("address").toString(),
      _contactRepo.appContactDetail
                      .findValueString("email")
                      .toString()
                      .toString() ==
                  "null" ||
              _contactRepo.appContactDetail
                  .findValueString("email")
                  .toString()
                  .isEmpty
          ? "devanasoftpvtltd@gmail.com"
          : _contactRepo.appContactDetail.findValueString("email").toString(),
      // _contactRepo.contactNumber,
      // _contactRepo.appContactDetail.findValue(primaryKey: "web"),
      // _contactRepo.appContactDetail.findValue(primaryKey: "address"),
      // _contactRepo.appContactDetail.findValue(primaryKey: "email"),
    ];
    return ContactUsWrapper(
      latitude: _contactRepo.appContactDetail
          .findValue(primaryKey: "latitude")
          .toString(),
      longitude: _contactRepo.appContactDetail
          .findValue(primaryKey: "longitude")
          .toString(),
      details: detail,
    );
  }
}
