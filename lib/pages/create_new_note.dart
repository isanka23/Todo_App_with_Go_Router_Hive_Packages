import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_sphere_app/helpers/helpers.dart';
import 'package:note_sphere_app/models/note_model.dart';
import 'package:note_sphere_app/services/note_service.dart';
import 'package:note_sphere_app/utils/colors.dart';
import 'package:note_sphere_app/utils/constants.dart';
import 'package:note_sphere_app/utils/router.dart';
import 'package:note_sphere_app/utils/text_styles.dart';
import 'package:uuid/uuid.dart';

class CreateNotePage extends StatefulWidget {
  final bool isNewCategory;

  const CreateNotePage({
    super.key,
    required this.isNewCategory,
  });

  @override
  State<CreateNotePage> createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  List<String> categories = [];
  final NoteService noteService = NoteService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _noteTitleController = TextEditingController();
  final TextEditingController _noteContentController = TextEditingController();
  final TextEditingController _noteCategoryController = TextEditingController();
  String category = "";

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  @override
  void dispose() {
    _noteTitleController.dispose();
    _noteContentController.dispose();
    _noteCategoryController.dispose();
    super.dispose();
  }

  Future _loadCategories() async {
    categories = await noteService.getAllCategories();
    setState(() {
      print(categories.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Note",
          style: AppTextStyles.appSubTitle,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    //drop down
                    widget.isNewCategory
                        ? Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              controller: _noteCategoryController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Category cannot be empty";
                                }
                                return null;
                              },
                              style: TextStyle(
                                color: AppColors.kWhiteColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: InputDecoration(
                                hintText: "New Category",
                                hintStyle: TextStyle(
                                  color: AppColors.kWhiteColor.withOpacity(0.5),
                                  fontFamily: GoogleFonts.dmSans().fontFamily,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    color:
                                        AppColors.kWhiteColor.withOpacity(0.1),
                                    width: 2,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    AppConstants.kDefaultPadding,
                                  ),
                                  borderSide: BorderSide(
                                    color: AppColors.kWhiteColor,
                                    width: 1,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: DropdownButtonFormField<String>(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Category cannot be empty";
                                }
                                return null;
                              },
                              style: TextStyle(
                                color: AppColors.kWhiteColor,
                                fontFamily: GoogleFonts.dmSans().fontFamily,
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                              isExpanded: false,
                              hint: const Text(
                                "Select Category",
                              ),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    color:
                                        AppColors.kWhiteColor.withOpacity(0.1),
                                    width: 2,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    AppConstants.kDefaultPadding,
                                  ),
                                  borderSide: BorderSide(
                                    color: AppColors.kWhiteColor,
                                    width: 1,
                                  ),
                                ),
                              ),
                              items: categories.map((String category) {
                                return DropdownMenuItem<String>(
                                  value: category,
                                  alignment: Alignment.center,
                                  child: Text(
                                    category,
                                    style: AppTextStyles.appButton,
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  category = value!;
                                });
                              },
                            ),
                          ),
                    const SizedBox(
                      height: 10,
                    ),
                    //title
                    TextFormField(
                      controller: _noteTitleController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Title cannot be empty";
                        }
                        return null;
                      },
                      maxLines: 2,
                      style: TextStyle(
                        color: AppColors.kWhiteColor,
                        fontSize: 30,
                      ),
                      decoration: InputDecoration(
                        hintText: "Note Title",
                        hintStyle: TextStyle(
                          color: AppColors.kWhiteColor.withOpacity(0.5),
                          fontSize: 35,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //content
                    TextFormField(
                      controller: _noteContentController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Content cannot be empty";
                        }
                        return null;
                      },
                      maxLines: 12,
                      style: TextStyle(
                        color: AppColors.kWhiteColor,
                        fontSize: 20,
                      ),
                      decoration: InputDecoration(
                        hintText: "Note Content",
                        hintStyle: TextStyle(
                          color: AppColors.kWhiteColor.withOpacity(0.5),
                          fontSize: 20,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Divider(
                      color: AppColors.kWhiteColor.withOpacity(0.2),
                      thickness: 1,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: const ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              AppColors.kFabColor,
                            ),
                          ),
                          onPressed: () {
                            //save note
                            if (_formKey.currentState!.validate()) {
                              try {
                                noteService.addNote(
                                  Note(
                                    title: _noteTitleController.text,
                                    category: widget.isNewCategory
                                        ? _noteCategoryController.text
                                        : category,
                                    content: _noteContentController.text,
                                    date: DateTime.now(),
                                    id: const Uuid().v4(),
                                  ),
                                );
                                //show snackbar
                                AppHelpers.showSnackBar(
                                  context,
                                  "Note saved successfully",
                                );
                                //clear the form
                                _noteTitleController.clear();
                                _noteContentController.clear();
                                AppRouter.router.push("/notes");
                              } catch (e) {
                                print(e);
                                AppHelpers.showSnackBar(
                                  context,
                                  "An error occurred",
                                );
                              }
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "Save Note",
                              style: AppTextStyles.appButton,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
