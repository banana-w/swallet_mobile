import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/data/models/lecture_features/lecture_model.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'text_form_field_default.dart';

class FormUpdate extends StatelessWidget {
  const FormUpdate({
    super.key,
    required this.ffem,
    required this.fem,
    required this.hem,
    required this.lectureModel,
  });

  final double ffem;
  final double fem;
  final double hem;
  final LectureModel lectureModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(right: 15 * fem, left: 15 * fem),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15 * fem),
            boxShadow: [
              BoxShadow(
                color: const Color(0x0c000000),
                offset: Offset(0 * fem, 4 * fem),
                blurRadius: 2.5 * fem,
              ),
            ],
          ),
          child: Column(
            children: [
              SizedBox(height: 25 * hem),
              // Tên lecturer
              TextFormFieldDefault(
                hem: hem,
                fem: fem,
                ffem: ffem,
                labelText: 'TÊN GIẢNG VIÊN',
                hintText: 'Tên giảng viên...',
                initialValue: lectureModel.fullName,
                readOnly: true,
              ),
              SizedBox(height: 25 * hem),
              // Email
              TextFormFieldDefault(
                hem: hem,
                fem: fem,
                ffem: ffem,
                labelText: 'EMAIL',
                hintText: 'Email...',
                initialValue: lectureModel.email,
                readOnly: true,
              ),
              SizedBox(height: 25 * hem),
              // Số điện thoại
              TextFormFieldDefault(
                hem: hem,
                fem: fem,
                ffem: ffem,
                labelText: 'SỐ ĐIỆN THOẠI',
                hintText: 'Số điện thoại...',
                initialValue: lectureModel.phone,
                readOnly: true,
              ),
              SizedBox(height: 25 * hem),
              // Danh sách campus
              TextFormFieldDefault(
                hem: hem,
                fem: fem,
                ffem: ffem,
                labelText: 'CAMPUS',
                hintText: 'Danh sách campus...',
                initialValue: lectureModel.campusName.join(
                  ', ',
                ), // Hiển thị danh sách campus dưới dạng chuỗi
                readOnly: true,
              ),
              SizedBox(height: 25 * hem),
              // Số dư
              TextFormFieldDefault(
                hem: hem,
                fem: fem,
                ffem: ffem,
                labelText: 'SỐ DƯ',
                hintText: 'Số dư...',
                initialValue: lectureModel.balance.toString(),
                readOnly: true,
              ),
              SizedBox(height: 25 * hem),
              // Ngày tạo
              TextFormFieldDefault(
                hem: hem,
                fem: fem,
                ffem: ffem,
                labelText: 'NGÀY TẠO',
                hintText: 'Ngày tạo...',
                initialValue: lectureModel.dateCreated?.toString() ?? 'N/A',
                readOnly: true,
              ),
              SizedBox(height: 25 * hem),
              // Ngày cập nhật
              TextFormFieldDefault(
                hem: hem,
                fem: fem,
                ffem: ffem,
                labelText: 'NGÀY CẬP NHẬT',
                hintText: 'Ngày cập nhật...',
                initialValue: lectureModel.dateUpdated?.toString() ?? 'N/A',
                readOnly: true,
              ),
              SizedBox(height: 25 * hem),
              // Trạng thái
              TextFormFieldDefault(
                hem: hem,
                fem: fem,
                ffem: ffem,
                labelText: 'TRẠNG THÁI',
                hintText: 'Trạng thái...',
                initialValue:
                    lectureModel.status != null
                        ? (lectureModel.status!
                            ? 'Hoạt động'
                            : 'Không hoạt động')
                        : 'N/A',
                readOnly: true,
              ),
              SizedBox(height: 25 * hem),
            ],
          ),
        ),
        SizedBox(height: 25 * hem),
      ],
    );
  }
}
