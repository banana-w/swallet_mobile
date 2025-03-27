import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:swallet_mobile/data/models/student_features/student_model.dart';
import 'package:swallet_mobile/domain/interface_repositories/student_features/campus_repository.dart';
import 'package:swallet_mobile/presentation/blocs/campus/campus_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/role/role_app_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/student/student_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import '../../../../../domain/repositories.dart';
import '../../../../blocs/blocs.dart';
import 'drop_down_campus.dart';
import 'drop_down_gender.dart';
import 'text_form_field_default.dart';

class FormUpdate extends StatefulWidget {
  const FormUpdate({
    super.key,
    required this.ffem,
    required this.fem,
    required this.hem,
    required this.studentModel,
  });

  final double ffem;
  final double fem;
  final double hem;
  final StudentModel studentModel;

  @override
  State<FormUpdate> createState() => _FormBody1State();
}

class _FormBody1State extends State<FormUpdate> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController campusController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController invitedCodeController = TextEditingController();
  TextEditingController studentCodeController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();

  bool changed = false;
  @override
  void initState() {
    nameController.text = widget.studentModel.fullName;
    campusController.text = widget.studentModel.campusId ?? '';
    if (widget.studentModel.gender == 'Female') {
      genderController.text = '1';
    } else {
      genderController.text = '2';
    }
    addressController.text = widget.studentModel.address;
    invitedCodeController.text = widget.studentModel.code ?? '';
    studentCodeController.text = widget.studentModel.code ?? '';
    dateOfBirthController.text = widget.studentModel.dateOfBirth;
    nameController.addListener(
      () => setState(() {
        changed = true;
      }),
    );
    campusController.addListener(
      () => setState(() {
        changed = true;
      }),
    );
    genderController.addListener(
      () => setState(() {
        changed = true;
      }),
    );
    addressController.addListener(
      () => setState(() {
        changed = true;
      }),
    );
    invitedCodeController.addListener(
      () => setState(() {
        changed = true;
      }),
    );
    studentCodeController.addListener(
      () => setState(() {
        changed = true;
      }),
    );
    dateOfBirthController.addListener(
      () => setState(() {
        changed = true;
      }),
    );
    super.initState();
  }
  // var box = Hive.box('myBox');

  @override
  Widget build(BuildContext context) {
    return BlocListener<StudentBloc, StudentState>(
      listener: (context, state) {
        if (state is StudentUpdateSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                elevation: 0,
                duration: const Duration(milliseconds: 2000),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                content: AwesomeSnackbarContent(
                  title: 'Sửa thành công',
                  message: 'Cập nhật thông tin mới thành công!',
                  contentType: ContentType.success,
                ),
              ),
            );
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/landing-screen',
            (Route<dynamic> route) => false,
          );
        } else if (state is StudentFaled) {
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
        }
      },
      child: BlocProvider(
        lazy: false,
        create:
            (context) =>
                CampusBloc(context.read<CampusRepository>())
                  ..add(LoadCampus(searchName: '')),
        child: BlocBuilder<CampusBloc, CampusState>(
          builder: (context, state) {
            if (state is CampusLoaded) {
              return Form(
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
                          Container(
                            width: 272 * widget.fem,
                            height: 65 * widget.hem,
                            // color: Colors.red,
                            child: TextFormField(
                              readOnly: true,
                              maxLines: null,
                              expands: true,
                              controller: invitedCodeController,
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15 * widget.ffem,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              decoration: InputDecoration(
                                labelText: 'MÃ GIỚI THIỆU',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                labelStyle: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 15 * widget.ffem,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 26 * widget.fem,
                                  vertical: 10 * widget.hem,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    28 * widget.fem,
                                  ),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: const Color.fromARGB(
                                      255,
                                      220,
                                      220,
                                      220,
                                    ),
                                  ),
                                  gapPadding: 10,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    28 * widget.fem,
                                  ),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: const Color.fromARGB(
                                      255,
                                      220,
                                      220,
                                      220,
                                    ),
                                  ),
                                  gapPadding: 10,
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    28 * widget.fem,
                                  ),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: const Color.fromARGB(
                                      255,
                                      220,
                                      220,
                                      220,
                                    ),
                                  ),
                                  gapPadding: 10,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 25 * widget.hem),
                          TextFormFieldDefault(
                            hem: widget.hem,
                            fem: widget.fem,
                            ffem: widget.ffem,
                            labelText: 'MÃ SINH VIÊN',
                            hintText: 'Nhập mã sinh viên...',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Mã sinh viên không được bỏ trống';
                              } else if (value.length > 20) {
                                return 'Mã sinh viên tối đa 20 kí tự';
                              }
                              return null;
                            },
                            textController: studentCodeController,
                          ),
                          SizedBox(height: 25 * widget.hem),
                          Container(
                            width:
                                272 *
                                widget
                                    .fem, // Đặt chiều rộng đồng bộ với các trường khác
                            child: TextFormField(
                              controller: dateOfBirthController,
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: 'NGÀY SINH',
                                hintText: 'Chọn ngày sinh...',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                labelStyle: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 15 * widget.ffem,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 26 * widget.fem,
                                  vertical: 10 * widget.hem,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    28 * widget.fem,
                                  ),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: const Color.fromARGB(
                                      255,
                                      220,
                                      220,
                                      220,
                                    ),
                                  ),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.calendar_today,
                                    color: kPrimaryColor,
                                  ),
                                  onPressed: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate:
                                          DateTime.tryParse(
                                            widget.studentModel.dateOfBirth,
                                          ) ??
                                          DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime.now(),
                                    );
                                    if (pickedDate != null) {
                                      setState(() {
                                        dateOfBirthController.text =
                                            "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                                        changed = true;
                                      });
                                    }
                                  },
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Ngày sinh không được bỏ trống';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 25 * widget.hem),
                          TextFormFieldDefault(
                            hem: widget.hem,
                            fem: widget.fem,
                            ffem: widget.ffem,
                            labelText: 'HỌ VÀ TÊN',
                            hintText: 'Nhập họ và tên...',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Họ và tên không được bỏ trống';
                              } else if (value.length < 3) {
                                return 'Họ và tên ít nhất 3 kí tự';
                              } else if (value.length > 50) {
                                return 'Họ và tên tối đa 50 kí tự';
                              } else if (!vietNameseTextOnlyPattern.hasMatch(
                                value,
                              )) {
                                return 'Họ và tên không hợp lệ';
                              }
                              return null;
                            },
                            textController: nameController,
                          ),

                          SizedBox(height: 25 * widget.hem),
                          DropDownCampus(
                            fem: widget.fem,
                            hem: widget.hem,
                            ffem: widget.ffem,
                            hintText: 'Chọn cơ sở',
                            labelText: 'CƠ SỞ',
                            campusController: campusController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Cơ sở không được bỏ trống';
                              }
                              return null;
                            },
                            campusId: widget.studentModel.campusId ?? '',
                            campuses: state.campuses,
                          ),
                          SizedBox(height: 25 * widget.hem),
                          DropDownGender(
                            fem: widget.fem,
                            hem: widget.hem,
                            ffem: widget.ffem,
                            hintText: 'Chọn giới tính',
                            labelText: 'GIỚI TÍNH',
                            genderController: genderController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Giới tính không được bỏ trống';
                              }
                              return null;
                            },
                            genderName:
                                widget.studentModel.gender?.toString() ?? '',
                          ),
                          SizedBox(height: 25 * widget.hem),
                          TextFormFieldDefault(
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
                        ],
                      ),
                    ),
                    SizedBox(height: 25 * widget.hem),
                    buttonWidget(changed, context),
                  ],
                ),
              );
            }

            return Container(
              width: MediaQuery.of(context).size.width,
              height: 400,
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
              child: Center(
                child: Lottie.asset('assets/animations/loading-screen.json'),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buttonWidget(bool changed, BuildContext context) {
    if (changed) {
      return TextButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            context.read<StudentBloc>().add(
              UpdateStudent(
                studentId: widget.studentModel.id,
                fullName:
                    nameController.text.isNotEmpty
                        ? nameController.text
                        : widget.studentModel.fullName,
                studentCode:
                    studentCodeController.text.isNotEmpty
                        ? studentCodeController.text
                        : widget.studentModel.code ?? '',
                dateOfBirth:
                    dateOfBirthController.text.isNotEmpty
                        ? DateTime.tryParse(dateOfBirthController.text) ??
                            DateTime.now()
                        : DateTime.tryParse(widget.studentModel.dateOfBirth) ??
                            DateTime.now(),
                campusId:
                    campusController.text.isNotEmpty
                        ? campusController.text
                        : widget.studentModel.campusId ?? '',
                address:
                    addressController.text.isNotEmpty
                        ? addressController.text
                        : widget.studentModel.address,
                gender:
                    genderController.text.isNotEmpty
                        ? int.parse(genderController.text)
                        : (widget.studentModel.gender == 'Female' ? 1 : 2),
              ),
            );
            context.read<RoleAppBloc>().add(RoleAppStart());
          }
        },
        child: Container(
          width: 220 * widget.fem,
          height: 45 * widget.hem,
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(23 * widget.fem),
          ),
          child: BlocBuilder<StudentBloc, StudentState>(
            builder: (context, state) {
              if (state is StudentUpding) {
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
