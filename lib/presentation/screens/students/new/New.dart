import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_isar_db/blocs/courses/courses_bloc.dart';
import 'package:flutter_isar_db/blocs/students_bloc/students_bloc.dart';
import 'package:flutter_isar_db/db/entities/entities.dart';
import 'package:flutter_isar_db/presentation/widgets/widgets.dart';
import 'package:flutter_isar_db/utils/utils.dart';
import 'package:select_modal_flutter/select_modal_flutter.dart';

class NewStudentScreen extends StatefulWidget {
  const NewStudentScreen({Key? key}) : super(key: key);

  @override
  State<NewStudentScreen> createState() => _NewStudentScreenState();
}

class _NewStudentScreenState extends State<NewStudentScreen> {
  final _nameTextEditingController = TextEditingController();
  final _lastNameTextEditingController = TextEditingController();

  late bool _errorName = false;
  late bool _errorLastName = false;
  late bool _errorCourses = false;
  late CoursesBloc? coursesBloc;

  ItemSelect? _selectCourses;

  @override
  void initState() {
    super.initState();
  }

  void _save() {
    bool band = false;

    if (!Validators.validateText(_nameTextEditingController.text.trim())) {
      band = true;
      _errorName = true;
    } else {
      _errorName = false;
    }

    if (!Validators.validateText(_lastNameTextEditingController.text.trim())) {
      band = true;
      _errorLastName = true;
    } else {
      _errorLastName = false;
    }

    /*if (_selectCourses == null || _selectCourses!.isEmpty) {
      band = true;
      _errorCourses = true;
    } else {
      _errorCourses = false;
    }*/

    setState(() {});

    if (band) return;

    final student = Student()
      ..name = _nameTextEditingController.text
      ..lastName = _lastNameTextEditingController.text;

    context.read<StudentsBloc>().add(SaveStudent(student: student));
  }

  @override
  void dispose() {
    _nameTextEditingController.dispose();
    _lastNameTextEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    coursesBloc = context.read<CoursesBloc>();

    return Scaffold(
      body: ContentWidget(
        header: const HeaderWidget(
          title: 'Nuevo alumno',
        ),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextFieldWidget(
                label: 'Nombre',
                hintText: 'Nombre del alumno',
                icon: Icons.person,
                controller: _nameTextEditingController,
                error: _errorName,
              ),
              const SizedBox(height: 20.0),
              TextFieldWidget(
                label: 'Apellido',
                hintText: 'Apellido del alumno',
                icon: Icons.person,
                controller: _lastNameTextEditingController,
                error: _errorLastName,
              ),
              const SizedBox(height: 20.0),
              SelectModalFlutter(
                title: 'Cursos',
                onItemSelect: (ItemSelect value) {
                  setState(() {
                    _selectCourses = value;
                  });
                  //coursesBloc!.add(GetTeacherById(id: value.value!));
                },
                listItemSelect: coursesBloc!.state.listCourses
                    .map((course) =>
                        ItemSelect(value: course.id, label: '${course.name}'))
                    .toList(),
                boxDecoration: BoxDecoration(
                  color: _errorCourses
                      ? const Color(0xFFf8dfdc)
                      : const Color(0xFFF4F5FE),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                borderTextField: InputBorder.none,
                icon: Icons.arrow_drop_down,
                colorIcon: Theme.of(context).primaryColor,
                error: _errorCourses,
              ),
              /*MultiSelectModalFlutter(
                title: 'Cursos',
                onItemSelect: (List<ItemSelect> value) {
                  _selectCourses = value;
                },
                listItemSelect: const [],
                boxDecoration: BoxDecoration(
                  color: _errorCourses
                      ? const Color(0xFFf8dfdc)
                      : const Color(0xFFF4F5FE),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                borderTextField: InputBorder.none,
                icon: Icons.arrow_drop_down,
                colorIcon: Theme.of(context).primaryColor,
                error: _errorCourses,
                colorButtonSelect: Theme.of(context).primaryColor,
              ),*/
              ButtonWidget(onPressed: _save),
            ],
          ),
        ),
      ),
    );
  }
}
