import 'package:flutter/material.dart';
import 'package:ismart/common/enum/counters_fetch_enum.dart';
import 'package:ismart/common/models/key_value.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/categoryWiseService/electricity/screen/electricity_search_page.dart';

class KhanePaniWidget extends StatefulWidget {
  const KhanePaniWidget({Key? key}) : super(key: key);

  @override
  State<KhanePaniWidget> createState() => _KhanePaniWidgetState();
}

class _KhanePaniWidgetState extends State<KhanePaniWidget> {
  final TextEditingController _selectedCounterController =
      TextEditingController();
  KeyValue? selectedCounter;
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
      body: CommonContainer(
          buttonName: "Show Bill",
          showAccountSelection: true,
          title: "Khane Pani",
          detail: "Pay for your water bill from here.",
          showDetail: true,
          topbarName: "Khane Pani",
          body: Column(
            children: [
              CustomTextField(
                title: "Select Counter",
                hintText: "Select From List",
                readOnly: true,
                controller: _selectedCounterController,
                onTap: () {
                  NavigationService.push(
                      target: CounterSearchPage(
                    counterType: CountersEnums.Khanepani,
                    onChanged: (val) {
                      selectedCounter = val;
                      _selectedCounterController.text =
                          selectedCounter?.title ?? "";
                    },
                  ));
                },
              ),
              CustomTextField(
                title: "Customer code",
                hintText: "XXXXXXXXX",
              ),
              CustomTextField(
                title: "Select Month",
                hintText: "Select From List",
              ),
            ],
          )),
    );
  }
}
