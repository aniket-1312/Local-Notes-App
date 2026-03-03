import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'note_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDark ? ThemeData.dark() : ThemeData.light(),
      home: NotesPage(
        onThemeChanged: () {
          setState(() {
            isDark = !isDark;
          });
        },
        isDark: isDark,
      ),
    );
  }
}

class NotesPage extends StatefulWidget {
  final VoidCallback onThemeChanged;
  final bool isDark;

  NotesPage({required this.onThemeChanged, required this.isDark});

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  List<Note> notes = [];

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadNotes();
  }

  void loadNotes() async {
    notes = await DatabaseHelper.instance.fetchNotes();
    setState(() {});
  }

  // ---------------- VALIDATION ----------------
  bool validateInput() {
    if (titleController.text.isEmpty ||
        descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("All fields are required")),
      );
      return false;
    }
    return true;
  }

// ---------------- ADD NOTE (DIALOG STYLE) ----------------
  void showAddSheet() {
    titleController.clear();
    descriptionController.clear();

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("Add Note"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: "Title"),
              ),
              SizedBox(height: 10),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: "Description"),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: Text("Save"),
              onPressed: () async {
                if (!validateInput()) return;

                await DatabaseHelper.instance.insert(
                  Note(
                    title: titleController.text,
                    description: descriptionController.text,
                  ),
                );

                Navigator.pop(context);
                loadNotes();
              },
            ),
          ],
        );
      },
    );
  }

  // ---------------- EDIT NOTE ----------------
  void showEditDialog(Note note) {
    titleController.text = note.title;
    descriptionController.text = note.description;

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("Edit Note"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: "Title"),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: "Description"),
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel")),
            ElevatedButton(
              child: Text("Update"),
              onPressed: () async {
                if (!validateInput()) return;

                await DatabaseHelper.instance.update(
                  Note(
                    id: note.id,
                    title: titleController.text,
                    description: descriptionController.text,
                  ),
                );
                Navigator.pop(context);
                loadNotes();
              },
            ),
          ],
        );
      },
    );
  }

  // ---------------- DELETE CONFIRMATION ----------------
  void confirmDelete(int id) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("Confirm Delete"),
          content: Text("Are you sure you want to delete this note?"),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("No")),
            ElevatedButton(
              child: Text("Yes"),
              onPressed: () async {
                await DatabaseHelper.instance.delete(id);
                Navigator.pop(context);
                loadNotes();
              },
            )
          ],
        );
      },
    );
  }

  // ---------------- UI ----------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SQLite Notes App"),
        actions: [
          IconButton(
            icon: Icon(widget.isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: widget.onThemeChanged,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: showAddSheet,
      ),
      body: notes.isEmpty
          ? Center(child: Text("No Notes Available"))
          : ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];

          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Text(note.title,
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              subtitle: Text(note.description),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => showEditDialog(note),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => confirmDelete(note.id!),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}