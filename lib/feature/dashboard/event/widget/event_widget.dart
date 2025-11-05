import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_loading_widget.dart';
import 'package:ismart/common/widget/no_data_screen.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class EventWidget extends StatefulWidget {
  const EventWidget({super.key});

  @override
  State<EventWidget> createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
  int? selectedIdex;
  bool viewMore = false;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    return PageWrapper(
      body: CommonContainer(
        verticalPadding: 0,
        horizontalPadding: 8,
        showRoundBotton: false,
        body: BlocBuilder<UtilityPaymentCubit, CommonState>(
          builder: (context, state) {
            if (state is CommonStateSuccess<UtilityResponseData>) {
              final UtilityResponseData _res = state.data;

              if (_res.details.isEmpty) {
                return NoDataScreen(
                  title: "",
                  details: _res.message,
                );
              } else {
                final List response = _res.findValue(primaryKey: "data");

                return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: response.length,
                    itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            final tappedImageUrl = response[index]["imageUrl"];
                            print("Tapped Image URL: $tappedImageUrl");
                            if (selectedIdex != index) {
                              selectedIdex = index;
                              viewMore = !viewMore;
                            } else {
                              selectedIdex = 200;
                            }
                            setState(() {});
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: CustomTheme.white,
                                border: Border.all(
                                    color: CustomTheme.backgroundColor)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  response[index]["title"],
                                  style: _textTheme.displaySmall!
                                      .copyWith(fontSize: 14),
                                ),
                                Text(
                                  response[index]["created"],
                                  style: _textTheme.labelSmall,
                                ),
                                SizedBox(height: 10.hp),
                                Text(
                                  response[index]["description"],
                                  style: _textTheme.labelLarge,
                                  maxLines: selectedIdex == index ? 100 : 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 10.hp),
                                response[index]["imageUrl"] != null &&
                                        response[index]["imageUrl"].isNotEmpty
                                    ? Container(
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.network(
                                            "https://ismart.devanasoft.com.np${response[index]["imageUrl"]}",
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return const Center(
                                                  child:
                                                      Icon(Icons.broken_image));
                                            },
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
                                              if (loadingProgress == null)
                                                return child;
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                          strokeWidth: 2));
                                            },
                                          ),
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    selectedIdex == index
                                        ? "Show Less"
                                        : "Show More",
                                    style: _textTheme.bodyMedium!.copyWith(
                                        color: _theme.primaryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ));
              }
            } else if (state is CommonLoading) {
              return const CommonLoadingWidget();
            } else if (state is CommonError) {
              return NoDataScreen(
                title: "",
                details: state.message,
              );
            } else {
              return Container();
            }
          },
        ),
        topbarName: "Notices",
      ),
    );
  }
}
