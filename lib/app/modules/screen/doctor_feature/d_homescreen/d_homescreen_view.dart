// lib/views/doctor_home_view.dart

import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/screen/doctor_feature/d_homescreen/d_homescreen_controller.dart';
import 'package:get/get.dart';

class DHomescreenView extends GetView<DoctorHomeController> {
  const DHomescreenView({super.key});

  static const _bg = Color(0xFFF1F5F9);
  static const _white = Colors.white;
  static const _textDark = Color(0xFF0F172A);
  static const _textMid = Color(0xFF475569);
  static const _textLight = Color(0xFF94A3B8);
  static const _border = Color(0xFFE2E8F0);

  static const _grad1 = Color(0xFF6366F1);
  static const _grad2 = Color(0xFF8B5CF6);
  static const _pink = Color(0xFFEC4899);
  static const _teal = Color(0xFF10B981);
  static const _amber = Color(0xFFF59E0B);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: Obx(() {
        switch (controller.currentIndex.value) {
          case 0: return _buildHomeTab();
          case 1: return _buildAppointmentsTab();
          case 2: return _buildPostsTab();
          case 3: return _buildChatTab();
          case 4: return _buildAnalyticsTab();
          default: return _buildHomeTab();
        }
      }),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return Obx(() => Container(
          decoration: BoxDecoration(
            color: _white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 20,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _navItem(0, Icons.home_rounded, 'Home'),
                  _navItem(1, Icons.calendar_month_rounded, 'Schedule'),
                  _navItem(2, Icons.article_rounded, 'Posts'),
                  _navItem(3, Icons.chat_bubble_rounded, 'Chat'),
                  _navItem(4, Icons.bar_chart_rounded, 'Analytics'),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _navItem(int index, IconData icon, String label) {
    final isActive = controller.currentIndex.value == index;
    return GestureDetector(
      onTap: () => controller.changePage(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: isActive
              ? const LinearGradient(colors: [_grad1, _grad2])
              : null,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon,
                color: isActive ? _white : _textLight, size: 22),
            if (isActive) ...[
              const SizedBox(height: 2),
              Text(label,
                  style: const TextStyle(
                      color: _white,
                      fontSize: 10,
                      fontWeight: FontWeight.w600)),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHomeTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHomeHeader(),
          const SizedBox(height: 20),
          _buildStatsRow(),
          const SizedBox(height: 24),
          _buildTodayAppointments(),
          const SizedBox(height: 24),
          _buildQuickActions(),
          const SizedBox(height: 24),
          _buildRecentActivity(),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildHomeHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF4F46E5), Color(0xFF7C3AED), Color(0xFFDB2777)],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Avatar
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _white.withOpacity(0.2),
                      border: Border.all(
                          color: _white.withOpacity(0.4), width: 2),
                    ),
                    child: const Icon(Icons.person_rounded,
                        color: _white, size: 28),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Good morning 👋',
                          style: TextStyle(
                              color: Colors.white70, fontSize: 13),
                        ),
                        Obx(() => Text(
                              controller.doctorName.value,
                              style: const TextStyle(
                                color: _white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            )),
                        Obx(() => Row(
                              children: [
                                const Icon(Icons.verified_rounded,
                                    color: Color(0xFF4ADE80), size: 14),
                                const SizedBox(width: 4),
                                Text(
                                  controller.specialty.value,
                                  style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                  // Notification bell
                  Stack(
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: _white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.notifications_rounded,
                            color: _white, size: 22),
                      ),
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFBBF24),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Today's summary card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: _white.withOpacity(0.2)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today_rounded,
                        color: _white, size: 18),
                    const SizedBox(width: 10),
                    const Text(
                      "Today's Schedule",
                      style: TextStyle(
                          color: _white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    ),
                    const Spacer(),
                    Obx(() => Text(
                          '${controller.appointments.where((a) => a['status'] == 'upcoming').length} upcoming',
                          style: const TextStyle(
                              color: Color(0xFF4ADE80),
                              fontWeight: FontWeight.w600,
                              fontSize: 13),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          _statCard('Patients', controller.totalPatients.value.toString(),
              Icons.people_rounded, _grad1, _grad2),
          const SizedBox(width: 12),
          _statCard('Posts', controller.totalPosts.value.toString(),
              Icons.article_rounded, _pink, const Color(0xFFF43F5E)),
          const SizedBox(width: 12),
          _statCard('Rating', '${controller.rating.value}★',
              Icons.star_rounded, _teal, const Color(0xFF059669)),
        ],
      ),
    );
  }

  Widget _statCard(String label, String value, IconData icon,
      Color c1, Color c2) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [c1, c2],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: c1.withOpacity(0.35),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: _white.withOpacity(0.8), size: 20),
            const SizedBox(height: 10),
            Text(value,
                style: const TextStyle(
                    color: _white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700)),
            Text(label,
                style: TextStyle(
                    color: _white.withOpacity(0.75), fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildTodayAppointments() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              const Text('Today\'s Appointments',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: _textDark)),
              const Spacer(),
              GestureDetector(
                onTap: () => controller.changePage(1),
                child: const Text('See all',
                    style: TextStyle(color: _grad1, fontSize: 13)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 110,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: controller.appointments.length,
            itemBuilder: (_, i) {
              final apt = controller.appointments[i];
              final isDone = apt['status'] == 'completed';
              return Container(
                width: 160,
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: _white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: _border),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor:
                              Color(apt['color']).withOpacity(0.15),
                          child: Text(apt['avatar'],
                              style: TextStyle(
                                  color: Color(apt['color']),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13)),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: isDone
                                ? const Color(0xFFECFDF5)
                                : const Color(0xFFEEF2FF),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            isDone ? 'Done' : 'Soon',
                            style: TextStyle(
                              color: isDone ? _teal : _grad1,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(apt['name'],
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: _textDark)),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(Icons.access_time_rounded,
                            size: 11, color: _textLight),
                        const SizedBox(width: 3),
                        Text(apt['time'],
                            style: const TextStyle(
                                fontSize: 11, color: _textLight)),
                        const SizedBox(width: 6),
                        const Icon(Icons.videocam_rounded,
                            size: 11, color: _textLight),
                        const SizedBox(width: 3),
                        Expanded(
                          child: Text(apt['type'],
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 11, color: _textLight)),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Quick Actions',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: _textDark)),
          const SizedBox(height: 12),
          Row(
            children: [
              _quickAction(Icons.add_circle_rounded, 'New Post',
                  _grad1, _grad2, () => controller.changePage(2)),
              const SizedBox(width: 12),
              _quickAction(Icons.chat_rounded, 'Message',
                  _pink, const Color(0xFFF43F5E),
                  () => controller.changePage(3)),
              const SizedBox(width: 12),
              _quickAction(Icons.bar_chart_rounded, 'Analytics',
                  _teal, const Color(0xFF059669),
                  () => controller.changePage(4)),
              const SizedBox(width: 12),
              _quickAction(Icons.person_rounded, 'Profile',
                  _amber, const Color(0xFFD97706), () {}),
            ],
          ),
        ],
      ),
    );
  }

  Widget _quickAction(IconData icon, String label, Color c1, Color c2,
      VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [c1, c2]),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                  color: c1.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 3)),
            ],
          ),
          child: Column(
            children: [
              Icon(icon, color: _white, size: 24),
              const SizedBox(height: 6),
              Text(label,
                  style: const TextStyle(
                      color: _white,
                      fontSize: 11,
                      fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Recent Messages',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: _textDark)),
          const SizedBox(height: 12),
          ...controller.recentChats.take(3).map((chat) => _chatTile(chat)),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // TAB 2 — Appointments
  // ══════════════════════════════════════════════════════════════════════════
  Widget _buildAppointmentsTab() {
    return Column(
      children: [
        _gradientHeader('Schedule', Icons.calendar_month_rounded),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: controller.appointments.length,
            itemBuilder: (_, i) {
              final apt = controller.appointments[i];
              final isDone = apt['status'] == 'completed';
              return Container(
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: _border),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 10),
                  ],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor:
                          Color(apt['color']).withOpacity(0.15),
                      child: Text(apt['avatar'],
                          style: TextStyle(
                              color: Color(apt['color']),
                              fontWeight: FontWeight.w700,
                              fontSize: 18)),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(apt['name'],
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: _textDark)),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.access_time_rounded,
                                  size: 13, color: _textLight),
                              const SizedBox(width: 4),
                              Text(apt['time'],
                                  style: const TextStyle(
                                      color: _textMid, fontSize: 13)),
                              const SizedBox(width: 10),
                              Icon(
                                apt['type'] == 'Video Call'
                                    ? Icons.videocam_rounded
                                    : Icons.chat_rounded,
                                size: 13,
                                color: _textLight,
                              ),
                              const SizedBox(width: 4),
                              Text(apt['type'],
                                  style: const TextStyle(
                                      color: _textMid, fontSize: 13)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        gradient: isDone
                            ? null
                            : const LinearGradient(
                                colors: [_grad1, _grad2]),
                        color: isDone
                            ? const Color(0xFFF1F5F9)
                            : null,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        isDone ? 'Completed' : 'Start',
                        style: TextStyle(
                          color: isDone ? _textLight : _white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // TAB 3 — Posts
  // ══════════════════════════════════════════════════════════════════════════
  Widget _buildPostsTab() {
    return Column(
      children: [
        _gradientHeader('My Posts', Icons.article_rounded),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: controller.posts.length,
            itemBuilder: (_, i) {
              final post = controller.posts[i];
              return Obx(() {
                final p = controller.posts[i];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: _white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 12),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                    colors: [_grad1, _grad2]),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.person_rounded,
                                  color: _white, size: 20),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Obx(() => Text(
                                        controller.doctorName.value,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13,
                                            color: _textDark),
                                      )),
                                  Text(p['time'],
                                      style: const TextStyle(
                                          color: _textLight,
                                          fontSize: 11)),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Color(p['tagColor'])
                                    .withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(p['tag'],
                                  style: TextStyle(
                                      color: Color(p['tagColor']),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ],
                        ),
                      ),
                      // Content
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(p['title'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                    color: _textDark)),
                            const SizedBox(height: 6),
                            Text(p['content'],
                                style: const TextStyle(
                                    color: _textMid,
                                    fontSize: 13,
                                    height: 1.5)),
                          ],
                        ),
                      ),
                      // Actions
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () => controller.toggleLike(i),
                              child: Row(
                                children: [
                                  Icon(
                                    p['liked']
                                        ? Icons.favorite_rounded
                                        : Icons.favorite_border_rounded,
                                    color: p['liked']
                                        ? _pink
                                        : _textLight,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 4),
                                  Text('${p['likes']}',
                                      style: TextStyle(
                                          color: p['liked']
                                              ? _pink
                                              : _textLight,
                                          fontSize: 13)),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                            Row(
                              children: [
                                const Icon(
                                    Icons.chat_bubble_outline_rounded,
                                    color: _textLight,
                                    size: 18),
                                const SizedBox(width: 4),
                                Text('${p['comments']}',
                                    style: const TextStyle(
                                        color: _textLight,
                                        fontSize: 13)),
                              ],
                            ),
                            const Spacer(),
                            const Icon(Icons.share_outlined,
                                color: _textLight, size: 18),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              });
            },
          ),
        ),
      ],
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // TAB 4 — Chat
  // ══════════════════════════════════════════════════════════════════════════
  Widget _buildChatTab() {
    return Column(
      children: [
        _gradientHeader('Messages', Icons.chat_bubble_rounded),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: controller.recentChats.length,
            itemBuilder: (_, i) => _chatTile(controller.recentChats[i]),
          ),
        ),
      ],
    );
  }

  Widget _chatTile(Map<String, dynamic> chat) {
    final hasUnread = chat['unread'] > 0;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _border),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: Color(chat['color']).withOpacity(0.15),
                child: Text(chat['avatar'],
                    style: TextStyle(
                        color: Color(chat['color']),
                        fontWeight: FontWeight.w700,
                        fontSize: 18)),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: _teal,
                    shape: BoxShape.circle,
                    border: Border.all(color: _white, width: 2),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(chat['name'],
                    style: TextStyle(
                        fontWeight: hasUnread
                            ? FontWeight.w700
                            : FontWeight.w500,
                        fontSize: 14,
                        color: _textDark)),
                const SizedBox(height: 3),
                Text(chat['message'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color:
                            hasUnread ? _textDark : _textLight,
                        fontSize: 12)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(chat['time'],
                  style:
                      const TextStyle(color: _textLight, fontSize: 11)),
              const SizedBox(height: 4),
              if (hasUnread)
                Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [_grad1, _grad2]),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text('${chat['unread']}',
                        style: const TextStyle(
                            color: _white,
                            fontSize: 10,
                            fontWeight: FontWeight.w700)),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // TAB 5 — Analytics
  // ══════════════════════════════════════════════════════════════════════════
  Widget _buildAnalyticsTab() {
    return Column(
      children: [
        _gradientHeader('Analytics', Icons.bar_chart_rounded),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Summary cards
                Row(
                  children: [
                    _analyticCard('Total Patients',
                        '${controller.totalPatients.value}',
                        Icons.people_rounded, _grad1, _grad2),
                    const SizedBox(width: 12),
                    _analyticCard('Appointments',
                        '${controller.totalAppointments.value}',
                        Icons.calendar_month_rounded, _pink,
                        const Color(0xFFF43F5E)),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _analyticCard('Posts Published',
                        '${controller.totalPosts.value}',
                        Icons.article_rounded, _teal,
                        const Color(0xFF059669)),
                    const SizedBox(width: 12),
                    _analyticCard('Avg. Rating',
                        '${controller.rating.value}★',
                        Icons.star_rounded, _amber,
                        const Color(0xFFD97706)),
                  ],
                ),
                const SizedBox(height: 24),
                // Weekly chart
                const Text('Weekly Patients',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: _textDark)),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: _white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 12),
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 140,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: List.generate(7, (i) {
                            final val = controller.weeklyPatients[i];
                            final maxVal = controller.weeklyPatients
                                .reduce((a, b) => a > b ? a : b);
                            final height = (val / maxVal) * 120;
                            final isHighest = val == maxVal;
                            return Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.end,
                                children: [
                                  if (isHighest)
                                    Text('${val.toInt()}',
                                        style: const TextStyle(
                                            color: _grad1,
                                            fontSize: 11,
                                            fontWeight:
                                                FontWeight.w600)),
                                  const SizedBox(height: 4),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    height: height,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: isHighest
                                            ? [_grad1, _grad2]
                                            : [
                                                _grad1.withOpacity(0.3),
                                                _grad2.withOpacity(0.3)
                                              ],
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(6),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: controller.weekDays
                            .map((d) => Expanded(
                                  child: Text(d,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: _textLight,
                                          fontSize: 11)),
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _analyticCard(String label, String value, IconData icon,
      Color c1, Color c2) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: _white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [c1, c2]),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: _white, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(value,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: _textDark)),
                  Text(label,
                      style: const TextStyle(
                          color: _textLight, fontSize: 11)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Shared gradient header ────────────────────────────────────────────────
  Widget _gradientHeader(String title, IconData icon) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF4F46E5), Color(0xFF7C3AED), Color(0xFFDB2777)],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
          child: Row(
            children: [
              Icon(icon, color: _white, size: 24),
              const SizedBox(width: 10),
              Text(title,
                  style: const TextStyle(
                      color: _white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700)),
            ],
          ),
        ),
      ),
    );
  }
}