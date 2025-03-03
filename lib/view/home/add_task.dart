import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskify/controller/AddTaskController.dart';
import 'package:taskify/utils/appColors.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  late final TextEditingController taskController;
  late final TextEditingController dateController;
  late final TextEditingController timeController;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  final GlobalKey<FormState> anFormKey = GlobalKey<FormState>();

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        dateController.text = picked.toString().split(' ')[0];
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        timeController.text = pickedTime.format(context);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    taskController = TextEditingController();
    dateController = TextEditingController();
    timeController = TextEditingController();
  }

  @override
  void dispose() {
    taskController.dispose();
    dateController.dispose();
    timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final anFormKey = GlobalKey<FormState>();
    final AddtaskController addtaskController = Get.put(AddtaskController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    color: AppColors.white,
                  ),
                ),
                const Text(
                  'Add Task',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(
                Icons.delete,
                color: AppColors.white,
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.secondaryColor,
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 12,
          right: 12,
          top: 15,
        ),
        child: Form(
          key: anFormKey,
          child: Column(
            children: [
              const Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "What is to be done?",
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColors.secondaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 1),
              TextFormField(
                controller: taskController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'Enter the task',
                ),
              ),
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Due date",
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColors.secondaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 1),
              TextFormField(
                controller: dateController,
                decoration: InputDecoration(
                  border: const UnderlineInputBorder(),
                  hintText: 'Enter the due date', // Optional hint text
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today, color: Colors.grey),
                    onPressed: () {
                      // Open date picker when the icon is clicked
                      selectDate(context);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Due date",
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColors.secondaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 1),
              TextFormField(
                controller: timeController,
                readOnly: true, // Prevent manual input
                decoration: InputDecoration(
                  border: const UnderlineInputBorder(),
                  hintText: 'Select time',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.access_time, color: Colors.grey),
                    onPressed: () {
                      _selectTime(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Obx(
                () => ElevatedButton(
                  onPressed: addtaskController.isLoading.isTrue
                      ? null
                      : () async {
                          if (anFormKey.currentState!.validate()) {
                            addtaskController.addTask(
                              taskController.text,
                              dateController.text,
                              timeController.text,
                            );
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: addtaskController.isLoading.isTrue
                      ? const CircularProgressIndicator()
                      : const Text(
                          'Add Task',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
