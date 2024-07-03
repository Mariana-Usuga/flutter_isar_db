import 'package:flutter/material.dart';
import 'package:flutter_isar_db/db/entities/course.dart';
import 'package:flutter_isar_db/db/entities/entities.dart';
import 'package:flutter_isar_db/presentation/widgets/widgets.dart';

class CourseDetailScreen extends StatelessWidget {
  final Course course;
  const CourseDetailScreen({required this.course, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ContentWidget(
        header: const HeaderWidget(
          title: 'Detalle de curso',
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _infoCourse(context, course),
            const SizedBox(height: 20.0),
            Text(
              'Lista de Alumnos',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 20.0,
              ),
            ),
            Expanded(
                child: ListView.separated(
              itemBuilder: (context, index) {
                final Student cours = course.students.elementAt(index);
                return ListTile(title: Text(cours.name!));
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: course.students.length,
            ))
            /*Expanded(
              child: ListView.separated(
                itemCount: 2,
                itemBuilder: (context, index) {
                  return const ListTile(
                    title: Text('Alumno Apellido'),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
              ),
            )*/
          ],
        ),
      ),
    );
  }

  Container _infoCourse(BuildContext context, Course course) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFEFFFF),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(.1),
            offset: const Offset(.1, 1),
            blurRadius: 10.0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              RichText(
                text: TextSpan(
                  text:
                      'Profesor: ${course.teacher.value!.name} ${course.teacher.value!.lastName}',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                  children: [],
                ),
              ),
              const SizedBox(height: 10.0),
              RichText(
                text: TextSpan(
                  text: 'Curso: ${course.name}',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
