import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swallet_mobile/domain/interface_repositories/student_features/brand_repository.dart';
import 'package:swallet_mobile/presentation/blocs/brand/brand_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/internet/internet_bloc.dart';
import 'package:swallet_mobile/presentation/screens/store_features/brand/components/brand_campaigns.dart';
import '../../../../config/constants.dart';
import '../../../../widgets/shimmer_widget.dart';
import 'brand_detail_showdal.dart';
import 'detail_shadow_bottom.dart';
import 'infor_card_brand_detail.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    double baseHeight = 812;
    double hem = MediaQuery.of(context).size.height / baseHeight;
    return BlocListener<InternetBloc, InternetState>(
      listener: (context, state) {
        if (state is Connected) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                elevation: 0,
                duration: const Duration(milliseconds: 2000),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                content: AwesomeSnackbarContent(
                  title: 'Đã kết nối internet',
                  message: 'Đã kết nối internet!',
                  contentType: ContentType.success,
                ),
              ),
            );
        } else if (state is NotConnected) {
          showCupertinoDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                title: const Text('Không kết nối Internet'),
                content: Text('Vui lòng kết nối Internet'),
                actions: [
                  TextButton(
                    onPressed: () {
                      final stateInternet = context.read<InternetBloc>().state;
                      if (stateInternet is Connected) {
                        Navigator.pop(context);
                      } else {}
                    },
                    child: const Text('Đồng ý'),
                  ),
                ],
              );
            },
          );
        }
      },
      child: BlocBuilder<BrandBloc, BrandState>(
        builder: (context, state) {
          if (state is BrandLoading) {
            return buildBrandDetailShimmer(fem, hem);
          } else if (state is BrandByIdLoaded) {
            return CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([
                    Stack(
                      children: [
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 180 * hem,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    'assets/images/background_splash.png',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: 120 * hem),
                          ],
                        ),

                        // Positioned(
                        //   top: 80 * hem,
                        //   left: 0 * fem,
                        //   right: 0 * fem,
                        //   child: BlocProvider(
                        //     create: (context) => WishlistBloc(
                        //         studentRepository:
                        //             context.read<StudentRepository>(),
                        //         wishListRepository:
                        //             context.read<WishListRepository>()),
                        //     child: InformationCardBrandDetail(
                        //       hem: hem,
                        //       fem: fem,
                        //       ffem: ffem,
                        //       brandModel: state.brand,
                        //     ),
                        //   ),
                        // ),
                        Positioned(
                          top: 80 * hem,
                          left: 0 * fem,
                          right: 0 * fem,
                          child: InformationCardBrandDetail(
                            hem: hem,
                            fem: fem,
                            ffem: ffem,
                            brandModel: state.brand,
                          ),
                        ),
                      ],
                    ),
                    BrandDetailShadow(
                      fem: fem,
                      hem: hem,
                      ffem: ffem,
                      onTap: () {
                        _detailModelBottomSheet(context, state.brand);
                      },
                      brandModel: state.brand,
                    ),
                    SizedBox(height: 15 * hem),
                    BlocProvider(
                      create:
                          (context) => BrandBloc(
                            brandRepository: context.read<BrandRepository>(),
                          )..add(LoadBrandCampaignsById(id: state.brand.id)),
                      child: BrandCampaigns(
                        fem: fem,
                        ffem: ffem,
                        hem: hem,
                        id: state.brand.id,
                      ),
                    ),
                  ]),
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}

Widget buildBrandDetailShimmer(double fem, double hem) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      SizedBox(height: 120 * fem),
      Container(
        margin: EdgeInsets.only(left: 15 * fem, right: 15 * fem),
        color: Colors.white,
        child: ShimmerWidget.rectangular(height: 150 * hem),
      ),
      Container(
        margin: EdgeInsets.only(left: 15 * fem, right: 15 * fem, top: 20 * hem),
        child: ShimmerWidget.rectangular(height: 100 * hem),
      ),
      Container(
        margin: EdgeInsets.only(left: 15 * fem, right: 15 * fem, top: 20 * hem),
        child: ShimmerWidget.rectangular(height: 20 * hem, width: 150 * fem),
      ),
      Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 15 * fem, top: 20 * hem),
            child: ShimmerWidget.rectangular(
              height: 130 * hem,
              width: 320 * fem,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 15 * fem, top: 20 * hem),
            child: ShimmerWidget.rectangular(
              height: 130 * hem,
              width: 320 * fem,
            ),
          ),
        ],
      ),
    ],
  );
}

void _detailModelBottomSheet(context, brandModel) {
  double baseWidth = 375;
  double fem = MediaQuery.of(context).size.width / baseWidth;
  double ffem = fem * 0.97;
  double baseHeight = 812;
  double hem = MediaQuery.of(context).size.height / baseHeight;

  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        height: 500 * hem,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15 * fem),
          color: klighGreyColor,
        ),
        child: DetailShowdalBottom(
          hem: hem,
          fem: fem,
          ffem: ffem,
          brandModel: brandModel,
        ),
      );
    },
    isScrollControlled: true,
  );
}
