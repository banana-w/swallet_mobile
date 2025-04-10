import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:swallet_mobile/data/interface_repositories/store_features/store_repository.dart';
import 'package:swallet_mobile/presentation/blocs/role/role_app_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/store/store_bloc.dart';

import 'components/body.dart';

class CampaignStoreScreen extends StatelessWidget {
  const CampaignStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StoreBloc(
        storeRepository: context.read<StoreRepository>(),
      )..add(LoadStoreCampaignVouchers()), // Khởi tạo StoreBloc và gọi sự kiện
      child: Builder(
        builder: (context) {
          final roleState = context.watch<RoleAppBloc>().state;
          if (roleState is StoreRole) {
            return Body(storeModel: roleState.storeModel);
          } else {
            return Center(
              child: Lottie.asset('assets/animations/loading-screen.json'),
            );
          }
        },
      ),
    );
  }
}
