import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBGw7isRVMuspAMLV--oXjFg_jhSVwJQnI",
      appId: "1:1095085352600:android:7728583faee211ccdf52ed",
      messagingSenderId: "1095085352600",
      projectId: "flutter-assignment3-93642",
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const MyFS(), debugShowCheckedModeBanner: false);
  }
}

class MyFS extends StatefulWidget {
  const MyFS({super.key});

  @override
  State<MyFS> createState() => _MyFSState();
}

class _MyFSState extends State<MyFS> {
  final CollectionReference tasks = FirebaseFirestore.instance.collection(
    'Tasks',
  );

  Future<void> addTask(String newTask) async {
    if (newTask.isNotEmpty) {
      await tasks.add({'title': newTask, "isDone": false});
    }
  }

  void updateTask(String id, bool currentTask) {
    tasks.doc(id).update({"isDone": !currentTask});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        elevation: 0,
        title: const Text(
          'Todoey',
          style: TextStyle(
            fontSize: 45,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlueAccent,
        child: const Icon(Icons.add, size: 30, color: Colors.white),
        onPressed: () {
          String newTask = "";
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            ),
            builder: (_) => Padding(
              padding: EdgeInsets.only(
                // to change the place of button
                bottom: MediaQuery.of(context).viewInsets.bottom,
                top: 30,
                left: 30,
                right: 30,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Add Task",
                    style: TextStyle(
                      color: Colors.lightBlueAccent,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    onChanged: (value) => newTask = value,
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      hintText: "Type your task",
                      hintStyle: TextStyle(color: Colors.grey),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.lightBlueAccent,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlueAccent,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        addTask(newTask);
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Add ",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          StreamBuilder<QuerySnapshot>(
            stream: tasks.snapshots(),
            builder: (context, snapshot) {
              int counter = snapshot.hasData ? snapshot.data!.docs.length : 0;
              return Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "$counter Tasks",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),
              child: StreamBuilder<QuerySnapshot>(
                stream: tasks.snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final taskDocs = snapshot.data!.docs;
                  return ListView.builder(
                    padding: const EdgeInsets.only(top: 20),
                    itemCount: taskDocs.length,
                    itemBuilder: (context, index) {
                      final doc = taskDocs[index];
                      return CheckboxListTile(
                        activeColor: Colors.blueAccent,
                        title: Text(
                          doc["title"],
                          style: TextStyle(
                            fontSize: 18,
                            // add a cross on the task only when isDone is true
                            decoration: doc["isDone"]
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        value: doc["isDone"],
                        onChanged: (value) {
                          updateTask(doc.id, doc["isDone"]);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
