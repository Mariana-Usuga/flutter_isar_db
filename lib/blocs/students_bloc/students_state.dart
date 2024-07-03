part of 'students_bloc.dart';

class StudentsState extends Equatable {
  final bool loading;
  final String error;
  final bool add;
  final List<Student> listStudents;

  const StudentsState({
    this.loading = false,
    this.error = '',
    this.add = false,
    this.listStudents = const [],
  });

  StudentsState copyWith({
    bool? loading,
    String? error,
    bool? add,
    List<Student>? listStudents,
  }) =>
      StudentsState(
        loading: loading ?? this.loading,
        error: error ?? this.error,
        add: add ?? this.add,
        listStudents: listStudents ?? this.listStudents,
      );

  @override
  List<Object> get props => [loading, error, add, listStudents];
}
