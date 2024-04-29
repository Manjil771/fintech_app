import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_loading_widget.dart';
import 'package:ismart/common/widget/no_data_screen.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/notification/resources/notification_model.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';

class NotificationWidget extends StatefulWidget {
  const NotificationWidget({Key? key}) : super(key: key);

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  @override
  void initState() {
    context.read<UtilityPaymentCubit>().fetchNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
      showBackButton: true,
      // backgroundColor: CustomTheme.white,
      body: BlocConsumer<UtilityPaymentCubit, CommonState>(
        listener: (context, state) {},
        builder: (context, state) {
          return BlocBuilder<UtilityPaymentCubit, CommonState>(
            builder: (context, state) {
              if (state is CommonStateSuccess<NotificationModel>) {
                final _data = state.data;
                if (state.data.detail.isNotEmpty) {
                  return ListView.builder(
                      itemCount: state.data.detail.length,
                      itemBuilder: (context, index) {
                        final data = state.data.detail[index];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: CustomTheme.white,
                          ),
                          child: Column(
                            children: [
                              Row(children: [
                                SvgPicture.asset(Assets.notificationIcon,
                                    height: 20.hp),
                                SizedBox(width: 15.wp),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data.title,
                                        style: _textTheme.displaySmall!
                                            .copyWith(fontSize: 14),
                                      ),
                                      Text(
                                        data.date,
                                        style: _textTheme.labelSmall,
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                              SizedBox(height: 10.hp),
                              Text(
                                data.body,
                                style: _textTheme.labelLarge,
                              ),
                            ],
                          ),
                        );
                      });
                } else {
                  return const NoDataScreen(
                    title: "No Notification Found",
                    details: "Notification List is empty.",
                  );
                }
              } else if (state is CommonLoading) {
                return const CommonLoadingWidget();
              } else {
                return const NoDataScreen(
                  title: "No Notification Found",
                  details: "Notification List is empty.",
                );
              }
            },
          );
        },
      ),
    );
  }
}
