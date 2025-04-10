import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/brand_repository.dart';
import 'package:swallet_mobile/presentation/blocs/brand/brand_bloc.dart';
import 'package:swallet_mobile/presentation/screens/student_features/voucher/voucher_list_screen.dart';

import '../../../../config/constants.dart';

class BrandVouchers extends StatelessWidget {
  const BrandVouchers({
    super.key,
    required this.fem,
    required this.hem,
    required this.ffem,
    required this.id,
  });
  final double fem;
  final double hem;
  final double ffem;
  final String id;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              BrandBloc(brandRepository: context.read<BrandRepository>())
                ..add(LoadBrandVouchersById(id: id)),
      child: BlocBuilder<BrandBloc, BrandState>(
        builder: (context, state) {
          if (state is BrandVouchersByIdLoaded) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  VoucherListScreen.routeName,
                  arguments: state.vouchers,
                );
              },
              child: Container(
                margin: EdgeInsets.only(
                  right: 25 * fem,
                  left: 25 * fem,
                  bottom: 10 * hem,
                ),
                width: MediaQuery.of(context).size.width,
                height: 80 * hem,
                decoration: BoxDecoration(
                  // border: Border.all(
                  //   color: kPrimaryColor,
                  // ),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15 * fem),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Ưu đãi trong thương hiệu',
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                fontSize: 14 * ffem,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            'Nhấn vào để xem',
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                fontSize: 13 * ffem,
                                color: kLowTextColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 10 * fem),
                      child: Icon(Icons.arrow_forward_ios),
                    ),
                  ],
                ),
              ),
            );
          }
          return GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(
                right: 25 * fem,
                left: 25 * fem,
                bottom: 10 * hem,
              ),
              width: MediaQuery.of(context).size.width,
              height: 80 * hem,
              decoration: BoxDecoration(
                // border: Border.all(
                //   color: kPrimaryColor,
                // ),
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15 * fem),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Ưu đãi trong thương hiệu',
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              fontSize: 14 * ffem,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          'Nhấn vào để xem',
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              fontSize: 13 * ffem,
                              color: kLowTextColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10 * fem),
                    child: Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
