// import 'package:flutter/material.dart';
// import 'package:paywell_wallet/app/theme.dart';
// import 'package:paywell_wallet/common/constants/fonts.dart';
// import 'package:paywell_wallet/common/enum/textfield_type.dart';
// import 'package:paywell_wallet/common/utils/size_utils.dart';
// import 'package:paywell_wallet/common/widgets/buttons/custom_icon_button.dart';

// class FlightTextField extends FormField<String> {
//   FlightTextField({
//     Key? key,
//     this.controller,
//     ValueChanged<String>? onChanged,
//     ValueChanged<String>? onSubmited,
//     String hintText = "",
//     bool readOnly = false,
//     TextFieldType type = TextFieldType.outline,
//     String title = "",
//     bool required = false,
//     EdgeInsets? margin,
//     TextInputType textInputType = TextInputType.text,
//     int? maxLength,
//     double bottomMargin = 10,
//     AutovalidateMode? autovalidateMode,
//     bool? enabled,
//     FormFieldSetter<String>? onSaved,
//     FormFieldValidator<String>? validator,
//     String? restorationId,
//     VoidCallback? onTap,
//     required IconData suffixIcon,
//     required IconData prefixIcon,
//   }) : super(
//           key: key,
//           autovalidateMode: autovalidateMode,
//           enabled: enabled ?? true,
//           initialValue: controller?.text ?? "",
//           onSaved: onSaved,
//           restorationId: restorationId,
//           validator: validator,
//           builder: (FormFieldState<String> field) {
//             final _FlightTextFieldState state = field as _FlightTextFieldState;
//             final InputDecoration effectiveDecoration = InputDecoration(
//               counterText: "",
//               hintText: hintText,
//               hintStyle: TextStyle(
//                 fontFamily: Fonts.inter,
//                 fontWeight: FontWeight.w400,
//                 fontSize: 14,
//                 color: CustomTheme.midGrayColor,
//               ),
//               border: InputBorder.none,
//               errorBorder: InputBorder.none,
//               enabledBorder: InputBorder.none,
//               focusedBorder: InputBorder.none,
//               disabledBorder: InputBorder.none,
//               focusedErrorBorder: InputBorder.none,
//             ).applyDefaults(Theme.of(field.context).inputDecorationTheme);
//             void onChangedHandler(String value) {
//               field.didChange(value);
//               if (onChanged != null) {
//                 onChanged(value);
//               }
//             }

//             return Container(
//               margin: margin ??
//                   EdgeInsets.only(
//                     bottom: bottomMargin,
//                   ),
//               child: UnmanagedRestorationScope(
//                 bucket: field.bucket,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         if (title.isNotEmpty)
//                           Container(
//                             padding: EdgeInsets.only(bottom: 10.hp),
//                             child: RichText(
//                               text: TextSpan(
//                                 text: title,
//                                 style: TextStyle(
//                                   fontFamily: Fonts.inter,
//                                   fontWeight: FontWeight.w700,
//                                   fontSize: 14,
//                                   color: CustomTheme.lightTextColor,
//                                 ),
//                                 children: [
//                                   if (required)
//                                     TextSpan(
//                                       text: "*",
//                                       style: TextStyle(
//                                         fontFamily: Fonts.inter,
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.bold,
//                                         color: CustomTheme.primaryColor,
//                                       ),
//                                     )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         GestureDetector(
//                           onTap: onTap,
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     color: type == TextFieldType.filled
//                                         ? CustomTheme.lighterGrey
//                                         : Colors.transparent,
//                                     borderRadius: BorderRadius.circular(100),
//                                     border: type == TextFieldType.outline
//                                         ? Border.all(
//                                             width: 1,
//                                             color: CustomTheme.gray,
//                                           )
//                                         : null,
//                                   ),
//                                   padding: EdgeInsets.only(left: 8, right: 8),
//                                   child: Row(
//                                     children: [
//                                       CustomIconButton(
//                                         backgroundColor: Colors.transparent,
//                                         icon: prefixIcon,
//                                         shadow: false,
//                                         iconSize: 28,
//                                         iconColor: CustomTheme.midGrayColor,
//                                         onPressed: null,
//                                       ),
//                                       Container(
//                                         height: 20,
//                                         color: CustomTheme.midGrayColor,
//                                         width: 1.hp,
//                                       ),
//                                       SizedBox(width: 12.wp),
//                                       Expanded(
//                                         child: TextField(
//                                           restorationId: restorationId,
//                                           controller:
//                                               state._effectiveController,
//                                           decoration: effectiveDecoration,
//                                           keyboardType: textInputType,
//                                           maxLength: maxLength,
//                                           onChanged: onChangedHandler,
//                                           enableInteractiveSelection: !readOnly,
//                                           readOnly: readOnly,
//                                           cursorColor: CustomTheme.gray,
//                                           onEditingComplete: () {
//                                             FocusScope.of(field.context)
//                                                 .unfocus();
//                                             if (onSubmited != null) {
//                                               onSubmited(
//                                                   controller?.text ?? "");
//                                             }
//                                           },
//                                           onTap: onTap,
//                                           style: TextStyle(
//                                             fontFamily: Fonts.inter,
//                                             fontWeight: FontWeight.w400,
//                                             fontSize: 14,
//                                             color: CustomTheme.lightTextColor,
//                                           ),
//                                         ),
//                                       ),
//                                       CustomIconButton(
//                                         backgroundColor: Colors.transparent,
//                                         icon: suffixIcon,
//                                         shadow: false,
//                                         iconSize: 28,
//                                         iconColor: CustomTheme.midGrayColor,
//                                         onPressed: null,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     if (state.hasError)
//                       Container(
//                         padding: EdgeInsets.only(top: 4.hp),
//                         child: Text(
//                           state.errorText!,
//                           style: TextStyle(
//                             fontFamily: Fonts.inter,
//                             fontWeight: FontWeight.w400,
//                             fontSize: 10,
//                             color: Colors.red,
//                           ),
//                         ),
//                       )
//                   ],
//                 ),
//               ),
//             );
//           },
//         );

//   /// Controls the text being edited.
//   ///
//   /// If null, this widget will create its own [TextEditingController] and
//   /// initialize its [TextEditingController.text] with [initialValue].
//   final TextEditingController? controller;

//   @override
//   FormFieldState<String> createState() {
//     return _FlightTextFieldState();
//   }
// }

// class _FlightTextFieldState extends FormFieldState<String> {
//   RestorableTextEditingController? _controller;

//   TextEditingController get _effectiveController =>
//       widget.controller ?? _controller!.value;

//   @override
//   FlightTextField get widget => super.widget as FlightTextField;

//   @override
//   void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
//     super.restoreState(oldBucket, initialRestore);
//     if (_controller != null) {
//       _registerController();
//     }
//     // Make sure to update the internal [FormFieldState] value to sync up with
//     // text editing controller value.
//     setValue(_effectiveController.text);
//   }

//   void _registerController() {
//     assert(_controller != null);
//     registerForRestoration(_controller!, 'controller');
//   }

//   void _createLocalController([TextEditingValue? value]) {
//     assert(_controller == null);
//     _controller = value == null
//         ? RestorableTextEditingController()
//         : RestorableTextEditingController.fromValue(value);
//     if (!restorePending) {
//       _registerController();
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     if (widget.controller == null) {
//       _createLocalController(widget.initialValue != null
//           ? TextEditingValue(text: widget.initialValue!)
//           : null);
//     } else {
//       widget.controller!.addListener(_handleControllerChanged);
//     }
//   }

//   @override
//   void didUpdateWidget(FlightTextField oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.controller != oldWidget.controller) {
//       oldWidget.controller?.removeListener(_handleControllerChanged);
//       widget.controller?.addListener(_handleControllerChanged);

//       if (oldWidget.controller != null && widget.controller == null) {
//         _createLocalController(oldWidget.controller!.value);
//       }

//       if (widget.controller != null) {
//         setValue(widget.controller!.text);
//         if (oldWidget.controller == null) {
//           unregisterFromRestoration(_controller!);
//           _controller!.dispose();
//           _controller = null;
//         }
//       }
//     }
//   }

//   @override
//   void dispose() {
//     widget.controller?.removeListener(_handleControllerChanged);
//     _controller?.dispose();
//     super.dispose();
//   }

//   @override
//   void didChange(String? value) {
//     super.didChange(value);

//     if (_effectiveController.text != value)
//       _effectiveController.text = value ?? '';
//   }

//   @override
//   void reset() {
//     // setState will be called in the superclass, so even though state is being
//     // manipulated, no setState call is needed here.
//     _effectiveController.text = widget.initialValue ?? '';
//     super.reset();
//   }

//   void _handleControllerChanged() {
//     // Suppress changes that originated from within this class.
//     //
//     // In the case where a controller has been passed in to this widget, we
//     // register this change listener. In these cases, we'll also receive change
//     // notifications for changes originating from within this class -- for
//     // example, the reset() method. In such cases, the FormField value will
//     // already have been set.
//     if (_effectiveController.text != value)
//       didChange(_effectiveController.text);
//   }
// }
