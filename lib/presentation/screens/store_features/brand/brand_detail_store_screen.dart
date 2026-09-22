import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/brand_repository.dart';
import 'package:swallet_mobile/presentation/blocs/brand/brand_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';

import 'components/body.dart';

class BrandDetailStoreScreen extends StatelessWidget {
  static const String routeName = '/brand-detail-store';

  static Route route({required String id}) {
    return MaterialPageRoute(
      builder: (_) => BrandDetailStoreScreen(id: id),
      settings: const RouteSettings(name: routeName),
    );
  }

  const BrandDetailStoreScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final fem = size.width / 375;
    final hem = size.height / 812;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          elevation: 0,
          toolbarHeight: 50 * hem,
          leading: Container(
            margin: EdgeInsets.only(left: 20 * fem),
            // leadingWidth vô hạn nên cần Row để icon bám mép trái.
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
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
          child: const Body(),
        ),
      ),
    );
  }
}
