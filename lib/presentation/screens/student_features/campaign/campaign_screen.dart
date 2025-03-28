import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

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
        // BlocProvider(
        //   lazy: false,
        //     create: (context) => RoleAppBloc(context.read<StudentRepository>(),
        //         context.read<StoreRepository>())
        //       ..add(RoleAppStart())),
        // BlocProvider(
        //   create: (context) => CampaignBloc(
        //       campaignRepository: context.read<CampaignRepository>())
        //     ..add(LoadCampaigns()),
        // ),
      ],

      // child: BlocBuilder<CampaignBloc, CampaignState>(
      //   builder: (context, state) {
      //     if (state is CampaignsLoaded) {
      //       return Body();
      //     }
      //     return Center(
      //       child: Container(
      //           child: Lottie.asset('assets/animations/loading-screen.json')),
      //     );
      //   },
      // ),
      child: Container(
        child: Lottie.asset('assets/animations/loading-screen.json'),
      ),
    );
  }
}
