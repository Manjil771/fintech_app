import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/chatBot/SmartBot_topUp_service.dart';
import 'package:ismart/feature/chatBot/chat_prompts.dart';
import 'package:ismart/feature/chatBot/typing_animation.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/cubit/category_cubit.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/resources/category_repository.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';

class SmartChatPage extends StatefulWidget {
  final String? receiverEmail;
  final int id;

  const SmartChatPage({
    Key? key,
    this.receiverEmail = "iSmart",
    this.id = 1,
  }) : super(key: key);

  @override
  State<SmartChatPage> createState() => _SmartChatPageState();
}

class _SmartChatPageState extends State<SmartChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  late final CategoryService _categoryService;

  final List<Map<String, dynamic>> _chatHistory = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _categoryService = CategoryService();
    _focusNode.addListener(_onFocusChange);
    _initializeCategoryService();
    _addInitialPrompt();
  }

  Future<void> _initializeCategoryService() async {
    await _categoryService.initialize(context);
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus) {
      Future.delayed(const Duration(milliseconds: 300), _scrollToBottom);
    }
  }

  void _scrollToBottom({
    Duration duration = const Duration(milliseconds: 300),
  }) {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: duration,
        curve: Curves.easeOutQuart,
      );
    }
  }

  void _addInitialPrompt() {
    setState(() {
      _chatHistory.add({
        'type': 'assistant',
        'message': ChatPrompts.getCurrentQuestion('start'),
        'timestamp': DateTime.now(),
        'options': ['What is iSmart']
      });
    });
  }

  Widget _buildMessageItem(Map<String, dynamic> message, BuildContext context) {
    final bool isUser = message['type'] == 'user';

    return Column(
      crossAxisAlignment:
          isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: (message['message'] != '' && message['message'] != null)
              ? Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.8,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: isUser
                        ? CustomTheme.primaryColor
                        : const Color.fromRGBO(255, 255, 255, 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    message['message'],
                    style: TextStyle(
                      color: !isUser
                          ? CustomTheme.primaryColor
                          : const Color.fromRGBO(255, 255, 255, 1),
                      fontSize: 14,
                    ),
                  ),
                )
              : Container(),
        ),
        if (!isUser && message['options'] != null)
          Wrap(
            spacing: 2.0,
            runSpacing: 2.0,
            children: (message['options'] as List<String>).map((option) {
              return Padding(
                padding: const EdgeInsets.all(2.0),
                child: GestureDetector(
                  onTap: () => _handleMessage(context, option),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 12.0),
                    decoration: BoxDecoration(
                      color: CustomTheme.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      option,
                      style: TextStyle(
                          color: CustomTheme.primaryColor, fontSize: 11),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
      ],
    );
  }

  void _handleMessage(BuildContext context, String message) {
    if (message.isEmpty) {
      return;
    }

    setState(() {
      _isLoading = true;
      message = _capitalizeFirstWord(message);
      _chatHistory.add({
        'type': 'user',
        'message': message,
        'timestamp': DateTime.now(),
      });
      _messageController.clear();
    });

    _scrollToBottom();

    context.read<UtilityPaymentCubit>().makePayment(
          mPin: '',
          accountDetails: {},
          serviceIdentifier: '',
          body: {'message': message},
          apiEndpoint: '/api/ai/message/${widget.id}',
        );
  }

  String _capitalizeFirstWord(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1);
  }

  Widget _buildMessageList(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(8),
      itemCount: _chatHistory.length + (_isLoading ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == _chatHistory.length && _isLoading) {
          return _buildTypingIndicator();
        }
        return _buildMessageItem(_chatHistory[index], context);
      },
    );
  }

  Widget _buildTypingIndicator() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: CustomTheme.primaryColor.withOpacity(0.9),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const TypingIndicator(),
      ),
    );
  }

  Widget _buildUserInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: CustomTextField(
              controller: _messageController,
              //   focusNode: _focusNode,
              hintText: 'Type a message...',
              onSubmited: (value) => _handleMessage(context, value),
            ),
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.mic,
                      color: CustomTheme.primaryColor,
                      size: 30,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.send,
                      color: CustomTheme.primaryColor,
                      size: 30,
                    ),
                    onPressed: () =>
                        _handleMessage(context, _messageController.text),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void updateChatWithResponse(String message) {
    setState(() {
      _isLoading = false;
      _chatHistory.add({
        'type': 'assistant',
        'message': message,
        'timestamp': DateTime.now(),
      });
    });
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CategoryCubit(
              servicesRepository:
                  RepositoryProvider.of<CategoryRepository>(context),
            )..fetchCategory(),
          ),
          BlocProvider(
            create: (context) => UtilityPaymentCubit(
              utilityPaymentRepository:
                  RepositoryProvider.of<UtilityPaymentRepository>(context),
            ),
          ),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<CategoryCubit, CommonState>(
              listener: (context, state) {
                if (state is CommonDataFetchSuccess<CategoryList>) {
                  _categoryService.updateCategoryList(state.data);
                }
              },
            ),
            BlocListener<UtilityPaymentCubit, CommonState>(
              listener: (context, state) {
                if (state is CommonStateSuccess<UtilityResponseData>) {
                  final UtilityResponseData response = state.data;
                  if (response.detail["serviceIdentifier"] != null) {
                    print("there is payement request");
                    actionButton(response);
                  }
                  updateChatWithResponse(response.detail['message']);
                } else if (state is CommonError) {
                  setState(() {
                    _chatHistory.add({
                      'type': 'assistant',
                      'message': "Something went wrong",
                      'timestamp': DateTime.now(),
                      'options': ['Start again']
                    });
                  });
                }
              },
            ),
          ],
          child: PageWrapper(
            showBackButton: true,
            body: Builder(
              builder: (context) => Stack(
                children: [
                  Column(
                    children: [
                      Expanded(child: _buildMessageList(context)),
                      _buildUserInput(context),
                    ],
                  ),
                  Positioned(
                    bottom: 68,
                    child: SizedBox(
                      height: 80,
                      width: 80,
                      child: Image.asset("assets/smart_fuchee.png"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void actionButton(UtilityResponseData response) {
    if (response.detail["serviceIdentifier"] == 'topup') {
      _categoryService.topupWithAmount(
        context,
        response.findValue(primaryKey: 'paymentData', secondaryKey: 'amount'),
        response.findValue(
            primaryKey: 'paymentData', secondaryKey: 'mobileNumber'),
      );
    } else if (response.detail["serviceIdentifier"] == 'movies') {
      _categoryService.navigateToMovie(
        context,
      );
    }
  }
}
