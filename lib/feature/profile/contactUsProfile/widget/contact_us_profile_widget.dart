import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/util/url_launcher.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class ContactUsProfileWidget extends StatefulWidget {
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
  State<ContactUsProfileWidget> createState() => _ContactUsProfileWidgetState();
}

class _ContactUsProfileWidgetState extends State<ContactUsProfileWidget> {
  String htmlData = '';
  @override
  Widget build(BuildContext context) {
    final _width = SizeUtils.width;
    final List<Function()> _makeUrlRequest = [
      () {
        UrlLauncher.launchPhone(context: context, phone: widget.details[0]);
      },
      () {
        UrlLauncher.launchWebsite(context: context, url: widget.details[1]);
      },
      () {
        UrlLauncher.launchGoogleMap(
            context: context,
            latitude: widget.latitude == "null" ? "27.714774" : widget.latitude,
            longitude:
                widget.longitude == "null" ? "85.347024" : widget.longitude);
      },
      () {
        UrlLauncher.launchEmail(
          context: context,
          email: widget.details[3],
        );
      }
    ];

    return SingleChildScrollView(
      child: Column(
        children: [
          BlocListener<UtilityPaymentCubit, CommonState>(
            listener: (context, state) {
              if (state is CommonStateSuccess) {
                final UtilityResponseData _res = state.data;
                if (_res.code == "M0000") {
                  if (_res.details.isNotEmpty) {
                    final _response =
                        _res.details.firstWhere((e) => e.title == 'data');
                    if (_response.value is List) {
                      final valueList = _response.value as List;
                      final aboutUsMap = valueList.firstWhere(
                        (element) =>
                            element['title'].toLowerCase() as String ==
                            'about us',
                        orElse: () => null,
                      );
                      if (aboutUsMap != null && aboutUsMap['info'] != null) {
                        final htmlContent = aboutUsMap['info'];

                        setState(() {
                          htmlData = htmlContent;
                        });
                      }
                    }
                  }
                }
              }
            },
            child: Container(
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
                        RepositoryProvider.of<CoOperative>(context)
                            .bannerImage),
                  ),
                ),
                // const Divider(height: 20, color: Colors.black54),
                if (htmlData.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Container(
                      child: Html(
                        data: htmlData,
                        style: {
                          "body": Style(
                            fontSize: FontSize(12.0),
                          ),
                        },
                      ),
                    ),
                  ),
                // Divider(),
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
                      widget.details[index],
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
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
