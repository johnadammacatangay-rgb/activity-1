import 'package:flutter/material.dart';
import '../models/student_model.dart';
import '../db/db_helper.dart';

class StudentListScreen extends StatefulWidget {
  @override
  _StudentListScreenState createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  late Future<List<Student>> students;

  @override
  void initState() {
    super.initState();
    students = DBHelper.getStudents();
  }

  void _refreshStudents() {
    setState(() {
      students = DBHelper.getStudents();
    });
  }

  void _showStudentDialog({Student? student}) {
    final nameController = TextEditingController(text: student?.name ?? '');
    final ageController =
        TextEditingController(text: student?.age.toString() ?? '');

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(student == null ? 'Add Student' : 'Edit Student'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: ageController,
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: Text(student == null ? 'Add' : 'Save'),
            onPressed: () async {
              final name = nameController.text;
              final age = int.tryParse(ageController.text) ?? 0;
              if (student == null) {
                await DBHelper.insertStudent(Student(name: name, age: age));
              } else {
                await DBHelper.updateStudent(
                    Student(id: student.id, name: name, age: age));
              }
              Navigator.pop(context);
              _refreshStudents();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Student Management')),
      body: FutureBuilder<List<Student>>(
        future: students,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final studentList = snapshot.data!;
          return ListView.builder(
            itemCount: studentList.length,
            itemBuilder: (context, index) {
              final student = studentList[index];
              return ListTile(
                title: Text(student.name),
                subtitle: Text('Age: ${student.age}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.orange),
                      onPressed: () => _showStudentDialog(student: student),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        await DBHelper.deleteStudent(student.id!);
                        _refreshStudents();
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showStudentDialog(),
      ),
    );
  }
}
