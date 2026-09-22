import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/data/interface_repositories/store_features/store_repository.dart';
import 'package:swallet_mobile/data/models/store_features/store_model.dart';
import 'package:swallet_mobile/presentation/blocs/store/store_bloc.dart';
import 'package:swallet_mobile/presentation/widgets/internet_listener.dart';

import 'form_update.dart';

class Body extends StatelessWidget {
  const Body({super.key, required this.storeModel});

  final StoreModel storeModel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final fem = size.width / 375;
    final ffem = fem * 0.97;
    final hem = size.height / 812;

    return InternetListener(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20 * hem),
              Text(
                'Thông tin cá nhân',
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 18 * ffem,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 20 * hem),
              BlocProvider(
                create:
                    (context) => StoreBloc(
                      storeRepository: context.read<StoreRepository>(),
                    ),
                child: FormUpdate(
                  ffem: ffem,
                  fem: fem,
                  hem: hem,
                  storeModel: storeModel,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
