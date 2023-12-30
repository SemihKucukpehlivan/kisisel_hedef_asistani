import 'package:flutter/material.dart';
import 'package:kisisel_hedef_asistani/widgets/dropDownMenu.dart';
import 'package:kisisel_hedef_asistani/widgets/slider.dart';
import 'package:kisisel_hedef_asistani/widgets/textInputContainer.dart';

class CreateTodoScreen extends StatefulWidget {
  const CreateTodoScreen({Key? key}) : super(key: key);

  @override
  State<CreateTodoScreen> createState() => _CreateTodoScreenState();
}

class _CreateTodoScreenState extends State<CreateTodoScreen> {
  TextEditingController titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Events Page")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextInputContainer(
                  label: "Title",
                  controller: titleController,
                  hintText: "Please enter title"),
              const SizedBox(height: 10),
              TextInputContainer(
                  label: "Description",
                  controller: titleController,
                  hintText: "Please enter Description"),
              const SizedBox(height: 10),
              const DropDownMenuWidgets(),
              const SizedBox(height: 10),
              const SliderWidget(),
              ElevatedButton(
                onPressed: () {},
                child: Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
