import 'package:flutter/material.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/page_wrapper.dart';

class PassengerDetailWidget extends StatelessWidget {
  PassengerDetailWidget(
      {Key? key, required this.adultCount, required this.childrenCount})
      : super(key: key);

  final adultCount;
  final childrenCount;
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
        body: CommonContainer(
      showDetail: true,
      topbarName: 'Payment',
      title: 'Passenger Details',
      detail: 'Provide the details of the person traveling on the plane',
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                  color: CustomTheme.backgroundColor,
                  borderRadius: BorderRadius.circular(18)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            color: CustomTheme.gray,
                            borderRadius: BorderRadius.circular(16)),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Yeti Air',
                              style: _textTheme.displaySmall!
                                  .copyWith(fontSize: 16),
                            ),
                            Text(
                              '8:00 AM - 9:00 PM',
                              style: _textTheme.displaySmall!
                                  .copyWith(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Column(
                        children: [
                          Text(
                            'Ticket Price',
                            style: _textTheme.headlineSmall,
                          ),
                          Text(
                            '5000',
                            style:
                                _textTheme.displaySmall!.copyWith(fontSize: 16),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Departure : 30  mar2023',
                        style: _textTheme.titleSmall!.copyWith(
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Route : KTM to PKR',
                        style: _textTheme.titleSmall!.copyWith(
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            Text(
              'Contact Person Details',
              style: _textTheme.displaySmall,
            ),
            Text(
              'Ticket will be sent to below input number',
              style: _textTheme.bodyLarge,
            ),
            SizedBox(
              height: 15,
            ),
            CustomTextField(
              title: 'Full Name',
              hintText: 'Full Name',
            ),
            CustomTextField(
              title: 'Email',
              hintText: 'Email',
            ),
            CustomTextField(
              title: 'Mobile Number',
              hintText: 'Mobile Number',
            ),
            Text(
              'Passenger Detail',
              style: _textTheme.displaySmall,
            ),
            Text(
              'Please enter following details',
              style: _textTheme.bodyLarge,
            ),
            SizedBox(
              height: 20,
            ),
            if (adultCount > 0)
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: adultCount,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Please enter adult ${index + 1} details',
                        style: _textTheme.headlineSmall,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: _nameController,
                        validator: (value) =>
                            FormValidator.validateFieldNotEmpty(value, 'Name'),
                        title: 'Full Name',
                      ),
                      CustomTextField(
                        title: 'Nationality',
                      ),
                    ],
                  );
                },
              ),
            if (childrenCount > 0)
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: childrenCount,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Please enter children ${index + 1} details',
                        style: _textTheme.headlineSmall,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        title: 'Full Name',
                      ),
                      CustomTextField(
                        title: 'Nationality',
                      ),
                    ],
                  );
                },
              ),
          ],
        ),
      ),
      buttonName: 'Confirm',
      onButtonPressed: () {
        _formKey.currentState!.save();
        if (_formKey.currentState!.validate()) {
          print('validated');
        }
      },
    ));
  }
}
