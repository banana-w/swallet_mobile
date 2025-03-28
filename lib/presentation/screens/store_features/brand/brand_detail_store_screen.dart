import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swallet_mobile/domain/interface_repositories/student_features/brand_repository.dart';
import 'package:swallet_mobile/presentation/blocs/brand/brand_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';

import '../../../blocs/blocs.dart';
import 'components/body.dart';

class BrandDetailStoreScreen extends StatelessWidget {
  static const String routeName = '/brand-detail-store';

  static Route route({required String id}) {
    return MaterialPageRoute(
      builder: (_) => BrandDetailStoreScreen(id: id),
      settings: const RouteSettings(arguments: routeName),
    );
  }

  final String id;
  const BrandDetailStoreScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;

    double baseHeight = 812;
    double hem = MediaQuery.of(context).size.height / baseHeight;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          elevation: 0,
          toolbarHeight: 50 * hem,
          leading: Container(
            margin: EdgeInsets.only(left: 20 * fem),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white,
                    size: 35 * fem,
                  ),
                ),
              ],
            ),
          ),
          leadingWidth: double.infinity,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: klighGreyColor,
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: BlocProvider(
          create:
              (context) =>
                  BrandBloc(brandRepository: context.read<BrandRepository>())
                    ..add(LoadBrandById(id: id)),
          child: Body(),
        ),
      ),
    );
  }
}
