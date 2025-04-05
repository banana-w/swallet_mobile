import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/data/models/lecture_features/lecture_model.dart';
import 'package:swallet_mobile/presentation/blocs/lecture/lecture_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/screens/lecture_features/qr_generate/qr_generate_screen.dart';

import 'name_profile.dart';

class InformationCardProfile extends StatefulWidget {
  const InformationCardProfile({
    super.key,
    required this.fem,
    required this.hem,
    required this.lectureModel,
    required this.ffem,
  });

  final double fem;
  final double hem;
  final LectureModel lectureModel;
  final double ffem;

  @override
  State<InformationCardProfile> createState() => _InformationCardProfileState();
}

class _InformationCardProfileState extends State<InformationCardProfile> {
  final _formKey = GlobalKey<FormState>();
  File? _selectedAvatar;
  LectureModel? lecture;
  @override
  Widget build(BuildContext context) {
    return BlocListener<LectureBloc, LectureState>(
      listener: (context, state) {},
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
                    child: BlocBuilder<LectureBloc, LectureState>(
                      builder: (context, state) {
                        if (state is LectureLoaded) {
                          final lecture = state.lecture;
                          return Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child:
                                    _selectedAvatar == null
                                        ? Image.network(
                                          'assets/images/ava_signup.png',
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
                        BlocBuilder<LectureBloc, LectureState>(
                          builder: (context, state) {
                            if (state is LectureLoaded) {
                              return NameProfile(
                                fem: widget.fem,
                                ffem: widget.ffem,
                                hem: widget.hem,
                                name: state.lecture.fullName,
                              );
                            }
                            return NameProfile(
                              fem: widget.fem,
                              ffem: widget.ffem,
                              hem: widget.hem,
                              name:
                                  lecture == null
                                      ? widget.lectureModel.fullName
                                      : lecture!.fullName,
                            );
                          },
                        ),
                        //email
                        BlocBuilder<LectureBloc, LectureState>(
                          builder: (context, state) {
                            if (state is LectureLoaded) {
                              return SizedBox(
                                width: 150 * widget.fem,
                                child: Text(
                                  '${state.lecture.email}',
                                  maxLines: 1,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                      fontSize: 13 * widget.ffem,
                                      fontWeight: FontWeight.normal,
                                      color: klowTextGrey,
                                    ),
                                  ),
                                ),
                              );
                            }
                            return SizedBox(
                              width: 150 * widget.fem,
                              child: Text(
                                lecture == null
                                    ? '${widget.lectureModel.email}'
                                    : lecture!.email,
                                maxLines: 1,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                    fontSize: 13 * widget.ffem,
                                    fontWeight: FontWeight.normal,
                                    color: klowTextGrey,
                                  ),
                                ),
                              ),
                            );
                          },
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
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => QRGenerateScreen(
                                  lectureId:
                                      widget
                                          .lectureModel
                                          .id, // Truyền `lectureId` từ `lectureModel`
                                ),
                          ),
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
                                'assets/icons/campaign-navbar-icon.svg',
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
                              'Tạo mã QR',
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getLecture() async {
    final lectureModel = await AuthenLocalDataSource.getLecture();
    setState(() {
      lecture = lectureModel;
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
  }
}
