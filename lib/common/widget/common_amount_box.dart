import 'package:flutter/material.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';

class CommonAmountBox extends StatefulWidget {
  final TextEditingController textController;
  final Function(String value) onChanged;

  final ServiceList service;
  const CommonAmountBox(
      {Key? key,
      required this.textController,
      required this.service,
      required this.onChanged})
      : super(key: key);

  @override
  State<CommonAmountBox> createState() => _CommonAmountBoxState();
}

class _CommonAmountBoxState extends State<CommonAmountBox> {
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final priceRange = widget.service.priceRange ?? "";
    final List priceRangeList = priceRange.split(",");

    return Column(
      children: [
        CustomTextField(
          title: "Amount",
          textInputType: TextInputType.number,
          controller: widget.textController,
          hintText: "XXXXX",
          validator: (value) => FormValidator.validateAmount(
              val: value.toString(),
              minAmount: widget.service.minValue,
              maxAmount: widget.service.maxValue),
        ),
        if (priceRangeList.isNotEmpty)
          Container(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      priceRangeList.length > 4 ? 4 : priceRangeList.length,
                  childAspectRatio: 1 / 0.5),
              shrinkWrap: true,
              itemCount: priceRangeList.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  print("print" + priceRangeList[index].toString());
                  print("print" + priceRange.toString());

                  setState(() {
                    widget.onChanged(priceRangeList[index]);
                  });
                },
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 18),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        priceRangeList[index].toString(),
                        style: _textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: _theme.primaryColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
      ],
    );
  }
}
