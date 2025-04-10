import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:swallet_mobile/data/models/student_features/brand_model.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/brand_repository.dart';
import 'package:swallet_mobile/presentation/blocs/brand/brand_bloc.dart';
import 'package:swallet_mobile/presentation/screens/student_features/brand_detail/brand_detail_screen.dart';

import '../../../../config/constants.dart';
import '../../../../widgets/shimmer_widget.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    double baseHeight = 812;
    double hem = MediaQuery.of(context).size.height / baseHeight;
    // double heightText = 1.3625 * ffem / fem;
    return BlocProvider(
      create:
          (context) =>
              BrandBloc(brandRepository: context.read<BrandRepository>())
                ..add(LoadBrands(page: 1, size: 10)),
      child: BlocBuilder<BrandBloc, BrandState>(
        builder: (context, state) {
          if (state is BrandLoading) {
            return buildBrandListShimmer(hem, fem, context);
          } else if (state is BrandsLoaded) {
            return GridView.builder(
              controller: context.read<BrandBloc>().scrollController,

              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
              ),
              shrinkWrap: true,
              itemCount:
                  state.hasReachedMax
                      ? state.brands.length
                      : state.brands.length + 1,
              itemBuilder: (context, index) {
                if (index >= state.brands.length) {
                  return Center(
                    child: CircularProgressIndicator(color: kPrimaryColor),
                  );
                }
                return BrandCard(
                  hem: hem,
                  fem: fem,
                  brandModel: state.brands[index],
                  ffem: ffem,
                );
              },
            );
          }
          return Center(
            child: Lottie.asset('assets/animations/loading-screen.json'),
          );
        },
      ),
    );
  }
}

class BrandCard extends StatelessWidget {
  const BrandCard({
    super.key,
    required this.hem,
    required this.fem,
    required this.ffem,
    required this.brandModel,
  });

  final double hem;
  final double fem;
  final double ffem;
  final BrandModel brandModel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 150 * fem,
        height: 150 * hem,
        // margin: EdgeInsets.only(bottom: 20*hem),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15 * fem),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0x0c000000),
              offset: Offset(0 * fem, 5 * fem),
              blurRadius: 5 * fem,
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              BrandDetailScreen.routeName,
              arguments: brandModel.id,
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: 5 * hem,
                  right: 5 * fem,
                  left: 5 * fem,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10 * fem),
                  child: SizedBox(
                    height: 100 * hem,
                    width: 120 * fem,
                    child: Image.network(
                      brandModel.coverPhoto,
                      // 'null',
                      fit: BoxFit.fill,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return ShimmerWidget.rectangular(height: 100 * hem);
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset('assets/images/image-404.jpg');
                      },
                    ),
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100 * hem,
                    padding: EdgeInsets.only(top: 5 * hem),
                    child: Text(
                      brandModel.brandName,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontSize: 13 * ffem,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildBrandListShimmer(double fem, double hem, context) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 20 * hem),
        SizedBox(
          height: MediaQuery.of(context).size.height - 20,
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 10 * fem, bottom: 10 * hem),
                child: Row(
                  children: [
                    ShimmerWidget.rectangular(
                      height: 150 * hem,
                      width: 170 * fem,
                    ),
                    SizedBox(width: 10 * fem),
                    ShimmerWidget.rectangular(
                      height: 150 * hem,
                      width: 170 * fem,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}
