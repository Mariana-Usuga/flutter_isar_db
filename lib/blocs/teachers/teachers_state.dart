part of 'teachers_bloc.dart';

class TeachersState extends Equatable {
  final bool loading;
  final String error;
  final bool add;
  final List<Teacher> listTeachers;
  final Teacher? selectedTeacher;

  const TeachersState({
    this.loading = false,
    this.error = '',
    this.add = false,
    this.listTeachers = const [],
    this.selectedTeacher,
  });

  TeachersState copyWith({
    bool? loading,
    String? error,
    bool? add,
    List<Teacher>? listTeachers,
    Teacher? selectedTeacher,
  }) =>
      TeachersState(
        loading: loading ?? this.loading,
        error: error ?? this.error,
        add: add ?? this.add,
        listTeachers: listTeachers ?? this.listTeachers,
        selectedTeacher: selectedTeacher ?? this.selectedTeacher,
      );

  @override
  List<Object> get props => [loading, error, add, listTeachers];
}
