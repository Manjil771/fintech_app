import 'package:flutter/material.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/util/hive_utils.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';

class CategoryDropdownWidget extends StatefulWidget {
  final Function(CategoryList?) onCategorySelected;
  final String? selectedCategoryName;
  final String hintText;

  const CategoryDropdownWidget({
    Key? key,
    required this.onCategorySelected,
    this.selectedCategoryName,
    this.hintText = "Select Category",
  }) : super(key: key);

  @override
  State<CategoryDropdownWidget> createState() => _CategoryDropdownWidgetState();
}

class _CategoryDropdownWidgetState extends State<CategoryDropdownWidget> {
  List<CategoryList> categories = [];
  CategoryList? selectedCategory;
  bool isLoading = true;
  bool isDropdownOpen = false;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    try {
      setState(() {
        isLoading = true;
      });

      final fetchedCategories = await ServiceHiveUtils.getUtilitiesServices(
        slug: "wallet_service",
      );

      setState(() {
        categories = fetchedCategories;
        isLoading = false;

        // Set initial selected category if provided
        if (widget.selectedCategoryName != null) {
          selectedCategory = categories.firstWhere(
            (cat) => cat.name == widget.selectedCategoryName,
          );
        }
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        categories = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select Category",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey.shade300,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: isLoading ? null : _showDropdown,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: isLoading
                          ? Row(
                              children: [
                                SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      CustomTheme.primaryColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  "Loading categories...",
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            )
                          : Text(
                              selectedCategory?.name ?? widget.hintText,
                              style: TextStyle(
                                color: selectedCategory != null
                                    ? Colors.black87
                                    : Colors.grey.shade600,
                                fontSize: 14,
                                fontWeight: selectedCategory != null
                                    ? FontWeight.w500
                                    : FontWeight.normal,
                              ),
                            ),
                    ),
                    AnimatedRotation(
                      turns: isDropdownOpen ? 0.5 : 0.0,
                      duration: const Duration(milliseconds: 200),
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: isLoading
                            ? Colors.grey.shade400
                            : CustomTheme.primaryColor,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showDropdown() {
    if (categories.isEmpty) return;

    setState(() {
      isDropdownOpen = true;
    });

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.3,
          maxChildSize: 0.9,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  // Handle bar
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  // Header
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Text(
                          "Select Category",
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close),
                          iconSize: 20,
                        ),
                      ],
                    ),
                  ),
                  // Categories list
                  Expanded(
                    child: ListView.separated(
                      controller: scrollController,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: categories.length,
                      separatorBuilder: (context, index) => const Divider(
                        height: 1,
                        color: Colors.grey,
                      ),
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        final isSelected = selectedCategory?.id == category.id;

                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                selectedCategory = category;
                              });
                              widget.onCategorySelected(category);
                              Navigator.pop(context);
                            },
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 12,
                              ),
                              child: Row(
                                children: [
                                  // Category image (if available)
                                  if (category.imageUrl.isNotEmpty)
                                    Container(
                                      width: 40,
                                      height: 40,
                                      margin: const EdgeInsets.only(right: 12),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.grey.shade100,
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          category.imageUrl,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Container(
                                              decoration: BoxDecoration(
                                                color: CustomTheme.primaryColor
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Icon(
                                                Icons.category,
                                                color: CustomTheme.primaryColor,
                                                size: 20,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    )
                                  else
                                    Container(
                                      width: 40,
                                      height: 40,
                                      margin: const EdgeInsets.only(right: 12),
                                      decoration: BoxDecoration(
                                        color: CustomTheme.primaryColor
                                            .withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Icon(
                                        Icons.category,
                                        color: CustomTheme.primaryColor,
                                        size: 20,
                                      ),
                                    ),

                                  // Category details
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          category.name,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: isSelected
                                                ? FontWeight.bold
                                                : FontWeight.w500,
                                            color: isSelected
                                                ? CustomTheme.primaryColor
                                                : Colors.black87,
                                          ),
                                        ),
                                        if (category.services.isNotEmpty)
                                          Text(
                                            "${category.services.length} services available",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  if (isSelected)
                                    Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: CustomTheme.primaryColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 14,
                                      ),
                                    )
                                  else
                                    Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey.shade400,
                                          width: 1,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    ).whenComplete(() {
      setState(() {
        isDropdownOpen = false;
      });
    });
  }
}


// import 'package:flutter/material.dart';
// import 'package:ismart/app/theme.dart';

// class CategoryDropdownWidget extends StatefulWidget {
//   final Function(String?) onCategorySelected;
//   final String? selectedCategoryName;
//   final String hintText;

//   const CategoryDropdownWidget({
//     Key? key,
//     required this.onCategorySelected,
//     this.selectedCategoryName,
//     this.hintText = "Select Category",
//   }) : super(key: key);

//   @override
//   State<CategoryDropdownWidget> createState() => _CategoryDropdownWidgetState();
// }

// class _CategoryDropdownWidgetState extends State<CategoryDropdownWidget> {
//   // Static list of categories
//   final List<String> categories = [
//     "SERVICE",
//     "WALLET", 
//     "CONNECT_IPS",
//     "Fund_Transfer",
//     "Remittance"
//   ];

//   String? selectedCategory;
//   bool isDropdownOpen = false;

//   @override
//   void initState() {
//     super.initState();
//     // Set initial selected category if provided
//     if (widget.selectedCategoryName != null && 
//         categories.contains(widget.selectedCategoryName)) {
//       selectedCategory = widget.selectedCategoryName;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "Select Category",
//           style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                 fontWeight: FontWeight.w600,
//                 fontSize: 14,
//               ),
//         ),
//         const SizedBox(height: 8),
//         Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(
//               color: Colors.grey.shade300,
//               width: 1,
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.05),
//                 blurRadius: 4,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           child: Material(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             child: InkWell(
//               borderRadius: BorderRadius.circular(12),
//               onTap: _showDropdown,
//               child: Container(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 16,
//                   vertical: 14,
//                 ),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: Text(
//                         selectedCategory ?? widget.hintText,
//                         style: TextStyle(
//                           color: selectedCategory != null
//                               ? Colors.black87
//                               : Colors.grey.shade600,
//                           fontSize: 14,
//                           fontWeight: selectedCategory != null
//                               ? FontWeight.w500
//                               : FontWeight.normal,
//                         ),
//                       ),
//                     ),
//                     AnimatedRotation(
//                       turns: isDropdownOpen ? 0.5 : 0.0,
//                       duration: const Duration(milliseconds: 200),
//                       child: Icon(
//                         Icons.keyboard_arrow_down,
//                         color: CustomTheme.primaryColor,
//                         size: 20,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   void _showDropdown() {
//     setState(() {
//       isDropdownOpen = true;
//     });

//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (BuildContext context) {
//         return DraggableScrollableSheet(
//           initialChildSize: 0.5,
//           minChildSize: 0.3,
//           maxChildSize: 0.7,
//           builder: (context, scrollController) {
//             return Container(
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(20),
//                   topRight: Radius.circular(20),
//                 ),
//               ),
//               child: Column(
//                 children: [
//                   // Handle bar
//                   Container(
//                     margin: const EdgeInsets.only(top: 12),
//                     width: 40,
//                     height: 4,
//                     decoration: BoxDecoration(
//                       color: Colors.grey.shade300,
//                       borderRadius: BorderRadius.circular(2),
//                     ),
//                   ),
//                   // Header
//                   Padding(
//                     padding: const EdgeInsets.all(20),
//                     child: Row(
//                       children: [
//                         Text(
//                           "Select Category",
//                           style:
//                               Theme.of(context).textTheme.titleLarge?.copyWith(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 18,
//                                   ),
//                         ),
//                         const Spacer(),
//                         IconButton(
//                           onPressed: () => Navigator.pop(context),
//                           icon: const Icon(Icons.close),
//                           iconSize: 20,
//                         ),
//                       ],
//                     ),
//                   ),
//                   // Categories list
//                   Expanded(
//                     child: ListView.separated(
//                       controller: scrollController,
//                       padding: const EdgeInsets.symmetric(horizontal: 20),
//                       itemCount: categories.length,
//                       separatorBuilder: (context, index) => const Divider(
//                         height: 1,
//                         color: Colors.grey,
//                       ),
//                       itemBuilder: (context, index) {
//                         final category = categories[index];
//                         final isSelected = selectedCategory == category;

//                         return Material(
//                           color: Colors.transparent,
//                           child: InkWell(
//                             onTap: () {
//                               setState(() {
//                                 selectedCategory = category;
//                               });
//                               widget.onCategorySelected(category);
//                               Navigator.pop(context);
//                             },
//                             borderRadius: BorderRadius.circular(8),
//                             child: Container(
//                               padding: const EdgeInsets.symmetric(
//                                 vertical: 16,
//                                 horizontal: 12,
//                               ),
//                               child: Row(
//                                 children: [
//                                   // Category icon
//                                   Container(
//                                     width: 40,
//                                     height: 40,
//                                     margin: const EdgeInsets.only(right: 12),
//                                     decoration: BoxDecoration(
//                                       color: CustomTheme.primaryColor
//                                           .withOpacity(0.1),
//                                       borderRadius: BorderRadius.circular(8),
//                                     ),
//                                     child: Icon(
//                                       Icons.category,
//                                       color: CustomTheme.primaryColor,
//                                       size: 20,
//                                     ),
//                                   ),

//                                   // Category name
//                                   Expanded(
//                                     child: Text(
//                                       category,
//                                       style: TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: isSelected
//                                             ? FontWeight.bold
//                                             : FontWeight.w500,
//                                         color: isSelected
//                                             ? CustomTheme.primaryColor
//                                             : Colors.black87,
//                                       ),
//                                     ),
//                                   ),

//                                   // Selection indicator
//                                   if (isSelected)
//                                     Container(
//                                       width: 20,
//                                       height: 20,
//                                       decoration: BoxDecoration(
//                                         color: CustomTheme.primaryColor,
//                                         shape: BoxShape.circle,
//                                       ),
//                                       child: const Icon(
//                                         Icons.check,
//                                         color: Colors.white,
//                                         size: 14,
//                                       ),
//                                     )
//                                   else
//                                     Container(
//                                       width: 20,
//                                       height: 20,
//                                       decoration: BoxDecoration(
//                                         border: Border.all(
//                                           color: Colors.grey.shade400,
//                                           width: 1,
//                                         ),
//                                         shape: BoxShape.circle,
//                                       ),
//                                     ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     ).whenComplete(() {
//       setState(() {
//         isDropdownOpen = false;
//       });
//     });
//   }
// }