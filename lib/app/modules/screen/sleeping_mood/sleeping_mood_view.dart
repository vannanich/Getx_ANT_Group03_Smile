import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/screen/sleeping_mood/sleeping_mood_controller.dart';
import 'package:get/get.dart';

class SleepModeView extends StatelessWidget {
  const SleepModeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SleepModeController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFF1A1A2E),
          body: SafeArea(
  child: Column(
    children: [
      _buildHeader(),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 8),
              _buildSleepModeCard(),
              const SizedBox(height: 20),
              _buildTimerSection(controller),
              const SizedBox(height: 24),
              _buildSoundsSection(controller),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    ],
  ),
),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
          const Text(
            'Sleep Mode',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 40), // Empty space for balance
        ],
      ),
    );
  }

  Widget _buildSleepModeCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF6C63FF).withOpacity(0.3),
            const Color(0xFF3F3D9E).withOpacity(0.2),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.nightlight_round,
            size: 40,
            color: Colors.white.withOpacity(0.9),
          ),
          const SizedBox(height: 10),
          const Text(
            'Sleeping mode',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Have a goodnight sleep',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimerSection(SleepModeController controller) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Text(
            'Sleep Timer',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          // Time Display
          Obx(
            () => Text(
              controller.getFormattedTime(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Time Pickers
          // Time Pickers
Wrap(
  spacing: 8,
  runSpacing: 8,
  alignment: WrapAlignment.center,
  children: [
    SizedBox(
      width: 100,
      child: _buildTimePicker(
        'HRS',
        controller.hours.value,
        controller.updateHours,
      ),
    ),
    SizedBox(
      width: 100,
      child: _buildTimePicker(
        'MIN',
        controller.minutes.value,
        controller.updateMinutes,
      ),
    ),
    SizedBox(
      width: 100,
      child: _buildTimePicker(
        'SEC',
        controller.seconds.value,
        controller.updateSeconds,
      ),
    ),
  ],
),
          const SizedBox(height: 20),
          // Start Timer Button
          Obx(
            () => ElevatedButton(
              onPressed: controller.isTimerRunning.value
                  ? controller.pauseTimer
                  : controller.startTimer,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
                backgroundColor: const Color(0xFF6C63FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(
                controller.isTimerRunning.value ? 'Pause Timer' : 'Start Timer',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          if (controller.isTimerRunning.value) ...[
            const SizedBox(height: 10),
            TextButton(
              onPressed: controller.resetTimer,
              style: TextButton.styleFrom(
                minimumSize: const Size(double.infinity, 36),
              ),
              child: const Text(
                'Reset',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTimePicker(String label, int value, Function(int) onChanged) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => onChanged(value - 1),
                  icon: const Icon(
                    Icons.remove,
                    color: Colors.white,
                    size: 16,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                Container(
                  width: 35,
                  alignment: Alignment.center,
                  child: Text(
                    value.toString().padLeft(2, '0'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => onChanged(value + 1),
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 16,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

 Widget _buildSoundsSection(SleepModeController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Sounds',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      const SizedBox(height: 14),
      GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.sounds.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.1, // 🔥 adjusted to prevent overflow
        ),
        itemBuilder: (context, index) {
          return Obx(
            () => _buildSoundCard(
              controller.sounds[index],
              controller.selectedSoundIndex.value == index,
              () => controller.selectSound(index),
            ),
          );
        },
      ),
    ],
  );
}

  Widget _buildSoundCard(String soundName, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF6C63FF)
              : Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF6C63FF)
                : Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getSoundIcon(soundName),
              color: isSelected ? Colors.white : Colors.white70,
              size: 22,
            ),
            const SizedBox(height: 6),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  soundName,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.white70,
                    fontSize: 10,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getSoundIcon(String soundName) {
    if (soundName.contains('Rain')) return Icons.grain;
    if (soundName.contains('Wind')) return Icons.air;
    if (soundName.contains('Snow')) return Icons.ac_unit;
    if (soundName.contains('Night') || soundName.contains('Starry')) return Icons.nightlight_round;
    if (soundName.contains('Drum') || soundName.contains('Tribal')) return Icons.music_note;
    if (soundName.contains('Typhoon')) return Icons.tornado;
    if (soundName.contains('Sleet')) return Icons.cloud_queue;
    if (soundName.contains('Cloudiness')) return Icons.cloud;
    if (soundName.contains('Heavenly')) return Icons.spa;
    return Icons.volume_up;
  }
}