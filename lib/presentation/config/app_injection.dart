import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swallet_mobile/data/firebase/notification_service.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/check_in_repository.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/wishlist_repository.dart';
import 'package:swallet_mobile/data/repositories/authen_repository_imp.dart';
import 'package:swallet_mobile/data/repositories/lecture_features/lecture_repository_imp.dart';
import 'package:swallet_mobile/data/repositories/store_features/store_repository_imp.dart';
import 'package:swallet_mobile/data/repositories/student_features/brand_repository_imp.dart';
import 'package:swallet_mobile/data/repositories/student_features/campaign_repository_imp.dart';
import 'package:swallet_mobile/data/repositories/student_features/campus_repository.dart';
import 'package:swallet_mobile/data/repositories/student_features/challenge_repository_imp.dart';
import 'package:swallet_mobile/data/repositories/student_features/check_in_repository_imp.dart';
import 'package:swallet_mobile/data/repositories/student_features/lucky_prize_repository.dart';
import 'package:swallet_mobile/data/repositories/student_features/student_repository_imp.dart';
import 'package:swallet_mobile/data/repositories/student_features/validation_repository_imp.dart';
import 'package:swallet_mobile/data/repositories/student_features/verification_repository_imp.dart';
import 'package:swallet_mobile/data/repositories/student_features/wheel_repository.dart';
import 'package:swallet_mobile/data/interface_repositories/authentication_repository.dart';
import 'package:swallet_mobile/data/interface_repositories/lecture_features/lecture_repository.dart';
import 'package:swallet_mobile/data/interface_repositories/store_features/store_repository.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/brand_repository.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/campaign_repository.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/campus_repository.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/challenge_repository.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/student_repository.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/validation_repository.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/verification_repository.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/wheel_repository.dart';
import 'package:swallet_mobile/data/repositories/student_features/wishlist_repository.dart';
import 'package:swallet_mobile/presentation/blocs/authentication/authentication_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/brand/brand_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/campaign/campaign_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/campus/campus_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/challenge/challenge_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/checkin_bloc/check_in_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/internet/internet_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/landing_screen/landing_screen_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/lecture/lecture_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/location/location_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/notification/notification_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/ranking/ranking_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/role/role_app_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/store/store_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/wishlist/wishlist_bloc.dart';
import 'package:swallet_mobile/presentation/cubits/validation/validation_cubit.dart';
import 'package:swallet_mobile/presentation/cubits/verification/verification_cubit.dart';

class AppInjection extends StatelessWidget {
  final Widget child;

  const AppInjection({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepository>(
          create: (_) => AuthenticationRepositoryImp(),
        ),
        RepositoryProvider<StudentRepository>(
          create: (_) => StudentRepositoryImp(),
        ),
        RepositoryProvider<StoreRepository>(
          create: (_) => StoreRepositoryImp(),
        ),
        RepositoryProvider<CampusRepository>(
          create: (_) => CampusRepositoryImp(),
        ),
        RepositoryProvider<ValidationRepository>(
          create: (_) => ValidationRepositoryImp(),
        ),
        RepositoryProvider<CampaignRepository>(
          create: (_) => CampaignRepositoryImp(),
        ),
        RepositoryProvider<LuckyPrizeRepository>(
          create: (_) => LuckyPrizeRepository(),
        ),
        RepositoryProvider<VerificationRepository>(
          create: (_) => VerificationRepositoryImp(),
        ),
        RepositoryProvider<BrandRepository>(
          create: (_) => BrandRepositoryImp(),
        ),
        RepositoryProvider<ChallengeRepository>(
          create: (_) => ChallengeRepositoryImp(),
        ),
        RepositoryProvider<LectureRepository>(
          create: (_) => LectureRepositoryImp(),
        ),
        RepositoryProvider<SpinHistoryRepository>(
          create: (_) => SpinHistoryRepositoryImpl(),
        ),
        RepositoryProvider<CheckInRepository>(
          create: (_) => CheckInRepositoryImpl(),
        ),
        RepositoryProvider<WishListRepository>(
          create: (_) => WishListRepositoryImp(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => InternetBloc()),
          BlocProvider(
            create: (context) => notificationBloc..add(LoadNotification()),
          ),
          BlocProvider(create: (context) => LandingScreenBloc()),
          BlocProvider(
            create:
                (context) => RoleAppBloc(
                  context.read<StudentRepository>(),
                  context.read<StoreRepository>(),
                  context.read<LectureRepository>(),
                )..add(RoleAppStart()),
          ),
          BlocProvider(
            create:
                (context) => AuthenticationBloc(
                  authenticationRepository:
                      context.read<AuthenticationRepository>(),
                )..add(StartAuthen()),
          ),
          BlocProvider(
            create:
                (context) =>
                    ValidationCubit(context.read<ValidationRepository>())
                      ..loadingValidation(),
          ),
          BlocProvider(
            create:
                (context) =>
                    VerificationCubit(context.read<VerificationRepository>())
                      ..loadingVerification(),
          ),
          BlocProvider(
            create:
                (context) => ChallengeBloc(
                  challengeRepository: context.read<ChallengeRepository>(),
                  studentRepository: context.read<StudentRepository>(),
                ),
          ),
          BlocProvider(
            create:
                (context) =>
                    CampusBloc(context.read<CampusRepository>())
                      ..add(LoadCampus(searchName: '')),
          ),
          BlocProvider(
            create:
                (context) =>
                    StoreBloc(storeRepository: context.read<StoreRepository>())
                      ..add(LoadStoreCampaignVouchers()),
          ),
          BlocProvider(
            create:
                (context) => RankingBloc(
                  storeRepository: context.read<StoreRepository>(),
                )..add(LoadCampaignRanking()),
          ),
          BlocProvider(
            create:
                (context) => LectureBloc(
                  lectureRepository: context.read<LectureRepository>(),
                ),
          ),
          BlocProvider(
            create:
                (context) =>
                    BrandBloc(brandRepository: context.read<BrandRepository>())
                      ..add(LoadBrands(page: 1, size: 10)),
          ),
          BlocProvider(
            create:
                (context) => CampaignBloc(
                  campaignRepository: context.read<CampaignRepository>(),
                )..add(LoadCampaigns()),
          ),
          BlocProvider(
            create:
                (context) =>
                    LocationBloc(context.read<ChallengeRepository>())
                      ..add(AddLocation()),
          ),
          BlocProvider(
            create: (context) => CheckInBloc(context.read<CheckInRepository>()),
          ),
          BlocProvider(
            create:
                (context) => WishlistBloc(
                  studentRepository: context.read<StudentRepository>(),
                  wishListRepository: context.read<WishListRepository>(),
                )..add(LoadWishListByStudentId()),
          ),
        ],
        child: child,
      ),
    );
  }
}
