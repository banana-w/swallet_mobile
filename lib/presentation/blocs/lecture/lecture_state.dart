part of 'lecture_bloc.dart';

abstract class LectureState {
  const LectureState();
}

class LectureInitial extends LectureState {
  const LectureInitial();
}

class LectureLoading extends LectureState {
  const LectureLoading();
}

class LectureLoaded extends LectureState {
  final LectureModel lecture;
  const LectureLoaded(this.lecture);

  List<Object?> get props => [lecture];
}

class LectureLoadFailed extends LectureState {
  final String message;
  const LectureLoadFailed(this.message);
  
  List<Object?> get props => [message];
}

class QRCodeGenerating extends LectureState {
  const QRCodeGenerating();
}

class QRCodeGenerated extends LectureState {
  final Map<String, String> qrCodeData; // Sửa thành Map<String, String>
  const QRCodeGenerated(this.qrCodeData);

  List<Object?> get props => [qrCodeData];
}

class QRCodeGenerationFailed extends LectureState {
  final String message;
  const QRCodeGenerationFailed(this.message);
  List<Object?> get props => [message];
}
