import 'package:flutter/material.dart';
import 'package:note_sphere_app/helpers/helpers.dart';
import 'package:note_sphere_app/models/note_model.dart';
import 'package:note_sphere_app/services/note_service.dart';
import 'package:note_sphere_app/utils/constants.dart';
import 'package:note_sphere_app/utils/router.dart';
import 'package:note_sphere_app/utils/text_styles.dart';
import 'package:note_sphere_app/widgets/note_category_card.dart';

class NotesByCategory extends StatefulWidget {
  final String category;
  const NotesByCategory({
    super.key,
    required this.category,
  });

  @override
  State<NotesByCategory> createState() => _NotesByCategoryState();
}

class _NotesByCategoryState extends State<NotesByCategory> {
  final NoteService noteService = NoteService();
  List<Note> noteList = [];

  @override
  void initState() {
    super.initState();
    _loadNotesByCategory();
  }

  //load all notes by category
  Future<void> _loadNotesByCategory() async {
    final noteService = NoteService();
    noteList = await noteService.getNotesByCategory(widget.category);
    print(noteList);
    setState(() {
      print(noteList);
    });
  }

  //edit note
  void _editNote(Note note) {
    AppRouter.router.push("/edit-note", extra: note);
  }

  //remove note
  Future<void> _removeNote(String id) async {
    try {
      await noteService.deleteNote(id);
      if (context.mounted) {
        AppHelpers.showSnackBar(context, "Note deleted successfully");
      }
    } catch (e) {
      if (context.mounted) {
        AppHelpers.showSnackBar(context, "An error occurred");
      }
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            //go to the notes page
            AppRouter.router.push("/notes");
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(widget.category),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                widget.category,
                style: AppTextStyles.appTitle,
              ),
              const SizedBox(
                height: 20,
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: AppConstants.kDefaultPadding,
                  mainAxisSpacing: AppConstants.kDefaultPadding,
                  childAspectRatio: 7 / 11,
                ),
                itemCount: noteList.length,
                itemBuilder: (context, index) {
                  return NoteCategoryCard(
                    noteTitle: noteList[index].title,
                    noteContent: noteList[index].content,
                    removeNote: () async {
                      await _removeNote(noteList[index].id);
                      setState(() {
                        noteList.removeAt(index);
                      });
                    },
                    editNote: () async {
                      _editNote(noteList[index]);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
