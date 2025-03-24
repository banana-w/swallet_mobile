import 'package:flutter/material.dart';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/screens/student_features/voucher/voucher_list_screen.dart';

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
    _suggestions = ['HighLands Coffee', 'Passio', 'Koi Thé'];
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
            viewBackgroundColor: kPrimaryColor,
            isFullScreen: false,
            viewConstraints: const BoxConstraints(maxHeight: 400.0),
            viewOnSubmitted: (value) async {
              final studentId = await AuthenLocalDataSource.getStudentId();
              FocusScope.of(context).unfocus();
              Navigator.pushNamed(
                context,
                VoucherListScreen.routeName,
                arguments: <dynamic>[value, studentId],
              );
            },
            builder: (BuildContext context, SearchController controller) {
              return Container(
                height: 45,
                child: SearchBar(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  controller: controller,
                  padding: const MaterialStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 16.0),
                  ),
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
                  hintStyle: MaterialStateProperty.all(
                    const TextStyle(color: Colors.grey),
                  ),
                  overlayColor: MaterialStateProperty.all(kPrimaryColor),
                  shadowColor: MaterialStateProperty.all(Colors.transparent),
                  shape: MaterialStateProperty.all(
                    const ContinuousRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  side: MaterialStateProperty.all(
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
                        setState(() async {
                          final studentId =
                              await AuthenLocalDataSource.getStudentId();
                          controller.closeView(item);
                          Navigator.pushNamed(
                            context,
                            VoucherListScreen.routeName,
                            arguments: <dynamic>[item, studentId],
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
  //         const FilterVoucherScreen(),
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
      '/product-list-search-screen',
      arguments: value,
    );
  }
}
