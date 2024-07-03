part of 'students_bloc.dart';

abstract class StudentsEvent extends Equatable {
  const StudentsEvent();

  @override
  List<Object> get props => [];
}

class InitStudents extends StudentsEvent {}

class GetAllStudents extends StudentsEvent {}

class SaveStudent extends StudentsEvent {
  final Student student;

  const SaveStudent({required this.student});
}
