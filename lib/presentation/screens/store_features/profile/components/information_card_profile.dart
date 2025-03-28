import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/data/models/store_features/store_model.dart';
import 'package:swallet_mobile/presentation/blocs/store/store_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';

import 'name_profile.dart';

class InformationCardProfile extends StatefulWidget {
  const InformationCardProfile({
    super.key,
    required this.fem,
    required this.hem,
    required this.storeModel,
    required this.ffem,
  });

  final double fem;
  final double hem;
  final StoreModel storeModel;
  final double ffem;

  @override
  State<InformationCardProfile> createState() => _InformationCardProfileState();
}

class _InformationCardProfileState extends State<InformationCardProfile> {
  final _formKey = GlobalKey<FormState>();
  File? _selectedAvatar;
  StoreModel? store;
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
                  message: 'Cập nhật ảnh đại diện thành công!',
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
                  title: 'Cập nhật thất bại',
                  message: 'Cập nhật ảnh đại diện thất bại!',
                  contentType: ContentType.failure,
                ),
              ),
            );
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/landing-screen-store',
            (Route<dynamic> route) => false,
          );
        } else if (state is StoreUpding) {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) {
              Future.delayed(Duration(seconds: 10), () {
                Navigator.of(context).pop();
              });
              return AlertDialog(
                content: Container(
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
                    child: BlocBuilder<StoreBloc, StoreState>(
                      builder: (context, state) {
                        if (state is StoreByIdLoaed) {
                          final store = state.storeModel;
                          return Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child:
                                    _selectedAvatar == null
                                        ? Image.network(
                                          '${store.avatar}',
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
                        BlocBuilder<StoreBloc, StoreState>(
                          builder: (context, state) {
                            if (state is StoreByIdLoaed) {
                              return NameProfile(
                                fem: widget.fem,
                                ffem: widget.ffem,
                                hem: widget.hem,
                                name: state.storeModel.storeName,
                              );
                            }
                            return NameProfile(
                              fem: widget.fem,
                              ffem: widget.ffem,
                              hem: widget.hem,
                              name:
                                  store == null
                                      ? widget.storeModel.storeName
                                      : store!.storeName,
                            );
                          },
                        ),
                        //email
                        BlocBuilder<StoreBloc, StoreState>(
                          builder: (context, state) {
                            if (state is StoreByIdLoaed) {
                              return SizedBox(
                                width: 150 * widget.fem,
                                child: Text(
                                  '${state.storeModel.email}',
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
                                store == null
                                    ? '${widget.storeModel.email}'
                                    : store!.email,
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
                      onTap: () {},
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
                              '${widget.storeModel.numberOfCampaigns} chiến dịch',
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
                      onTap: () {},
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
                                'assets/icons/voucher-navbar-icon.svg',
                                colorFilter: ColorFilter.mode(
                                  kPrimaryColor,
                                  BlendMode.srcIn,
                                ),
                                height: 15 * widget.fem,
                                width: 15 * widget.fem,
                              ),
                            ),
                            SizedBox(width: 5 * widget.fem),
                            Text(
                              '${widget.storeModel.numberOfVouchers} ưu đãi',
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

  Future<void> getStore() async {
    final storeModel = await AuthenLocalDataSource.getStore();
    setState(() {
      store = storeModel;
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
        return Container(
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
                    final storeModel = await AuthenLocalDataSource.getStore();
                    context.read<StoreBloc>().add(
                      UpdateStore(
                        storeId: storeModel!.id,
                        areaId: storeModel.areaId,
                        storeName: storeModel.storeName,
                        address: storeModel.address,
                        openHours: storeModel.openingHours,
                        closeHours: storeModel.closingHours,
                        description: storeModel.description,
                        avatar: _selectedAvatar!.path,
                        state: true,
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
                    final storeModel = await AuthenLocalDataSource.getStore();
                    context.read<StoreBloc>().add(
                      UpdateStore(
                        storeId: storeModel!.id,
                        areaId: storeModel.areaId,
                        storeName: storeModel.storeName,
                        address: storeModel.address,
                        openHours: storeModel.openingHours,
                        closeHours: storeModel.closingHours,
                        description: storeModel.description,
                        avatar: _selectedAvatar!.path,
                        state: true,
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
