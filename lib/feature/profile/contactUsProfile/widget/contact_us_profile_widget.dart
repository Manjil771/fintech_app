import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/util/url_launcher.dart';

class ContactUsProfileWidget extends StatelessWidget {
  final String latitude;
  final String longitude;
  final List details;
  const ContactUsProfileWidget(
      {Key? key,
      required this.details,
      required this.latitude,
      required this.longitude})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _width = SizeUtils.width;
    final List<Function()> _makeUrlRequest = [
      () {
        UrlLauncher.launchPhone(context: context, phone: details[0]);
      },
      () {
        UrlLauncher.launchWebsite(context: context, url: details[1]);
      },
      () {
        UrlLauncher.launchGoogleMap(
            context: context,
            latitude: latitude == "null" ? "27.714774" : latitude,
            longitude: longitude == "null" ? "85.347024" : longitude);
      },
      () {
        UrlLauncher.launchEmail(
          context: context,
          email: details[4],
        );
      }
    ];

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: CustomTheme.white),
          child: Column(children: [
            Container(
              margin: const EdgeInsets.all(20),
              height: _width * 0.21,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: Center(
                child: Image.asset(
                    RepositoryProvider.of<CoOperative>(context).bannerImage),
              ),
            ),
            const Divider(height: 20, color: Colors.black54),
            ListView.builder(
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: images.length,
              itemBuilder: (context, index) => ListTile(
                onTap: _makeUrlRequest[index],
                leading: Container(
                  width: _width * 0.07,
                  height: _width * 0.07,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black),
                  ),
                  child: SvgPicture.asset("assets/icons/${images[index]}"),
                ),
                title: Text(
                  details[index],
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            )
          ]),
        ),
      ],
    );
    // } else {
    //   return Container();
    // }
    // });
  }
}

final List images = [
  "contact us page profile call.svg",
  "website contact us page.svg",
  "location profile ko.svg",
  "website contact us page.svg",
];
