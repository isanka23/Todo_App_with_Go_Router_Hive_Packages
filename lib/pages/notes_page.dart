import 'package:flutter/material.dart';
import 'package:note_sphere_app/models/note_model.dart';
import 'package:note_sphere_app/services/note_service.dart';
import 'package:note_sphere_app/utils/colors.dart';
import 'package:note_sphere_app/utils/constants.dart';
import 'package:note_sphere_app/utils/router.dart';
import 'package:note_sphere_app/utils/text_styles.dart';
import 'package:note_sphere_app/widgets/bottom_sheet.dart';
import 'package:note_sphere_app/widgets/notes_card.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final NoteService noteService = NoteService();
  List<Note> allNotes = [];
  Map<String, List<Note>> notesWithCategory = {};

  @override
  void initState() {
    super.initState();
    _checkIsUserIsNew();
  }

  //Method to check if the user is new
  void _checkIsUserIsNew() async {
    final bool isNewUser = await noteService.isNewUser();

    //If the user is new, create the initial notes
    if (isNewUser) {
      await noteService.createInitialNotes();
    }

    //load notes
    _loadNotes();
  }

  //Method to load notes
  Future<void> _loadNotes() async {
    final List<Note> loadedNotes = await noteService.loadNotes();
    final Map<String, List<Note>> notesByCategory =
        noteService.getNotesByCategoryMap(loadedNotes);
    setState(() {
      allNotes = loadedNotes;
      notesWithCategory = notesByCategory;
      print(notesWithCategory);
    });
  }

  //open bottom sheet
  void openBottomSheet() {
    showModalBottomSheet(
      barrierColor: Colors.black.withOpacity(0.7),
      context: context,
      builder: (context) {
        return CategoryInputBottomSheet(
          onNewNote: () {
            Navigator.pop(context);
            AppRouter.router.push("/create-note", extra: false);
          },
          onNewCategory: () {
            Navigator.pop(context);
            AppRouter.router.push("/create-note", extra: true);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            AppRouter.router.go("/");
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openBottomSheet,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
          side: BorderSide(
            color: AppColors.kWhiteColor,
            width: 2,
          ),
        ),
        child: Icon(
          Icons.add,
          color: AppColors.kWhiteColor,
          size: 30,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Notes Page",
              style: AppTextStyles.appTitle,
            ),
            const SizedBox(
              height: 30,
            ),
            allNotes.isEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Center(
                      child: Text(
                        "No notes available",
                        style: AppTextStyles.appTitle,
                      ),
                    ),
                  )
                : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: AppConstants.kDefaultPadding,
                      mainAxisSpacing: AppConstants.kDefaultPadding,
                      childAspectRatio: 6 / 4,
                    ),
                    itemCount: notesWithCategory.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          //Navigate to notes by category
                          AppRouter.router.push(
                            "/category",
                            extra: notesWithCategory.keys.elementAt(index),
                          );
                        },
                        child: NotesCard(
                          notesCategory:
                              notesWithCategory.keys.elementAt(index),
                          noOfNotes:
                              notesWithCategory.values.elementAt(index).length,
                        ),
                      );
                    },
                  )
          ],
        ),
      ),
    );
  }
}
