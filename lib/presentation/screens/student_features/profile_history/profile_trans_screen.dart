import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/student_repository.dart';
import 'package:swallet_mobile/presentation/blocs/student/student_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'components/body.dart';

class ProfileTransactionHistoryScreen extends StatelessWidget {
  static const String routeName = '/profile-trans';

  static Route route({required String studentId}) {
    return MaterialPageRoute(
        builder: (_) => ProfileTransactionHistoryScreen(
              studentId: studentId,
            ),
        settings: const RouteSettings(name: routeName));
  }

  const ProfileTransactionHistoryScreen({super.key, required this.studentId});
  final String studentId;

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
     create: (context) =>
          StudentBloc(studentRepository: context.read<StudentRepository>())
            ..add(LoadStudentTransactions(id: studentId)),
      child: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: klighGreyColor,
            body: Body(
              studentId: studentId,
            ),
          ),
        ),
      ),
    );
  }
}
