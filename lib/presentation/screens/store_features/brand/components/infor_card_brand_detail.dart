import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/brand_repository.dart';
import 'package:swallet_mobile/data/models/student_features/brand_model.dart';
import 'package:swallet_mobile/presentation/blocs/brand/brand_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';

import 'others_infor_brand_detail.dart';

class InformationCardBrandDetail extends StatelessWidget {
  const InformationCardBrandDetail({
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
    return Container(
      height: 200 * hem,
      margin: EdgeInsets.symmetric(horizontal: 15 * fem),
      padding: EdgeInsets.symmetric(vertical: 5 * hem),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15 * fem),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0x0c000000),
            offset: Offset(0 * fem, 10 * fem),
            blurRadius: 5 * fem,
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(height: 10 * hem),
          Row(
            children: [
              SizedBox(width: 25 * fem),
              ClipRRect(
                borderRadius: BorderRadius.circular(10 * fem),
                child: SizedBox(
                  height: 80 * hem,
                  width: 80 * fem,
                  child: Image.network(
                    brandModel.coverPhoto,
                    fit: BoxFit.fill,
                    // Ảnh chỉ hiển thị ở 80*fem, không cần giữ bản gốc.
                    cacheWidth:
                        (80 * fem * MediaQuery.devicePixelRatioOf(context))
                            .round(),
                    errorBuilder:
                        (context, error, stackTrace) => Icon(
                          Icons.error,
                          size: 50 * fem,
                          color: kPrimaryColor,
                        ),
                  ),
                ),
              ),
              SizedBox(width: 20 * fem),
              SizedBox(
                width: 150 * fem,
                child: Text(
                  brandModel.brandName,
                  maxLines: 2,
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      fontSize: 22 * ffem,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10 * fem),
          SizedBox(
            width: 280 * fem,
            child: Divider(
              thickness: 1 * fem,
              color: const Color.fromARGB(255, 225, 223, 223),
            ),
          ),
          BlocProvider(
            create:
                (context) =>
                    BrandBloc(brandRepository: context.read<BrandRepository>())
                      ..add(LoadBrandById(id: brandModel.id)),
            child: OthersInforBrandDetail(hem: hem, fem: fem, ffem: ffem),
          ),
        ],
      ),
    );
  }
}
