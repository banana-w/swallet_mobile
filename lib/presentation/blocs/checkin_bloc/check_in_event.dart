part of 'check_in_bloc.dart';

abstract class CheckInEvent {}

class LoadCheckInData extends CheckInEvent {}

class CheckIn extends CheckInEvent {}
