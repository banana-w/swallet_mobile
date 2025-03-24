import 'package:flutter/material.dart';
import 'package:swallet_mobile/presentation/screens/student_features/voucher/components/filter/filter_button.dart';
import 'package:swallet_mobile/presentation/screens/student_features/voucher/components/filter/filter_by_brands.dart';
import 'package:swallet_mobile/presentation/screens/student_features/voucher/components/filter/filter_by_cate.dart';
import 'package:swallet_mobile/presentation/screens/student_features/voucher/components/filter/filter_by_points.dart';
import 'package:swallet_mobile/presentation/screens/student_features/voucher/components/filter/filter_by_sorting.dart';

class FilterBody extends StatelessWidget {
  const FilterBody({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    double baseHeight = 812;
    double hem = MediaQuery.of(context).size.height / baseHeight;

    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate([
            FilterByCategories(hem: hem, fem: fem, ffem: ffem),

            //brands
            FilterByBrands(hem: hem, fem: fem, ffem: ffem),

            //value of points
            FilterByPoints(hem: hem, fem: fem, ffem: ffem),

            //arrange
            FilterBySorting(hem: hem, fem: fem, ffem: ffem),

            FilterButton(hem: hem, fem: fem, ffem: ffem),
          ]),
        ),
      ],
    );
  }
}
