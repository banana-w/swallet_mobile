import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/data/models/student_features/student_model.dart';
import 'package:swallet_mobile/presentation/blocs/campus/campus_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/student/student_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/screens/student_features/profile/components/name_profile.dart';
import 'package:swallet_mobile/presentation/screens/student_features/profile/components/student_code_profile.dart';
import 'package:swallet_mobile/presentation/screens/student_features/profile/components/unitiversity_name_profile.dart';
import 'package:swallet_mobile/presentation/screens/student_features/profile_update_detail/profile_update_detail_screen.dart';

class InformationCardProfile extends StatefulWidget {
  const InformationCardProfile({
    super.key,
    required this.hem,
    required this.fem,
    required this.ffem,
    required this.studentModel,
  });

  final double hem;
  final double fem;
  final double ffem;
  final StudentModel studentModel;

  @override
  State<InformationCardProfile> createState() => _InformationCardProfileState();
}

class _InformationCardProfileState extends State<InformationCardProfile> {
  final _formKey = GlobalKey<FormState>();
  File? _selectedAvatar;
  StudentModel? student;
  @override
  void initState() {
    getStudent();
    super.initState();
  }

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
                  title: 'Cập nhật thành công',
                  message: 'Cập nhật ảnh đại diện thành công!',
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
                  title: 'Cập nhật thất bại',
                  message: 'Cập nhật ảnh đại diện thất bại!',
                  contentType: ContentType.failure,
                ),
              ),
            );
          Navigator.pop(context);
        } else if (state is StudentUpding) {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) {
              Future.delayed(Duration(seconds: 10));
              return AlertDialog(
                content: SizedBox(
                  width: 250,
                  height: 250,
                  child: Center(
                    child: CircularProgressIndicator(color: kPrimaryColor),
                  ),
                ),
              );
            },
          );
        }
      },
      child: Form(
        key: _formKey,
        child: Container(
          width: 324 * widget.fem,
          height: 200 * widget.hem,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15 * widget.fem),
            color: Colors.white,
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
                  InkWell(
                    onTap: () {
                      _imageModelBottomSheet(context, _selectedAvatar);
                    },
                    child: BlocBuilder<StudentBloc, StudentState>(
                      builder: (context, state) {
                        if (state is StudentByIdSuccess) {
                          final student = state.studentMode;
                          return Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child:
                                    _selectedAvatar == null
                                        ? Image.network(
                                          student.studentCardFront,
                                          // 'assets/images/ava_signup.png',
                                          width: 80 * widget.fem,
                                          height: 80 * widget.hem,
                                          fit: BoxFit.fill,
                                          errorBuilder: (
                                            context,
                                            error,
                                            stackTrace,
                                          ) {
                                            return Image.asset(
                                              'assets/images/ava_signup.png',
                                              width: 80 * widget.fem,
                                              height: 80 * widget.hem,
                                            );
                                          },
                                        )
                                        : Container(
                                          width: 80 * widget.fem,
                                          height: 80 * widget.hem,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: FileImage(
                                                _selectedAvatar!,
                                              ),
                                            ),
                                          ),
                                        ),
                              ),
                              Positioned(
                                bottom: 0 * widget.hem,
                                right: 0 * widget.fem,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: klighGreyColor,
                                  ),
                                  padding: EdgeInsets.all(5),
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    weight: 1,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                        return Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child:
                                  _selectedAvatar == null
                                      ? Image.asset(
                                        'assets/images/ava_signup.png',
                                        // 'assets/images/ava_signup.png',
                                        width: 80 * widget.fem,
                                        height: 80 * widget.hem,
                                        fit: BoxFit.fill,
                                      )
                                      : Container(
                                        width: 80 * widget.fem,
                                        height: 80 * widget.hem,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: FileImage(_selectedAvatar!),
                                          ),
                                        ),
                                      ),
                            ),
                            Positioned(
                              bottom: 0 * widget.hem,
                              right: 0 * widget.fem,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: klighGreyColor,
                                ),
                                padding: EdgeInsets.all(5),
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  weight: 1,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),

                  SizedBox(width: 20 * widget.fem),

                  SizedBox(
                    // color: Colors.red,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Name
                        BlocBuilder<StudentBloc, StudentState>(
                          builder: (context, state) {
                            if (state is StudentByIdSuccess) {
                              return NameProfile(
                                fem: widget.fem,
                                ffem: widget.ffem,
                                hem: widget.hem,
                                name: state.studentMode.fullName,
                              );
                            }
                            return NameProfile(
                              fem: widget.fem,
                              ffem: widget.ffem,
                              hem: widget.hem,
                              name:
                                  student == null
                                      ? widget.studentModel.fullName
                                      : student!.fullName,
                            );
                          },
                        ),
                        //email
                        SizedBox(
                          width: 150 * widget.fem,
                          child: Text(
                            widget.studentModel.address,
                            maxLines: 1,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                fontSize: 12 * widget.ffem,
                                fontWeight: FontWeight.normal,
                                color: klowTextGrey,
                              ),
                            ),
                          ),
                        ),
                        //student code
                        StudentCodeProfile(
                          hem: widget.hem,
                          fem: widget.fem,
                          ffem: widget.ffem,
                          studentCode: widget.studentModel.code ?? '',
                        ),
                        //university name
                        UniversityProfile(
                          fem: widget.fem,
                          hem: widget.hem,
                          ffem: widget.ffem,
                          university: widget.studentModel.campusId ?? '',
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
              Padding(
                padding: EdgeInsets.only(top: 10 * widget.hem),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () async {
                        final student =
                            await AuthenLocalDataSource.getStudent();

                        context.read<CampusBloc>().add(
                          LoadCampus(searchName: ''),
                        );
                        Navigator.pushNamed(
                          context,
                          ProfileUpdateDetailScreen.routeName,
                          arguments: student,
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          left: 5 * widget.fem,
                          right: 5 * widget.fem,
                        ),
                        width: 140 * widget.fem,
                        height: 40 * widget.hem,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[100],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: SvgPicture.asset(
                                'assets/icons/pen-icon.svg',
                                colorFilter: ColorFilter.mode(
                                  kPrimaryColor,
                                  BlendMode.srcIn,
                                ),
                                height: 18 * widget.fem,
                                width: 18 * widget.fem,
                              ),
                            ),
                            SizedBox(width: 5 * widget.fem),
                            Text(
                              'Sửa thông tin',
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                  fontSize: 12 * widget.fem,
                                  fontWeight: FontWeight.bold,
                                  height: 1.3625 * widget.ffem / widget.fem,
                                  color: kPrimaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // Navigator.pushNamed(context, WishListScreen.routeName);
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          left: 5 * widget.fem,
                          right: 5 * widget.fem,
                        ),
                        width: 140 * widget.fem,
                        height: 40 * widget.hem,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[100],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: SvgPicture.asset(
                                'assets/icons/following-icon.svg',
                                colorFilter: ColorFilter.mode(
                                  kPrimaryColor,
                                  BlendMode.srcIn,
                                ),
                                height: 25 * widget.fem,
                                width: 25 * widget.fem,
                              ),
                            ),
                            SizedBox(width: 5 * widget.fem),
                            // BlocBuilder<StudentBloc, StudentState>(
                            //   builder: (context, state) {
                            //     if (state is StudentByIdSuccess) {
                            //       return Text(
                            //         '${state.studentMode.} theo dõi',
                            //         style: GoogleFonts.openSans(
                            //             textStyle: TextStyle(
                            //                 fontSize: 12 * widget.fem,
                            //                 fontWeight: FontWeight.bold,
                            //                 height: 1.3625 *
                            //                     widget.ffem /
                            //                     widget.fem,
                            //                 color: kPrimaryColor)),
                            //       );
                            //     }
                            //     return Text(
                            //       '${widget.studentModel.following} theo dõi',
                            //       style: GoogleFonts.openSans(
                            //           textStyle: TextStyle(
                            //               fontSize: 12 * widget.fem,
                            //               fontWeight: FontWeight.bold,
                            //               height:
                            //                   1.3625 * widget.ffem / widget.fem,
                            //               color: kPrimaryColor)),
                            //     );
                            //   },
                            // )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getStudent() async {
    final studentModel = await AuthenLocalDataSource.getStudent();
    setState(() {
      student = studentModel;
    });
  }

  Future _pickerImageFromGallery(
    File? selectedImage,
    BuildContext context,
  ) async {
    final returnedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (returnedImage == null) return;

    selectedImage = File(returnedImage.path);

    setState(() {
      _selectedAvatar = selectedImage;
    });
    Navigator.pop(context);
  }

  Future _pickerImageFromCamera(
    File? selectedImage,
    BuildContext context,
  ) async {
    final returnedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );

    if (returnedImage == null) return;

    selectedImage = File(returnedImage.path);

    setState(() {
      _selectedAvatar = selectedImage;
    });
    Navigator.pop(context);
  }

  void _imageModelBottomSheet(BuildContext context, File? selectedImage) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    double baseHeight = 812;
    double hem = MediaQuery.of(context).size.height / baseHeight;

    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  _pickerImageFromCamera(selectedImage, context).then((
                    value,
                  ) async {
                    int gender;
                    if (widget.studentModel.gender == 'Male') {
                      gender = 2;
                    } else {
                      gender = 1;
                    }
                    final studentModel =
                        await AuthenLocalDataSource.getStudent();
                    context.read<StudentBloc>().add(
                      UpdateStudent(
                        studentId: studentModel!.id,
                        fullName: studentModel.fullName,
                        studentCode: studentModel.code ?? '',
                        dateOfBirth: DateTime.parse(studentModel.dateOfBirth),
                        // majorId: studentModel.id,
                        campusId: studentModel.id,
                        avatar: _selectedAvatar!.path,
                        gender: gender,
                      ),
                    );
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.camera_alt,
                      color: kPrimaryColor,
                      size: 30 * fem,
                    ),
                    SizedBox(width: 5 * fem),
                    Text(
                      'Chụp ảnh',
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontSize: 20 * ffem,
                          fontWeight: FontWeight.bold,
                          height: 1.3625 * ffem / fem,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 18 * hem),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Divider(
                  color: kLowTextColor,
                  thickness: 2 * fem,
                  // height: 300*fem,
                ),
              ),
              SizedBox(height: 18 * hem),
              GestureDetector(
                onTap: () {
                  _pickerImageFromGallery(selectedImage, context).then((
                    value,
                  ) async {
                    int gender;
                    if (widget.studentModel.gender == 'Male') {
                      gender = 2;
                    } else {
                      gender = 1;
                    }
                    final studentModel =
                        await AuthenLocalDataSource.getStudent();
                    context.read<StudentBloc>().add(
                      UpdateStudent(
                        studentId: studentModel!.id,
                        fullName: studentModel.fullName,
                        studentCode: studentModel.code ?? '',
                        dateOfBirth: DateTime.parse(studentModel.dateOfBirth),
                        // majorId: studentModel.id,
                        campusId: studentModel.id,
                        avatar: _selectedAvatar!.path,
                        gender: gender,
                      ),
                    );
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.photo_size_select_actual_rounded,
                      color: kPrimaryColor,
                      size: 30 * fem,
                    ),
                    SizedBox(width: 5 * fem),
                    Text(
                      'Chọn sẵn có',
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontSize: 20 * ffem,
                          fontWeight: FontWeight.bold,
                          height: 1.3625 * ffem / fem,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
