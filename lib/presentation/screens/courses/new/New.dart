import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_isar_db/blocs/courses/courses_bloc.dart';
import 'package:flutter_isar_db/blocs/teachers/teachers_bloc.dart';
import 'package:flutter_isar_db/db/entities/course.dart';
import 'package:flutter_isar_db/presentation/widgets/widgets.dart';
import 'package:flutter_isar_db/utils/utils.dart';
import 'package:select_modal_flutter/select_modal_flutter.dart';

class NewCourseScreen extends StatefulWidget {
  static String routeName = 'new_course';

  const NewCourseScreen({super.key});

  @override
  State<NewCourseScreen> createState() => _NewCourseScreenState();
}

class _NewCourseScreenState extends State<NewCourseScreen> {
  final _nameTextEditingController = TextEditingController();
  ItemSelect? _selectTeacher;
  late TeachersBloc? teachersBloc;

  late bool _errorName = false;
  late bool _errorTeacher = false;

  _save() {
    bool band = false;

    if (!Validators.validateText(_nameTextEditingController.text.trim())) {
      band = true;
      _errorName = true;
    } else {
      _errorName = false;
    }

    if (_selectTeacher == null) {
      band = true;
      _errorTeacher = true;
    } else {
      _errorTeacher = false;
    }

    setState(() {});

    if (band) return;

    final course = Course()
      ..name = _nameTextEditingController.text
      ..teacher.value = teachersBloc!.state.selectedTeacher;
    //..teacher = _selectTeacher!.value;

    context.read<CoursesBloc>().add(SaveCourse(course: course));
  }

  @override
  void dispose() {
    _nameTextEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    teachersBloc = context.read<TeachersBloc>();
    return Scaffold(
      body: ContentWidget(
        header: const HeaderWidget(
          title: 'Nuevo curso',
        ),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextFieldWidget(
                label: 'Nombre',
                hintText: 'Nombre del curso',
                icon: Icons.file_copy,
                controller: _nameTextEditingController,
                error: _errorName,
              ),
              const SizedBox(height: 20.0),
              SelectModalFlutter(
                title: 'Profesor',
                onItemSelect: (ItemSelect value) {
                  setState(() {
                    _selectTeacher = value;
                  });
                  teachersBloc!.add(GetTeacherById(id: value.value!));
                },
                listItemSelect: teachersBloc!.state.listTeachers
                    .map((teacher) => ItemSelect(
                        value: teacher.id,
                        label: '${teacher.name} ${teacher.lastName}'))
                    .toList(),
                boxDecoration: BoxDecoration(
                  color: _errorTeacher
                      ? const Color(0xFFf8dfdc)
                      : const Color(0xFFF4F5FE),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                borderTextField: InputBorder.none,
                icon: Icons.arrow_drop_down,
                colorIcon: Theme.of(context).primaryColor,
                error: _errorTeacher,
              ),
              ButtonWidget(onPressed: _save),
            ],
          ),
        ),
      ),
    );
  }
}
