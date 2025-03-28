import 'package:flutter/material.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/screens/store_features/campaign_voucher_list/campaign_voucher_list_screen.dart';

// import 'package:unibean_app/presentation/screens/student_features/voucher/components/filter/filter_body.dart';

class SearchBarCustom extends StatefulWidget {
  const SearchBarCustom({super.key});

  @override
  State<SearchBarCustom> createState() => _SearchBarCustomState();
}

class _SearchBarCustomState extends State<SearchBarCustom> {
  late final List<String> _suggestions;

  @override
  void initState() {
    super.initState();
    _suggestions = ['Khuyến mãi', 'Thứ 2', 'Mua 1 tặng 1'];
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(width: 20.0),
        Expanded(
          flex: 6,
          child: SearchAnchor(
            isFullScreen: false,
            viewBackgroundColor: kPrimaryColor,
            viewOnSubmitted: (value) {
              FocusScope.of(context).unfocus();
              Navigator.pushNamed(
                context,
                CampaignVoucherListScreen.routeName,
                arguments: value,
              );
            },
            viewConstraints: const BoxConstraints(maxHeight: 400.0),
            builder: (BuildContext context, SearchController controller) {
              return SizedBox(
                height: 45,
                child: SearchBar(
                  backgroundColor: WidgetStateProperty.all(Colors.white),
                  controller: controller,
                  // padding: const MaterialStatePropertyAll<EdgeInsets>(
                  //     EdgeInsets.symmetric(horizontal: 16.0)),
                  onTap: () {
                    controller.openView();
                  },
                  onChanged: (_) {
                    controller.openView();
                  },
                  leading: const Icon(
                    Icons.search_rounded,
                    color: Colors.black54,
                  ),
                  onSubmitted: (value) {
                    FocusScope.of(context).unfocus();
                  },
                  hintText: 'Tìm kiếm theo tên ưu đãi',
                  hintStyle: WidgetStateProperty.all(
                    const TextStyle(color: Colors.grey),
                  ),
                  overlayColor: WidgetStateProperty.all(kPrimaryColor),
                  shadowColor: WidgetStateProperty.all(Colors.transparent),
                  shape: WidgetStateProperty.all(
                    const ContinuousRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  side: WidgetStateProperty.all(
                    const BorderSide(color: Colors.grey, width: 1.0),
                  ),
                ),
              );
            },
            suggestionsBuilder: (
              BuildContext context,
              SearchController controller,
            ) {
              final keyword = controller.value.text;
              return _suggestions
                  .where(
                    (element) =>
                        element.toLowerCase().contains(keyword.toLowerCase()),
                  )
                  .map((item) {
                    return ListTile(
                      title: Text(item),
                      onTap: () {
                        setState(() {
                          controller.closeView(item);
                          Navigator.pushNamed(
                            context,
                            CampaignVoucherListScreen.routeName,
                            arguments: item,
                          );
                          FocusScope.of(context).unfocus();
                        });
                      },
                    );
                  })
                  .toList();
            },
          ),
        ),
        const SizedBox(width: 20.0),
      ],
    );
  }

  // Route _createRoute() {
  //   return PageRouteBuilder(
  //     pageBuilder: (context, animation, secondaryAnimation) =>
  //         const FilterBody(),
  //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //       const begin = Offset(1.0, 0.0);
  //       const end = Offset.zero;
  //       const curve = Curves.ease;

  //       var tween =
  //           Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

  //       return SlideTransition(
  //         position: animation.drive(tween),
  //         child: child,
  //       );
  //     },
  //   );
  // }

  void handleSearch(String value, BuildContext context) {
    FocusScope.of(context).unfocus();
    Navigator.pushNamed(
      context,
      CampaignVoucherListScreen.routeName,
      arguments: value,
    );
  }
}
