import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsProfileWidget extends StatelessWidget {
  final List details;
  ContactUsProfileWidget({Key? key, required this.details}) : super(key: key);
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    // return BlocBuilder<UtilityPaymentCubit, CommonState>(
    //     builder: (context, state) {
    //   if (state is CommonLoading && !_isLoading) {
    //     _isLoading = true;
    //     showLoadingDialogBox(context);
    //   } else if (state is! CommonLoading && _isLoading) {
    //     _isLoading = false;
    //     NavigationService.pop();
    //   }

    //   if (state is CommonStateSuccess<UtilityResponseData>) {
    //     final res = state.data;
    //     final List details = [
    //       res.findValueString("contactNumber"),
    //       res.findValueString("registerUrl"),
    //       res.findValueString("address"),
    //       res.findValueString("email"),
    //     ];
    return Column(
      children: [
        Container(
          height: _height * 0.37,
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
                // border: Border.all(color: Colors.black),
              ),
              child: Center(
                child: Image.asset(
                    RepositoryProvider.of<CoOperative>(context).bannerImage),
              ),
            ),
            const Divider(height: 20, color: Colors.black54),
            Expanded(
              child: GridView.builder(
                itemCount: images.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 0.8 / 0.3),
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    _makeUrlRequest(urls[index]);
                  },
                  child: Row(
                    children: [
                      Container(
                        width: _width * 0.07,
                        height: _width * 0.07,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black),
                        ),
                        child:
                            SvgPicture.asset("assets/icons/${images[index]}"),
                      ),
                      Expanded(
                        child: Text(
                          details[index],
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
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

Future<void> _makeUrlRequest(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Could not launch $url';
  }
}

final List images = [
  "contact us page profile call.svg",
  "website contact us page.svg",
  "location profile ko.svg",
  "website contact us page.svg",
];

final List urls = [
  "",
  "https://www.devanasoft.com.np/",
  "https://www.google.com/maps/search/?api=1&query=27.714774,85.347024",
  "mailto:info@devanasoft.com.np?subject=Greetings&body=Hello%",
];
