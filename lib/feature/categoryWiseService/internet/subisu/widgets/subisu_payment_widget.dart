import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/scaffold_topbar.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';

class SubisuPaymentWidget extends StatefulWidget {
  SubisuPaymentWidget({Key? key, required this.service}) : super(key: key);

  final Service service;

  @override
  State<SubisuPaymentWidget> createState() => _SubisuPaymentWidgetState();
}

class _SubisuPaymentWidgetState extends State<SubisuPaymentWidget> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
      body: Form(
        key: _formKey,
        child: CommonContainer(
          showDetail: true,
          title: 'Internet Payment',
          detail: 'Pay your internet bill of you ISP from here',
          showAccountSelection: true,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: _height * 0.1,
                    width: _width * 0.2,
                    margin: const EdgeInsets.only(right: 18),
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
                        //color: _theme.primaryColor.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(18)),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.network(
                            "${RepositoryProvider.of<CoOperative>(context).baseUrl}/ismart/serviceIcon/${widget.service.icon}")),
                  ),
                  Expanded(
                    child: Text(widget.service.service,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.w700,
                            )),
                  ),
                ],
              ),
              SizedBox(height: _height * 0.03),
              Text("Provide Username and Details to pay.",
                  style: Theme.of(context).textTheme.labelMedium),
              SizedBox(height: _height * 0.03),
              CustomTextField(
                title: 'Username',
                controller: _usernameController,
                hintText: 'Enter Username',
                validator: (value) =>
                    FormValidator.validateFieldNotEmpty(value, 'Username'),
              ),
              CustomTextField(
                title: 'Mobile Number',
                validator: (value) => FormValidator.validatePhoneNumber(value),
                controller: _mobileNumberController,
                hintText: 'Enter Mobile Number',
                textInputType: TextInputType.number,
              ),
              CustomTextField(
                title: 'Amount',
                validator: (value) =>
                    FormValidator.validateFieldNotEmpty(value, 'Amount'),
                controller: _amountController,
                hintText: 'Enter Amount (400 - 10000)',
                textInputType: TextInputType.number,
              ),
            ],
          ),
          topbarName: 'Payment',
          buttonName: 'Proceed',
          onButtonPressed: () {
            _formKey.currentState!.save();
            if (_formKey.currentState!.validate()) {
              print('valuated');
            }
          },
        ),
      ),
    );
  }
}
