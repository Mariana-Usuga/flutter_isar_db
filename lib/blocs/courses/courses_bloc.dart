import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_isar_db/db/entities/entities.dart';
import 'package:flutter_isar_db/db/services/courses.dart';

part 'courses_event.dart';
part 'courses_state.dart';

class CoursesBloc extends Bloc<CoursesEvent, CoursesState> {
  CourseServices courseServices = CourseServices();

  CoursesBloc() : super(const CoursesState()) {
    on<CoursesEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<InitCourses>((event, emit) =>
        emit(state.copyWith(loading: false, add: false, error: '')));

    on<GetAllCourses>(((event, emit) async {
      emit(state.copyWith(loading: true));

      final resp = await courseServices.getAllCourses();
      emit(state.copyWith(loading: false, listCourses: resp));
    }));
    on<SaveCourse>(((event, emit) async {
      try {
        emit(state.copyWith(loading: true));

        await courseServices.saveCourse(event.course);
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
