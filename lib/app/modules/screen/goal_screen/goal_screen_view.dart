import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'goal_screen_binding.dart';
part 'goal_screen_controller.dart';

class GoalScreenView extends GetView<GoalScreenController> {
  const GoalScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              _HeaderBanner(),
              SizedBox(height: 20),
              _AddTaskRow(),
              SizedBox(height: 20),
              _WeekDaySelector(),
              SizedBox(height: 16),
              Expanded(
                child: Obx(() => ListView.builder(
                      itemCount: controller.tasks.length,
                      itemBuilder: (context, index) => _TaskItem(index: index),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderBanner extends GetView<GoalScreenController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Good Morning, ${controller.userName}!!',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF4B4B4B),
                      ),
                    ),
                    SizedBox(height: 6),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2D2D2D),
                        ),
                        children: [
                          TextSpan(text: 'You have '),
                          TextSpan(
                            text: '${controller.pendingCount} tasks',
                            style: TextStyle(color: Color(0xFF6C3CE1)),
                          ),
                          TextSpan(text: '\nTo complete'),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
          Image.asset(
            'assets/task.png',
            height: 120,
            errorBuilder: (_, __, ___) => Icon(
              Icons.people_alt_outlined,
              size: 60,
              color: Color(0xFF6C3CE1),
            ),
          ),
        ],
      ),
    );
  }
}

class _AddTaskRow extends GetView<GoalScreenController> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: controller.taskTextController,
              decoration: InputDecoration(
                hintText: 'Search task',
                hintStyle: TextStyle(color: Color(0xFFBBBBBB), fontSize: 15),
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Color(0xFF717182), width: 1.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Color(0xFF717182), width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Color(0xFF6C3CE1), width: 2),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        GestureDetector(
          // onTap: controller.goToAddTask,
          onTap: () => Get.toNamed('/addtask'),
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Color(0xFF6C3CE1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.add, color: Colors.white, size: 28),
          ),
        ),
      ],
    );
  }
}

class _WeekDaySelector extends GetView<GoalScreenController> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 62,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: controller.weekDays.length,
        separatorBuilder: (_, __) => SizedBox(width: 6),
        itemBuilder: (context, i) {
          return Obx(() {
            final isSelected = i == controller.selectedDayIndex.value;
            return GestureDetector(
              onTap: () => controller.selectDay(i),
              child: Container(
                width: 42,
                decoration: BoxDecoration(
                  color: isSelected ? Color(0xFF6C3CE1) : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      controller.weekDays[i]['day']!,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.white : Color(0xFF9E9E9E),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      controller.weekDays[i]['date']!,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: isSelected ? Colors.white : Color(0xFF4B4B4B),
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        },
      ),
    );
  }
}

class _TaskItem extends GetView<GoalScreenController> {
  final int index;
  const _TaskItem({required this.index});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final task = controller.tasks[index];
      final isCompleted = task.isCompleted;
      final isLast = index == controller.tasks.length - 1;

      return IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Timeline
            SizedBox(
              width: 24,
              child: Column(
                children: [
                  Container(
                    width: 14,
                    height: 14,
                    margin: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      color:
                          isCompleted ? Color(0xFF6C3CE1) : Color(0xFFD8D0F5),
                      shape: BoxShape.circle,
                    ),
                  ),
                  if (!isLast)
                    Expanded(
                      child: Center(
                        child: Container(width: 2, color: Color(0xFFD8D0F5)),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(width: 10),
            // Card
            Expanded(
              child: GestureDetector(
                onTap: () {
                  if (!isCompleted) controller.showCompleteDialog(index);
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 12),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Radio circle
                      Padding(
                        padding: EdgeInsets.only(top: 2),
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isCompleted
                                  ? Color(0xFF6C3CE1)
                                  : Color(0xFFBBBBBB),
                              width: 2,
                            ),
                          ),
                          child: isCompleted
                              ? Center(
                                  child: Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF6C3CE1),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                )
                              : null,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              task.title,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                decoration: isCompleted
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                decorationColor: Colors.black,
                                decorationThickness: 1.5,
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              task.subtitle,
                              style: TextStyle(
                                fontSize: 14,
                                color: isCompleted
                                    ? Color(0xFF9E9E9E)
                                    : Color(0xFF9E9E9E),
                                decoration: isCompleted
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                decorationColor: Colors.black,
                              ),
                            ),
                            SizedBox(height: 6),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                task.time,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF4B4B4B),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
