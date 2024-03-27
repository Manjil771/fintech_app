import 'package:flutter/material.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/page_wrapper.dart';

class RefnoSearchRemitWidget extends StatelessWidget {
  RefnoSearchRemitWidget({super.key});
  final TextEditingController _refNoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
      body: CommonContainer(
          onButtonPressed: () {
            if (_formKey.currentState!.validate()) {}
          },
          title: "Receive Remit",
          buttonName: "Next",
          body: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      width: _width * 0.25,
                      margin: const EdgeInsets.only(right: 18),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.05),
                              offset: const Offset(0, 4),
                              blurRadius: 1,
                            ),
                          ],
                          //color: _theme.primaryColor.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(18)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.asset("assets/Asset 1.png"),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Money Gram",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.hp),
                CustomTextField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => FormValidator.validateFieldNotEmpty(
                      value, "Refrence Number"),
                  title: "Refrence No.",
                  controller: _refNoController,
                ),
              ],
            ),
          ),
          topbarName: "Remittance"),
    );
  }
}
