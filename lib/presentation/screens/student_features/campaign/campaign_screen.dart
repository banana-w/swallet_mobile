import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:swallet_mobile/data/interface_repositories/lecture_features/lecture_repository.dart';
import 'package:swallet_mobile/data/interface_repositories/store_features/store_repository.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/campaign_repository.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/student_repository.dart';
import 'package:swallet_mobile/data/repositories/student_features/check_in_repository_imp.dart';
import 'package:swallet_mobile/presentation/blocs/campaign/campaign_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/checkin_bloc/check_in_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/role/role_app_bloc.dart';
import 'package:swallet_mobile/presentation/screens/student_features/campaign/components/body.dart';

class CampaignScreen extends StatelessWidget {
  static const String routeName = '/campaign-student';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const CampaignScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const CampaignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
            create: (context) => RoleAppBloc(context.read<StudentRepository>(),
                context.read<StoreRepository>(), context.read<LectureRepository>())
              ..add(RoleAppStart())),
        BlocProvider(
          create: (context) => CampaignBloc(
              campaignRepository: context.read<CampaignRepository>())
            ..add(LoadCampaigns()),
        ),
        BlocProvider(
          create: (context) => CheckInBloc(CheckInRepositoryImpl())
        ..add(LoadCheckInData()),
        ),
      ],

      child: BlocBuilder<CampaignBloc, CampaignState>(
        builder: (context, state) {
          if (state is CampaignsLoaded) {
            return CampaignScreenBody();
          }
          return Center(
            child: Container(
                child: Lottie.asset('assets/animations/loading-screen.json')),
          );
        },
      ),
    );
  }
}
