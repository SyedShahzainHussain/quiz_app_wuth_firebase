// ignore_for_file: use_build_context_synchronously

import 'package:quiz_app_with_firebase/admin/view/add_quiz/add_quiz_screen.dart';
import 'package:quiz_app_with_firebase/admin/view_model/upload_subject_view_model.dart';
import 'package:quiz_app_with_firebase/config/components/input_field_widget.dart';

import 'package:quiz_app_with_firebase/config/components/rounded_button_widget.dart';
import 'package:quiz_app_with_firebase/config/helper/helper_function.dart';
import 'dart:io';

import 'package:quiz_app_with_firebase/view/intro/intro.dart';

class AddSubjectScreen extends StatefulWidget {
  const AddSubjectScreen({super.key});

  @override
  State<AddSubjectScreen> createState() => _AddSubjectScreenState();
}

class _AddSubjectScreenState extends State<AddSubjectScreen> {
  late TextEditingController titleController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
  }

  File? image;

  Future<void> save() async {
    HelperFunction.hideKeyboard(context);
    if (titleController.text.isEmpty || image == null) {
      HelperFunction.showSnackbar("All Field Required!", context);
    } else {
      final titleExists =
          await Provider.of<UploadSubjectViewModel>(context, listen: false)
              .checkTitleExists(
        title: titleController.text,
      );
      if (!titleExists) {
        if (context.mounted) {
          Provider.of<UploadSubjectViewModel>(context, listen: false)
              .uploadSubject(
                  file: image!,
                  context: context,
                  title: titleController.text.trim().replaceAll(" ", ""))
              .then((value) {
            setState(() {
              image = null;
              titleController.clear();
            });
          });
        }
      } else {
        if (context.mounted) {
          HelperFunction.showSnackbar("This Subject Already Exists", context);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        title: "Add Subject",
        action: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const AddQuizScreen()));
              },
              icon: const Icon(Icons.quiz))
        ],
      ),
      body: LinearGradientWidget(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              InputField(
                controller: titleController,
                title: "Title",
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 100,
                width: double.infinity,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12.0),
                    onTap: () {
                      HelperFunction.showBottomSheet(context, () async {
                        HelperFunction.hideKeyboard(context);
                        image = await HelperFunction.pickImageFromCamera();
                        setState(() {});
                      }, () async {
                        HelperFunction.hideKeyboard(context);
                        image = await HelperFunction.pickImageFromGallery();
                        setState(() {});
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.black!),
                          borderRadius: BorderRadius.circular(12.0),
                          image: image != null
                              ? DecorationImage(
                                  image: FileImage(File(image!.path)),
                                  fit: BoxFit.cover)
                              : null),
                      child: image == null
                          ? const Center(
                              child: Icon(Icons.image),
                            )
                          : const SizedBox(),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Consumer<UploadSubjectViewModel>(
                builder: (context, value, _) => RoundedButtonWidget(
                    isLoading: value.isLoading,
                    title: "Submit",
                    onPressed: () {
                      save();
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
