import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/util/size_utils.dart';

class ContactUsProfileWidget extends StatelessWidget {
  ContactUsProfileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return Column(
      children: [
        Expanded(
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
                  // border: Border.all(color: Colors.black),
                ),
                child: Center(
                  child: Image.asset("assets/ismartlogo.png"),
                ),
              ),
              const Divider(height: 20, color: Colors.black54),
              GridView.builder(
                itemCount: images.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 0.8 / 0.3),
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    // _makePhoneCall(urls[index]);
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
              )
            ]),
          ),
        ),
      ],
    );
  }

  // Future<void> _makePhoneCall(String url) async {
  //   if (await canLaunchUrl(Uri.parse(url))) {
  //     await launchUrl(Uri.parse(url));
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  final List images = [
    "contact us page profile call.svg",
    "website contact us page.svg",
    "location profile ko.svg",
    "website contact us page.svg",
  ];
  final List details = [
    "9801132218",
    "www.devanasoft.com.np",
    "Gaurighatmarga-7,KTM",
    "info@devanasoft.com.np",
  ];
}

final List urls = [
  "",
  "https://www.devanasoft.com.np/",
  "tel:9866556708",
  "mailto:dibashthapa447@gmail.com?subject=Greetings&body=Hello%20World",
];
