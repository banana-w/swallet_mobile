import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/data/models/store_features/store_model.dart';
import 'package:swallet_mobile/presentation/blocs/store/store_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/screens/store_features/profile_update_detail/components/text_form_field_address.dart';
import '../../../../blocs/blocs.dart';
import 'text_form_field_default.dart';

class FormUpdate extends StatefulWidget {
  const FormUpdate({
    super.key,
    required this.ffem,
    required this.fem,
    required this.hem,
    required this.storeModel,
  });

  final double ffem;
  final double fem;
  final double hem;
  final StoreModel storeModel;

  @override
  State<FormUpdate> createState() => _FormBody1State();
}

class _FormBody1State extends State<FormUpdate> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController storeNameController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController openHoursController = TextEditingController();
  TextEditingController closingHoursController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController descripController = TextEditingController();
  TimeOfDay? openingHours;
  TimeOfDay? closingHours;
  TimeOfDay? initialOpenHours;
  TimeOfDay? initialClosingHours;
  TimePickerEntryMode entryMode = TimePickerEntryMode.dial;
  Orientation? orientation;
  TextDirection textDirection = TextDirection.ltr;
  MaterialTapTargetSize tapTargetSize = MaterialTapTargetSize.padded;
  bool use24HourTime = true;

  bool changed = false;
  @override
  void initState() {
    storeNameController.text = widget.storeModel.storeName;
    areaController.text = widget.storeModel.areaId;
    openingHours = parseTimeString(widget.storeModel.openingHours);
    initialOpenHours = parseTimeString(widget.storeModel.openingHours);
    openHoursController.text = timeOfDayToString(openingHours!);

    closingHours = parseTimeString(widget.storeModel.closingHours);
    initialClosingHours = parseTimeString(widget.storeModel.closingHours);
    closingHoursController.text = timeOfDayToString(closingHours!);
    addressController.text = widget.storeModel.address;
    descripController.text = widget.storeModel.description;

    storeNameController.addListener(
      () => setState(() {
        changed = true;
      }),
    );

    areaController.addListener(
      () => setState(() {
        changed = true;
      }),
    );
    descripController.addListener(
      () => setState(() {
        changed = true;
      }),
    );
    addressController.addListener(
      () => setState(() {
        changed = true;
      }),
    );
    super.initState();
  }
  // var box = Hive.box('myBox');

  @override
  Widget build(BuildContext context) {
    return BlocListener<StoreBloc, StoreState>(
      listener: (context, state) {
        if (state is StoreUpdateSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                elevation: 0,
                duration: const Duration(milliseconds: 2000),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                content: AwesomeSnackbarContent(
                  title: 'Cập nhật thành công',
                  message: 'Cập nhật thông tin mới thành công!',
                  contentType: ContentType.success,
                ),
              ),
            );
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/landing-screen-store',
            (Route<dynamic> route) => false,
          );
        } else if (state is StoreUpdateFailed) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                elevation: 0,
                duration: const Duration(milliseconds: 2000),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                content: AwesomeSnackbarContent(
                  title: 'Sửa thất bại',
                  message: 'Cập nhật thông tin thất bại!',
                  contentType: ContentType.failure,
                ),
              ),
            );
          Navigator.pop(context);
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(
                right: 15 * widget.fem,
                left: 15 * widget.fem,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15 * widget.fem),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x0c000000),
                    offset: Offset(0 * widget.fem, 4 * widget.fem),
                    blurRadius: 2.5 * widget.fem,
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(height: 25 * widget.hem),
                  TextFormFieldDefault(
                    hem: widget.hem,
                    fem: widget.fem,
                    ffem: widget.ffem,
                    labelText: 'TÊN CỦA HÀNG',
                    hintText: 'Nhập tên cửa hàng...',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Tên cửa hàng không được bỏ trống';
                      } else if (!vietNameseTextOnlyPattern.hasMatch(value)) {
                        return 'Tên cửa hàng không hợp lệ';
                      }
                      return null;
                    },
                    textController: storeNameController,
                  ),
                  SizedBox(height: 25 * widget.hem),
                  Container(
                    width: 272 * widget.fem,
                    // color: Colors.red,
                    child: TextFormField(
                      // initialValue: ,
                      readOnly: true,
                      initialValue: widget.storeModel.areaName,
                      // controller: areaController,
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 15 * widget.ffem,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      decoration: InputDecoration(
                        labelText: 'KHU VỰC',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 15 * widget.ffem,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        hintStyle: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            color: kLowTextColor,
                            fontSize: 15 * widget.ffem,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 26 * widget.fem,
                          vertical: 10 * widget.hem,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28 * widget.fem),
                          borderSide: BorderSide(
                            width: 2,
                            color: const Color.fromARGB(255, 220, 220, 220),
                          ),
                          gapPadding: 10,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28 * widget.fem),
                          borderSide: BorderSide(
                            width: 2,
                            color: const Color.fromARGB(255, 220, 220, 220),
                          ),
                          gapPadding: 10,
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28 * widget.fem),
                          borderSide: BorderSide(
                            width: 2,
                            color: const Color.fromARGB(255, 220, 220, 220),
                          ),
                          gapPadding: 10,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20 * widget.hem),
                  InkWell(
                    onTap: () async {
                      final TimeOfDay? time = await showTimePicker(
                        context: context,
                        initialTime: openingHours ?? TimeOfDay.now(),
                        initialEntryMode: entryMode,
                        orientation: orientation,
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                            data: Theme.of(
                              context,
                            ).copyWith(materialTapTargetSize: tapTargetSize),
                            child: Directionality(
                              textDirection: textDirection,
                              child: MediaQuery(
                                data: MediaQuery.of(context).copyWith(
                                  alwaysUse24HourFormat: use24HourTime,
                                ),
                                child: child!,
                              ),
                            ),
                          );
                        },
                      );
                      setState(() {
                        openingHours = time;
                        changed = true;
                        openHoursController.text = timeOfDayToString(
                          openingHours!,
                        );
                      });
                    },
                    child: Stack(
                      children: [
                        Container(
                          width: 272 * widget.fem,
                          height: 60 * widget.hem,
                        ),
                        Positioned(
                          top: 10,
                          child: Container(
                            width: 272 * widget.fem,
                            height: 45 * widget.hem,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                28 * widget.fem,
                              ),
                              border: Border.all(
                                width: 2,
                                color: const Color.fromARGB(255, 220, 220, 220),
                              ),
                            ),
                            child: Container(
                              margin: EdgeInsets.only(
                                top: 10,
                                left: 25 * widget.fem,
                              ),
                              child: Text(
                                openingHours == null
                                    ? '${initialOpenHours!.format(context)}'
                                    : '${openingHours!.format(context)}',
                                style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15 * widget.ffem,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 20,
                          top: 2,
                          child: Container(
                            color: Colors.white,
                            padding: EdgeInsets.only(left: 8, right: 13),
                            child: Text(
                              'GIỜ MỞ CỬA',
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                  color: kPrimaryColor,
                                  fontSize: 12 * widget.ffem,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 13 * widget.hem),
                  InkWell(
                    onTap: () async {
                      final TimeOfDay? time = await showTimePicker(
                        context: context,
                        initialTime: closingHours ?? TimeOfDay.now(),
                        initialEntryMode: entryMode,
                        orientation: orientation,
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                            data: Theme.of(
                              context,
                            ).copyWith(materialTapTargetSize: tapTargetSize),
                            child: Directionality(
                              textDirection: textDirection,
                              child: MediaQuery(
                                data: MediaQuery.of(context).copyWith(
                                  alwaysUse24HourFormat: use24HourTime,
                                ),
                                child: child!,
                              ),
                            ),
                          );
                        },
                      );
                      setState(() {
                        closingHours = time;
                        changed = true;
                        closingHoursController.text = timeOfDayToString(
                          closingHours!,
                        );
                      });
                    },
                    child: Stack(
                      children: [
                        Container(
                          width: 272 * widget.fem,
                          height: 60 * widget.hem,
                        ),
                        Positioned(
                          top: 10,
                          child: Container(
                            width: 272 * widget.fem,
                            height: 45 * widget.hem,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                28 * widget.fem,
                              ),
                              border: Border.all(
                                width: 2,
                                color: const Color.fromARGB(255, 220, 220, 220),
                              ),
                            ),
                            child: Container(
                              margin: EdgeInsets.only(
                                top: 10,
                                left: 25 * widget.fem,
                              ),
                              child: Text(
                                closingHours == null
                                    ? '${initialClosingHours!.format(context)}'
                                    : '${closingHours!.format(context)}',
                                style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15 * widget.ffem,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 20,
                          top: 2,
                          child: Container(
                            color: Colors.white,
                            padding: EdgeInsets.only(left: 8, right: 13),
                            child: Text(
                              'GIỜ ĐÓNG CỬA',
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                  color: kPrimaryColor,
                                  fontSize: 12 * widget.ffem,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25 * widget.hem),
                  TextFormFieldAddress(
                    hem: widget.hem,
                    fem: widget.fem,
                    ffem: widget.ffem,
                    labelText: 'ĐỊA CHỈ',
                    hintText: 'Nhập địa chỉ...',
                    validator: (value) {
                      return null;
                    },
                    textController: addressController,
                  ),
                  SizedBox(height: 25 * widget.hem),
                  Container(
                    width: 272 * widget.fem,
                    height: 100 * widget.fem,
                    child: TextFormField(
                      maxLines: null,
                      expands: true,
                      validator: (value) {
                        return null;
                      },
                      controller: descripController,
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 15 * widget.fem,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      decoration: InputDecoration(
                        labelText: 'MÔ TẢ',
                        hintText: 'Nhập mô tả',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 15 * widget.ffem,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        hintStyle: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            color: kLowTextColor,
                            fontSize: 15 * widget.ffem,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 26 * widget.fem,
                          vertical: 10 * widget.hem,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28 * widget.fem),
                          borderSide: BorderSide(
                            width: 2,
                            color: const Color.fromARGB(255, 220, 220, 220),
                          ),
                          gapPadding: 10,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28 * widget.fem),
                          borderSide: BorderSide(
                            width: 2,
                            color: const Color.fromARGB(255, 220, 220, 220),
                          ),
                          gapPadding: 10,
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28 * widget.fem),
                          borderSide: BorderSide(
                            width: 2,
                            color: const Color.fromARGB(255, 220, 220, 220),
                          ),
                          gapPadding: 10,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25 * widget.hem),
                ],
              ),
            ),
            SizedBox(height: 25 * widget.hem),
            buttonWidget(changed, context),
          ],
        ),
      ),
    );
  }

  Widget buttonWidget(changed, BuildContext context) {
    if (changed) {
      return TextButton(
        onPressed: () async {
          if (openingHours!.hour > closingHours!.hour) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  elevation: 0,
                  duration: const Duration(milliseconds: 2000),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                    title: 'Sửa thất bại',
                    message: 'Giờ mở cửa không được sau giờ đóng cửa!',
                    contentType: ContentType.failure,
                  ),
                ),
              );
          } else if (descripController.length > 500) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  elevation: 0,
                  duration: const Duration(milliseconds: 2000),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                    title: 'Sửa thất bại',
                    message: 'Mô tả không được quá 500 từ!',
                    contentType: ContentType.failure,
                  ),
                ),
              );
          } else {
            final storeId = await AuthenLocalDataSource.getStoreId();
            context.read<StoreBloc>().add(
              UpdateStore(
                storeId: storeId!,
                areaId: areaController.text,
                storeName: storeNameController.text,
                address: addressController.text,
                openHours: openHoursController.text,
                closeHours: closingHoursController.text,
                description: descripController.text,
                state: true,
              ),
            );
          }
        },
        child: Container(
          width: 220 * widget.fem,
          height: 45 * widget.hem,
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(23 * widget.fem),
          ),
          child: BlocBuilder<StoreBloc, StoreState>(
            builder: (context, state) {
              if (state is StoreUpding) {
                return Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
              } else {
                return Center(
                  child: Text(
                    'Lưu thông tin',
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        fontSize: 17 * widget.ffem,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      );
    } else {
      return TextButton(
        onPressed: () {},
        child: Container(
          width: 220 * widget.fem,
          height: 45 * widget.hem,
          decoration: BoxDecoration(
            color: kLowTextColor,
            borderRadius: BorderRadius.circular(23 * widget.fem),
          ),
          child: Center(
            child: Text(
              'Lưu thông tin',
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  fontSize: 17 * widget.ffem,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
}
