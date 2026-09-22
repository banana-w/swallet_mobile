import 'package:flutter/material.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/screens/store_features/campaign_voucher_list/campaign_voucher_list_screen.dart';

/// Gợi ý tìm kiếm cố định; khai báo ở cấp file nên không dựng lại mỗi lần
/// widget rebuild.
const List<String> _suggestions = ['Khuyến mãi', 'Thứ 2', 'Mua 1 tặng 1'];

class SearchBarCustom extends StatelessWidget {
  const SearchBarCustom({super.key});

  void _search(BuildContext context, String keyword) {
    FocusScope.of(context).unfocus();
    Navigator.pushNamed(
      context,
      CampaignVoucherListScreen.routeName,
      arguments: keyword,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SearchAnchor(
        isFullScreen: false,
        viewBackgroundColor: kPrimaryColor,
        viewOnSubmitted: (value) => _search(context, value),
        viewConstraints: const BoxConstraints(maxHeight: 400.0),
        builder: (context, controller) {
          return SizedBox(
            height: 45,
            child: SearchBar(
              backgroundColor: WidgetStateProperty.all(Colors.white),
              controller: controller,
              onTap: controller.openView,
              onChanged: (_) => controller.openView(),
              onSubmitted: (_) => FocusScope.of(context).unfocus(),
              leading: const Icon(Icons.search_rounded, color: Colors.black54),
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
        suggestionsBuilder: (context, controller) {
          final keyword = controller.value.text.toLowerCase();
          return _suggestions
              .where((item) => item.toLowerCase().contains(keyword))
              .map(
                (item) => ListTile(
                  title: Text(item),
                  onTap: () {
                    controller.closeView(item);
                    _search(context, item);
                  },
                ),
              )
              .toList();
        },
      ),
    );
  }
}
