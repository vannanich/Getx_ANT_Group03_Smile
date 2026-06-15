import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'update_task_screen_binding.dart';
part 'update_task_screen_controller.dart';

class UpdateTaskScreenView extends GetView<UpdateTaskScreenViewController> {
  const UpdateTaskScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0EDF9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xFFF0EDF9),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Color(0xFF6C3CE1), size: 18),
          ),
        ),
        title: const Text(
          'Edit task',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2D2D2D),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () =>
                Get.find<UpdateTaskScreenViewController>().showDeleteDialog(),
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: Color(0xFFFDECEC),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.delete_outline_rounded,
                  color: Color(0xFFC0392B), size: 20),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.5),
          child: Container(color: const Color(0xFFEEEBF8), height: 0.5),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _FieldLabel(label: 'Title'),
            _TaskTextField(
              controller: controller.titleController,
              hint: 'Task title',
            ),
            const SizedBox(height: 4),
            const _FieldLabel(label: 'Description'),
            _TaskTextField(
              controller: controller.descController,
              hint: 'What do you need to do?',
              maxLines: 4,
            ),
            const SizedBox(height: 4),
            const _FieldLabel(label: 'Status'),
            const _StatusSelector(),
            const SizedBox(height: 4),
            const _FieldLabel(label: 'Priority'),
            const _PrioritySelector(),
            const SizedBox(height: 4),
            const _FieldLabel(label: 'Due date & time'),
            const _DateTimeRow(),
            const SizedBox(height: 4),
            const _FieldLabel(label: 'Tags'),
            const _TagsRow(),
            const SizedBox(height: 24),
            _PrimaryButton(
              label: 'Save changes',
              onTap: controller.saveTask,
            ),
            const SizedBox(height: 10),
            _OutlineButton(
              label: 'Discard',
              onTap: () => Get.back(),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// ── Widgets ───────────────────────────────────────────────────────────────────

class _FieldLabel extends StatelessWidget {
  final String label;
  const _FieldLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        label.toUpperCase(),
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: Color(0xFF7B6FA0),
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _TaskTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final int maxLines;

  const _TaskTextField({
    required this.controller,
    required this.hint,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: const TextStyle(fontSize: 14, color: Color(0xFF2D2D2D)),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 14, color: Color(0xFFBBBBBB)),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFD8D0F5), width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFD8D0F5), width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF6C3CE1), width: 1.5),
          ),
        ),
      ),
    );
  }
}

class _StatusSelector extends GetView<UpdateTaskScreenViewController> {
  const _StatusSelector();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Row(
            children: TaskStatus.values
                .map((s) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: GestureDetector(
                        onTap: () => controller.selectedStatus.value = s,
                        child: _StatusChip(
                          status: s,
                          selected: controller.selectedStatus.value == s,
                        ),
                      ),
                    ))
                .toList(),
          ),
        ));
  }
}

class _StatusChip extends StatelessWidget {
  final TaskStatus status;
  final bool selected;
  const _StatusChip({required this.status, required this.selected});

  @override
  Widget build(BuildContext context) {
    final c = status.colors;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: selected ? c.active : c.bg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: selected ? c.active : c.border,
          width: 1.5,
        ),
      ),
      child: Text(
        status.label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: selected ? Colors.white : c.text,
        ),
      ),
    );
  }
}

class _PrioritySelector extends GetView<UpdateTaskScreenViewController> {
  const _PrioritySelector();

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
    final c = priority.colors;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: selected ? c.active : c.bg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: selected ? c.active : c.border,
          width: 1.5,
        ),
      ),
      child: Text(
        priority.label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: selected ? Colors.white : c.text,
        ),
      ),
    );
  }
}

class _DateTimeRow extends GetView<UpdateTaskScreenViewController> {
  const _DateTimeRow();

  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
          onTap: () => controller.pickDateTime(context),
          child: Container(
            margin: const EdgeInsets.only(bottom: 14),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFD8D0F5), width: 1.5),
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_today_rounded,
                    color: Color(0xFF6C3CE1), size: 18),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    controller.formattedDate,
                    style:
                        const TextStyle(fontSize: 14, color: Color(0xFF2D2D2D)),
                  ),
                ),
                Text(
                  controller.formattedTime,
                  style:
                      const TextStyle(fontSize: 13, color: Color(0xFF7B6FA0)),
                ),
                const SizedBox(width: 6),
                const Icon(Icons.keyboard_arrow_down_rounded,
                    color: Color(0xFF9E9E9E), size: 20),
              ],
            ),
          ),
        ));
  }
}

class _TagsRow extends GetView<UpdateTaskScreenViewController> {
  const _TagsRow();

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
                onTap: controller.showAddTagDialog,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0EDF9),
                    borderRadius: BorderRadius.circular(20),
                    border:
                        Border.all(color: const Color(0xFFD8D0F5), width: 1.5),
                  ),
                  child: const Text('+ Add',
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFEEEDFE),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF534AB7),
                  fontWeight: FontWeight.w500)),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: onRemove,
            child: const Icon(Icons.close_rounded,
                size: 14, color: Color(0xFF534AB7)),
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
          backgroundColor: const Color(0xFF6C3CE1),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          elevation: 0,
        ),
        child: Text(label,
            style: const TextStyle(
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

// ── Priority enum ─────────────────────────────────────────────────────────────

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

  _ChipColor get colors {
    switch (this) {
      case Priority.high:
        return const _ChipColor(
          bg: Color(0xFFFDECEC),
          border: Color(0xFFF5B5B5),
          text: Color(0xFFC0392B),
          active: Color(0xFFE74C3C),
        );
      case Priority.medium:
        return const _ChipColor(
          bg: Color(0xFFFFF4E0),
          border: Color(0xFFF5D49A),
          text: Color(0xFFB36A00),
          active: Color(0xFFE67E22),
        );
      case Priority.low:
        return const _ChipColor(
          bg: Color(0xFFEAF8EE),
          border: Color(0xFFA8E0B8),
          text: Color(0xFF1A7F3C),
          active: Color(0xFF27AE60),
        );
    }
  }
}

// ── TaskStatus enum ───────────────────────────────────────────────────────────

enum TaskStatus { todo, inProgress, done }

extension TaskStatusExt on TaskStatus {
  String get label {
    switch (this) {
      case TaskStatus.todo:
        return 'To do';
      case TaskStatus.inProgress:
        return 'In progress';
      case TaskStatus.done:
        return 'Done';
    }
  }

  _ChipColor get colors {
    switch (this) {
      case TaskStatus.todo:
        return const _ChipColor(
          bg: Color(0xFFF0EDF9),
          border: Color(0xFFD8D0F5),
          text: Color(0xFF534AB7),
          active: Color(0xFF6C3CE1),
        );
      case TaskStatus.inProgress:
        return const _ChipColor(
          bg: Color(0xFFE0F0FF),
          border: Color(0xFFB5D4F4),
          text: Color(0xFF185FA5),
          active: Color(0xFF378ADD),
        );
      case TaskStatus.done:
        return const _ChipColor(
          bg: Color(0xFFEAF8EE),
          border: Color(0xFFA8E0B8),
          text: Color(0xFF1A7F3C),
          active: Color(0xFF27AE60),
        );
    }
  }
}

// ── Shared color model ────────────────────────────────────────────────────────

class _ChipColor {
  final Color bg, border, text, active;
  const _ChipColor(
      {required this.bg,
      required this.border,
      required this.text,
      required this.active});
}
