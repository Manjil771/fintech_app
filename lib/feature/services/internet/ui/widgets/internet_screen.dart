import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class InternetListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12))),
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Internet Payment",
                      style: Theme.of(context).textTheme.titleLarge),
                  Text(
                    "Pay your internet bill of you ISP from here",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  SizedBox(height: size.height * 0.01),
                  Text("Choose Service Provider",
                      style: Theme.of(context).textTheme.titleMedium),
                  SizedBox(height: size.height * 0.01),
                  SizedBox(
                    height: size.height / 3,
                    child: GridView.builder(
                      itemCount: names.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3, childAspectRatio: 1 / 1.2),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.all(8),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 18),
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.05),
                                          offset: const Offset(0, 4),
                                          blurRadius: 4,
                                        ),
                                      ],
                                      color: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.05),
                                      borderRadius: BorderRadius.circular(18)),
                                ),
                              ),
                              Text(
                                names[index],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontFamily: "poinssemibold",
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Center(
                    child: Text("OR",
                        style: Theme.of(context).textTheme.headlineSmall),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: size.height * 0.06,
                          child: TextFormField(
                            textAlign: TextAlign.left,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color(0XFFF3F3F3),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.black12)),
                                hintText: "Search",
                                hintStyle: const TextStyle(fontSize: 16)),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 18),
                        padding: const EdgeInsets.all(12),
                        width: size.width * 0.115,
                        height: size.height * 0.06,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Theme.of(context).primaryColor,
                          // border: Border.all(color: Colors.black),
                        ),
                        child: SvgPicture.asset(
                          "assets/icons/arrowrightfull.svg",
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  final List names = [
    "NTC FTTH",
    "WorldLink",
    "Classic Tech",
    "Dish Home",
    "CG Net",
    "Subishu Internet",
  ];
}
