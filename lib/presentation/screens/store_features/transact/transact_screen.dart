import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/data/models/student_features/student_model.dart';
import 'package:swallet_mobile/domain/interface_repositories/store_features/store_repository.dart';
import 'package:swallet_mobile/domain/interface_repositories/student_features/brand_repository.dart';
import 'package:swallet_mobile/presentation/blocs/brand/brand_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/internet/internet_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/store/store_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/screens/store_features/transact/success_transact_screen.dart';

import 'components/form_transact.dart';
import 'components/information_card_profile.dart';

class TransactScreen extends StatefulWidget {
  static const String routeName = '/transact-screen';

  static Route route({
    required StudentModel studentModel,
    required String brandId,
  }) {
    return MaterialPageRoute(
      builder:
          (_) => BlocProvider(
            create:
                (context) =>
                    StoreBloc(storeRepository: context.read<StoreRepository>()),
            child: TransactScreen(studentModel: studentModel, brandId: brandId),
          ),
      settings: const RouteSettings(arguments: routeName),
    );
  }

  const TransactScreen({
    super.key,
    required this.studentModel,
    required this.brandId,
  });

  final StudentModel studentModel;
  final String brandId;

  @override
  State<TransactScreen> createState() => _TransactScreenState();
}

class _TransactScreenState extends State<TransactScreen> {
  TextEditingController beanController = TextEditingController();
  TextEditingController desController = TextEditingController();
  bool changed = false;
  double greenBalance = 0;

  @override
  void initState() {
    beanController.addListener(() {
      if (beanController.text != '') {
        setState(() {
          changed = true;
        });
      } else if (beanController.text == '') {
        setState(() {
          changed = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    double baseHeight = 812;
    double hem = MediaQuery.of(context).size.height / baseHeight;
    return BlocListener<StoreBloc, StoreState>(
      listener: (context, state) {
        if (state is CreateBonusFailed) {
          print(state.error);
        } else if (state is CreateBonusLoading) {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) {
              Future.delayed(Duration(seconds: 2));
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
        } else if (state is CreateBonusSucess) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            SuccessTransactScreen.routeName,
            (Route<dynamic> route) => false,
            arguments: state.transactModel,
          );
        }
      },
      child: BlocProvider(
        create:
            (context) =>
                BrandBloc(brandRepository: context.read<BrandRepository>())
                  ..add(LoadBrandById(id: widget.brandId)),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: klighGreyColor,
            appBar: AppBar(
              elevation: 0,
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background_splash.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              leading: InkWell(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/landing-screen-store',
                    (Route<dynamic> route) => false,
                  );
                },
                child: Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                  size: 25 * fem,
                ),
              ),
              toolbarHeight: 50 * hem,
              centerTitle: true,
              title: Text(
                'Tặng đậu xanh',
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    fontSize: 18 * ffem,
                    fontWeight: FontWeight.w900,
                    height: 1.3625 * ffem / fem,
                    color: Colors.white,
                  ),
                ),
              ),
              actions: [
                // SvgPicture.asset('assets/icons/notification-icon.svg')
                Padding(
                  padding: EdgeInsets.only(right: 20 * fem),
                  child: IconButton(
                    icon: Icon(Icons.home, color: Colors.white, size: 25 * fem),
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/landing-screen-store',
                        (Route<dynamic> route) => false,
                      );
                    },
                  ),
                ),
              ],
            ),
            body: BlocListener<InternetBloc, InternetState>(
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
                              final stateInternet =
                                  context.read<InternetBloc>().state;
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
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate([
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 20),
                          BlocBuilder<BrandBloc, BrandState>(
                            builder: (context, state) {
                              if (state is BrandLoading) {
                                return Center(
                                  child: Lottie.asset(
                                    'assets/animations/loading-screen.json',
                                    width: 50,
                                    height: 50,
                                  ),
                                );
                              } else if (state is BrandByIdLoaded) {
                                var brand = state.brand;
                                greenBalance = brand.totalIncome;
                                return Container(
                                  width: 324 * fem,
                                  padding: EdgeInsets.only(
                                    top: 15 * hem,
                                    bottom: 15 * hem,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      15 * fem,
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(width: 20 * fem),
                                          Text(
                                            'Ví dư:',
                                            style: GoogleFonts.openSans(
                                              textStyle: TextStyle(
                                                fontSize: 17 * ffem,
                                                fontWeight: FontWeight.bold,
                                                height: 1.3625 * ffem / fem,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '${formatter.format(brand.totalIncome)}',
                                                style: GoogleFonts.openSans(
                                                  textStyle: TextStyle(
                                                    fontSize: 20 * ffem,
                                                    color: Colors.green,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: 2 * fem,
                                                  top: 4 * hem,
                                                ),
                                                child: SvgPicture.asset(
                                                  'assets/icons/green-bean-icon.svg',
                                                  width: 28 * fem,
                                                  height: 26 * fem,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }
                              return Container();
                            },
                          ),
                          SizedBox(height: 20),
                          InformationCardProfile(
                            hem: hem,
                            fem: fem,
                            ffem: ffem,
                            studentModel: widget.studentModel,
                          ),
                          SizedBox(height: 20),
                          FormTransact(
                            fem: fem,
                            hem: hem,
                            ffem: ffem,
                            beanController: beanController,
                            desController: desController,
                          ),
                        ],
                      ),
                    ]),
                  ),
                ],
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: buildButtonTransact(
              context,
              fem,
              hem,
              ffem,
              changed,
              widget.studentModel.id,
              beanController.text,
              desController.text,
              greenBalance,
              true,
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildButtonTransact(
  BuildContext context,
  double fem,
  double hem,
  double ffem,
  bool changed,
  String studentId,
  String amountString,
  String description,
  double greenbalance,
  bool state,
) {
  if (changed) {
    return InkWell(
      onTap: () async {
        final storeId = await AuthenLocalDataSource.getStoreId();
        if (description == '') {
          description = 'Chúc bạn một ngày vui vẻ';
        }
        double amount = double.parse(amountString);
        if (amount > greenbalance * 0.1) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                elevation: 0,
                duration: const Duration(milliseconds: 2000),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                content: AwesomeSnackbarContent(
                  title: 'Chuyển thất bại!',
                  message: 'Số đậu tặng không quá 10% so với ví dư',
                  contentType: ContentType.failure,
                ),
              ),
            );
        } else {
          context.read<StoreBloc>().add(
            CreateBonus(
              storeId: storeId!,
              studentId: studentId,
              amount: amount,
              description: description,
              state: state,
            ),
          );
        }
      },
      child: Container(
        width: 220 * fem,
        height: 40 * hem,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(10 * fem),
        ),
        child: Center(
          child: Text(
            'Chuyển ngay',
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                fontSize: 15 * ffem,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  } else {
    return Container(
      width: 220 * fem,
      height: 40 * hem,
      decoration: BoxDecoration(
        color: kLowTextColor,
        borderRadius: BorderRadius.circular(10 * fem),
      ),
      child: Center(
        child: Text(
          'Chuyển ngay',
          style: GoogleFonts.openSans(
            textStyle: TextStyle(
              fontSize: 15 * ffem,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
