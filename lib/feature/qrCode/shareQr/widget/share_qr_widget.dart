import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ShareQrWidget extends StatelessWidget {
  const ShareQrWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        width: double.infinity,
        margin: const EdgeInsets.fromLTRB(28, 100, 28, 100),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(
              "assets/icons/Group 913.svg",
              color: Color(0XFF4E4E4E),
              height: size.height * 0.04,
            ),
            const Text(
              "My QR Code",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
            Text("Your RQ Code is Displayed below.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall),
            Image.asset(
              "assets/images/QR_Code_Example 1.png",
              height: size.height * 0.3,
            ),
            Text("Pawan Maharjan",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displaySmall),
            Text("98XXXXXXXX",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     shareMyQr(context),
            //     phonePayQr(context),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  // phonePayQr(BuildContext context) {
  //   Size size = MediaQuery.of(context).size;
  //   return MaterialButton(
  //       shape: RoundedRectangleBorder(
  //         side: BorderSide(color: Theme.of(context).primaryColor),
  //         borderRadius: BorderRadius.circular(12),
  //       ),
  //       onPressed: () {},
  //       child: SizedBox(
  //         height: size.height * 0.06,
  //         child: Center(
  //           child: Text(
  //             "Share FonePay QR",
  //             style: TextStyle(
  //                 fontSize: 13, color: Theme.of(context).primaryColor),
  //           ),
  //         ),
  //       ));
  // }

  // shareMyQr(BuildContext context) {
  //   Size size = MediaQuery.of(context).size;
  //   return MaterialButton(
  //       color: Theme.of(context).primaryColor,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(12),
  //       ),
  //       onPressed: () {},
  //       child: SizedBox(
  //         height: size.height * 0.06,
  //         width: size.width * 0.26,
  //         child: const Center(
  //           child: Text(
  //             "Share my QR",
  //             style: TextStyle(fontSize: 12, color: Colors.white),
  //           ),
  //         ),
  //       ));
  // }
}
