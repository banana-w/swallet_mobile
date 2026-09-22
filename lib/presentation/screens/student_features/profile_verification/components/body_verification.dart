import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swallet_mobile/data/models/student_features/student_model.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/student_repository.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/validation_repository.dart';
import 'package:swallet_mobile/presentation/blocs/student/student_bloc.dart';
import 'package:swallet_mobile/presentation/cubits/validation/validation_cubit.dart';

import 'form_verification.dart';

class BodyVerification extends StatelessWidget {
  const BodyVerification({super.key, required this.studentModel});

  final StudentModel studentModel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final fem = size.width / 375;
    final hem = size.height / 812;
    final ffem = fem * 0.97;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          // Tối thiểu bằng màn hình để ảnh nền phủ kín, nhưng vẫn giãn ra
          // được khi bàn phím đẩy nội dung lên — trước đây ép cứng `height`
          // nên form luôn dài hơn vùng nhìn thấy đúng bằng chiều cao app bar.
          constraints: BoxConstraints(minHeight: size.height),
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/bg_signup_1.png'),
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 120 * hem),
              MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create:
                        (context) => ValidationCubit(
                          context.read<ValidationRepository>(),
                        ),
                  ),
                  BlocProvider(
                    create:
                        (context) => StudentBloc(
                          studentRepository: context.read<StudentRepository>(),
                        ),
                  ),
                ],
                child: FormVerification(
                  fem: fem,
                  hem: hem,
                  ffem: ffem,
                  studentModel: studentModel,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
