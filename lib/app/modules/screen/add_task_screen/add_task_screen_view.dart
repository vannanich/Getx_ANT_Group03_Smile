// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/core/themes/app_colors.dart';
import 'package:get/get.dart';

part 'add_task_screen_binding.dart';
part 'add_task_screen_controller.dart';

class AddTaskScreenView extends GetView<AddTaskScreenViewController> {
  const AddTaskScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0EDF9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(0xFFF0EDF9),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.arrow_back_ios_new_rounded,
                color: Color(0xFF6C3CE1), size: 18),
          ),
        ),
        title: Text(
          'Add new task',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2D2D2D),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0.7),
          child: Container(color: Colors.black, height: 0.7),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _FieldLabel(label: 'Title'),
            _TaskTextField(
              controller: controller.titleController,
              hint: 'Task title',
              autofocus: true,
            ),
            SizedBox(height: 4),
            _FieldLabel(label: 'Description'),
            _TaskTextField(
              controller: controller.descController,
              hint: 'What do you need to do?',
              maxLines: 4,
            ),
            SizedBox(height: 4),
            _FieldLabel(label: 'Priority'),
            _PrioritySelector(controller: controller),
            SizedBox(height: 4),
            _FieldLabel(label: 'Due date & time'),
            _DateTimeRow(controller: controller),
            SizedBox(height: 4),
            _FieldLabel(label: 'Tags'),
            _TagsRow(controller: controller),
            SizedBox(height: 24),
            _PrimaryButton(
              label: 'Add task',
              onTap: controller.addTask,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String label;
  const _FieldLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: Colors.grey,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

class _TaskTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final int maxLines;
  final bool autofocus;

  const _TaskTextField({
    required this.controller,
    required this.hint,
    this.maxLines = 1,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        autofocus: autofocus,
        maxLines: maxLines,
        style: TextStyle(fontSize: 14, color: Color(0xFF2D2D2D)),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
          contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.secondary, width: 1.5),
          ),
        ),
      ),
    );
  }
}

class _PrioritySelector extends GetView<AddTaskScreenViewController> {
  const _PrioritySelector({required AddTaskScreenViewController controller})
      : super();

  @override
  AddTaskScreenViewController get controller =>
      Get.find<AddTaskScreenViewController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Row(
            children: Priority.values
                .map((p) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: GestureDetector(
                        onTap: () => controller.selectedPriority.value = p,
                        child: _PriorityChip(
                          priority: p,
                          selected: controller.selectedPriority.value == p,
                        ),
                      ),
                    ))
                .toList(),
          ),
        ));
  }
}

class _PriorityChip extends StatelessWidget {
  final Priority priority;
  final bool selected;
  const _PriorityChip({required this.priority, required this.selected});

  @override
  Widget build(BuildContext context) {
    final colors = _priorityColors(priority);
    return AnimatedContainer(
      duration: Duration(milliseconds: 180),
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: selected ? colors.activeColor : colors.bgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: selected ? colors.activeColor : colors.borderColor,
          width: 1.5,
        ),
      ),
      child: Text(
        priority.label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: selected ? Colors.white : colors.textColor,
        ),
      ),
    );
  }
}

class _DateTimeRow extends GetView<AddTaskScreenViewController> {
  const _DateTimeRow({required AddTaskScreenViewController controller})
      : super();

  @override
  AddTaskScreenViewController get controller =>
      Get.find<AddTaskScreenViewController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
          onTap: () => controller.pickDateTime(context),
          child: Container(
            margin: EdgeInsets.only(bottom: 14),
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color(0xFFD8D0F5), width: 1.5),
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today_rounded,
                    color: Color(0xFF6C3CE1), size: 18),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    controller.formattedDate,
                    style: TextStyle(fontSize: 14, color: Color(0xFF2D2D2D)),
                  ),
                ),
                Text(
                  controller.formattedTime,
                  style: TextStyle(fontSize: 13, color: Color(0xFF7B6FA0)),
                ),
                SizedBox(width: 6),
                Icon(Icons.keyboard_arrow_down_rounded,
                    color: Color(0xFF9E9E9E), size: 20),
              ],
            ),
          ),
        ));
  }
}

class _TagsRow extends GetView<AddTaskScreenViewController> {
  const _TagsRow({required AddTaskScreenViewController controller}) : super();

  @override
  AddTaskScreenViewController get controller =>
      Get.find<AddTaskScreenViewController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              ...controller.tags.map((tag) => _TagChip(
                    label: tag,
                    onRemove: () => controller.removeTag(tag),
                  )),
              GestureDetector(
                onTap: () => controller.showAddTagDialog(),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: Color(0xFFF0EDF9),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: Color(0xFFD8D0F5),
                        width: 1.5,
                        style: BorderStyle.solid),
                  ),
                  child: Text('+ Add',
                      style: TextStyle(fontSize: 12, color: Color(0xFF9E9E9E))),
                ),
              ),
            ],
          ),
        ));
  }
}

class _TagChip extends StatelessWidget {
  final String label;
  final VoidCallback onRemove;
  const _TagChip({required this.label, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: Color(0xFFEEEDFE),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF534AB7),
                  fontWeight: FontWeight.w500)),
          SizedBox(width: 4),
          GestureDetector(
            onTap: onRemove,
            child:
                Icon(Icons.close_rounded, size: 14, color: Color(0xFF534AB7)),
          ),
        ],
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _PrimaryButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondary,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          elevation: 0,
        ),
        child: Text(label,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.white)),
      ),
    );
  }
}

class _OutlineButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _OutlineButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          side: const BorderSide(color: Color(0xFF6C3CE1), width: 1.5),
        ),
        child: Text(label,
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Color(0xFF6C3CE1))),
      ),
    );
  }
}

enum Priority { high, medium, low }

extension PriorityExt on Priority {
  String get label {
    switch (this) {
      case Priority.high:
        return 'High';
      case Priority.medium:
        return 'Medium';
      case Priority.low:
        return 'Low';
    }
  }
}

class _PriorityColors {
  final Color bgColor;
  final Color borderColor;
  final Color textColor;
  final Color activeColor;
  const _PriorityColors(
      {required this.bgColor,
      required this.borderColor,
      required this.textColor,
      required this.activeColor});
}

_PriorityColors _priorityColors(Priority p) {
  switch (p) {
    case Priority.high:
      return _PriorityColors(
        bgColor: Color(0xFFFDECEC),
        borderColor: Color(0xFFF5B5B5),
        textColor: Color(0xFFC0392B),
        activeColor: Color(0xFFE74C3C),
      );
    case Priority.medium:
      return _PriorityColors(
        bgColor: Color(0xFFFFF4E0),
        borderColor: Color(0xFFF5D49A),
        textColor: Color(0xFFB36A00),
        activeColor: Color(0xFFE67E22),
      );
    case Priority.low:
      return _PriorityColors(
        bgColor: Color(0xFFEAF8EE),
        borderColor: Color(0xFFA8E0B8),
        textColor: Color(0xFF1A7F3C),
        activeColor: Color(0xFF27AE60),
      );
  }
}
