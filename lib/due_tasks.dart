import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final _formKey = GlobalKey<FormState>();

  final SupabaseClient supabase = Supabase.instance.client;

  final TextEditingController _controller = TextEditingController();

  late final Stream<List<Map<String, dynamic>>> _notesStream;

  @override
  void initState() {
    super.initState();

    final user = supabase.auth.currentUser;

    _notesStream = supabase
        .from('notes')
        .stream(primaryKey: ['id'])
        .eq('uuid', user?.id ?? '');
  }

  // CREATE
  Future<void> _addNote() async {
    try {
      final user = supabase.auth.currentUser;

      if (user == null) {
        mySnackBar(context, "User not logged in");
        return;
      }

      await supabase.from('notes').insert({
        'body': _controller.text,
        'uuid': user.id,
      });

      mySnackBar(context, "Note added");
      _controller.clear();
    } catch (e) {
      mySnackBar(context, e.toString());
    }
  }

  // UPDATE
  Future<void> _updateNote(int noteId, String newContent) async {
    try {
      await supabase.from('notes').update({
        'body': newContent,
      }).eq('id', noteId);

      mySnackBar(context, "Note updated");
      _controller.clear();
    } catch (e) {
      mySnackBar(context, e.toString());
    }
  }

  // DELETE
  Future<void> _deleteNote(int noteId) async {
    try {
      await supabase.from('notes').delete().eq('id', noteId);

      mySnackBar(context, "Note deleted");
    } catch (e) {
      mySnackBar(context, e.toString());
    }
  }

  // SNACKBAR
  void mySnackBar(BuildContext context, String content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = supabase.auth.currentUser;

    // Prevent null crash on web/chrome
    if (user == null) {
      return const Scaffold(
        body: Center(
          child: Text("User not logged in"),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Due Tasks"),
        backgroundColor: Colors.redAccent,
      ),

      // ADD NOTE BUTTON
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _controller.clear();

          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Add Note"),
                content: Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Enter note",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Field cannot be empty";
                      }
                      return null;
                    },
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await _addNote();
                        Navigator.pop(context);
                      }
                    },
                    child: const Text("Add"),
                  ),
                ],
              );
            },
          );
        },
      ),

      // READ NOTES
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _notesStream,
        builder: (context, snapshot) {
          // LOADING
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("No data found!!!"),
            );
          }

          final notes = snapshot.data!;

          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              return Card(
                color: const Color.fromARGB(255, 244, 127, 54),
                margin: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          notes[index]['body'] ?? '',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),

                      Row(
                        children: [
                          // EDIT
                          IconButton(
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              _controller.text =
                                  notes[index]['body'] ?? '';

                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title:
                                        const Text("Update Note"),
                                    content: Form(
                                      key: _formKey,
                                      child: TextFormField(
                                        controller: _controller,
                                        validator: (value) {
                                          if (value == null ||
                                              value.isEmpty) {
                                            return "Field cannot be empty";
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child:
                                            const Text("Cancel"),
                                      ),
                                      ElevatedButton(
                                        onPressed: () async {
                                          if (_formKey
                                              .currentState!
                                              .validate()) {
                                            await _updateNote(
                                              notes[index]['id'],
                                              _controller.text,
                                            );

                                            Navigator.pop(
                                                context);
                                          }
                                        },
                                        child:
                                            const Text("Update"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),

                          // DELETE
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text(
                                        "Are you sure?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child:
                                            const Text("No"),
                                      ),
                                      ElevatedButton(
                                        onPressed: () async {
                                          await _deleteNote(
                                            notes[index]['id'],
                                          );

                                          Navigator.pop(
                                              context);
                                        },
                                        child:
                                            const Text("Yes"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}