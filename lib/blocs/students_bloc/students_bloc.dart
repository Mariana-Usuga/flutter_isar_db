import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_isar_db/db/entities/student.dart';
import 'package:flutter_isar_db/db/services/students.dart';

part 'students_event.dart';
part 'students_state.dart';

class StudentsBloc extends Bloc<StudentsEvent, StudentsState> {
  StudentServices teacherService = StudentServices();

  StudentsBloc() : super(StudentsState()) {
    on<StudentsEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<InitStudents>((event, emit) =>
        emit(state.copyWith(loading: false, add: false, error: '')));

    on<GetAllStudents>(((event, emit) async {
      emit(state.copyWith(loading: true));

      final resp = await teacherService.getAllStudents();
      emit(state.copyWith(loading: false, listStudents: resp));
    }));

    on<SaveStudent>(((event, emit) async {
      try {
        emit(state.copyWith(loading: true));

        await teacherService.saveStudent(event.student);
        emit(state.copyWith(loading: false, add: true));
      } catch (error) {
        try {
          if (error.toString().contains('Unique index violated.')) {
            emit(state.copyWith(
                loading: false, error: 'Correo ya registrado!!'));
          }
        } catch (e) {
          emit(state.copyWith(loading: false, error: 'Ocurrió un error'));
        }
      }
    }));
  }
}
