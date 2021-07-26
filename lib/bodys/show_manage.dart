import 'package:flutter/material.dart';
import 'package:saraburialro/utility/my_constant.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:saraburialro/db/notes_database.dart';
import 'package:saraburialro/models/note.dart';
import 'package:saraburialro/pages/edit_note_page.dart';
import 'package:saraburialro/pages/note_detail_page.dart';
import 'package:saraburialro/widgets/note_card_widget.dart';

class ShowManage extends StatefulWidget {
  const ShowManage({Key? key}) : super(key: key);

  @override
  _ShowManageState createState() => _ShowManageState();
}

class _ShowManageState extends State<ShowManage> {
    late List<Note> notes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  @override
  void dispose() {
    NotesDatabase.instance.close();

    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    this.notes = await NotesDatabase.instance.readAllNotes();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : notes.isEmpty
                  ? Text(
                      'ไม่มีข้อมูล',
                      style: TextStyle(color: Color(0xffb9b64e), fontSize: 24),
                    )
                  : buildNotes(),
        ),
       floatingActionButton: FloatingActionButton(
          backgroundColor: MyConstant.dark,
          child: Icon(Icons.add),
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AddEditNotePage()),
            );

            refreshNotes();
          },
        ),
    );
  }
   Widget buildNotes() => StaggeredGridView.countBuilder(
        padding: EdgeInsets.all(8),
        itemCount: notes.length,
        staggeredTileBuilder: (index) => StaggeredTile.fit(2),
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          final note = notes[index];

          return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NoteDetailPage(noteId: note.id!),
              ));

              refreshNotes();
            },
            child: NoteCardWidget(note: note, index: index),
          );
        },
      ); 
}

