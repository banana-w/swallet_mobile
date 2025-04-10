import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/data/models/student_features/brand_model.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/brand_repository.dart';
import 'package:swallet_mobile/presentation/blocs/brand/brand_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'others_infor_brand_detail.dart';

class InformationCardBrandDetail extends StatefulWidget {
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
  State<InformationCardBrandDetail> createState() =>
      _InformationCardBrandDetailState();
}

class _InformationCardBrandDetailState
    extends State<InformationCardBrandDetail> {
  bool isFollowed = false;
  @override
  void initState() {
    isFollowed = widget.brandModel.status;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200 * widget.hem,
      margin: EdgeInsets.only(right: 15 * widget.fem, left: 15 * widget.fem),
      padding: EdgeInsets.only(top: 5 * widget.hem, bottom: 5 * widget.hem),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15 * widget.fem),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x0c000000),
            offset: Offset(0 * widget.fem, 10 * widget.fem),
            blurRadius: 5 * widget.fem,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 10 * widget.hem),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 25 * widget.fem),

              //avatar
              ClipRRect(
                borderRadius: BorderRadius.circular(10 * widget.fem),
                child: SizedBox(
                  height: 80 * widget.hem,
                  width: 80 * widget.fem,
                  child: Image.network(
                    widget.brandModel.coverPhoto,
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        child: Icon(
                          Icons.error,
                          size: 50 * widget.fem,
                          color: kPrimaryColor,
                        ),
                      );
                    },
                  ),
                ),
              ),

              SizedBox(width: 20 * widget.fem),

              SizedBox(
                // color: Colors.red,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Name
                    SizedBox(
                      width: 150 * widget.fem,
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              widget.brandModel.brandName,
                              // softWrap: true,
                              maxLines: 2,
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                  fontSize: 22 * widget.ffem,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10 * widget.fem),
          SizedBox(
            width: 280 * widget.fem,
            child: Divider(
              thickness: 1 * widget.fem,
              color: const Color.fromARGB(255, 225, 223, 223),
            ),
          ),
          BlocProvider(
            create:
                (context) =>
                    BrandBloc(brandRepository: context.read<BrandRepository>())
                      ..add(LoadBrandById(id: widget.brandModel.id)),
            child: OthersInforBrandDetail(
              hem: widget.hem,
              fem: widget.fem,
              ffem: widget.ffem,
            ),
          ),
        ],
      ),
    );
  }
}
