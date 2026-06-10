// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/screen/mood_selection/widget/categoriesWidget.dart';
import 'package:flutter_application_1/app/shared/themes/app_colors.dart';
import 'package:get/get.dart';

part 'video_screen_binding.dart';
part 'video_screen_controller.dart';

class VideoScreenView extends GetView<VideoScreenViewController> {
  VideoScreenView({super.key});

  final List<Map<String, String>> _videos = [
    {
      'title': 'Encourage people!',
      'author': 'Dr. Last air Bender',
      'views': '3.1k views',
      'time': '2 hours ago',
      'duration': '30:21',
      'image': 'https://picsum.photos/seed/vid1/400/220',
      'avatar': 'https://picsum.photos/seed/av1/100/100',
    },
    {
      'title': 'Encourage people!',
      'author': 'Dr. Last air Bender',
      'views': '3.1k views',
      'time': '2 hours ago',
      'duration': '30:21',
      'image': 'https://picsum.photos/seed/vid2/400/220',
      'avatar': 'https://picsum.photos/seed/av2/100/100',
    },
    {
      'title': 'Encourage people!',
      'author': 'Dr. Last air Bender',
      'views': '3.1k views',
      'time': '2 hours ago',
      'duration': '30:21',
      'image': 'https://picsum.photos/seed/vid1/400/220',
      'avatar': 'https://picsum.photos/seed/av1/100/100',
    },
    {
      'title': 'Encourage people!',
      'author': 'Dr. Last air Bender',
      'views': '3.1k views',
      'time': '2 hours ago',
      'duration': '30:21',
      'image': 'https://picsum.photos/seed/vid3/400/220',
      'avatar': 'https://picsum.photos/seed/av3/100/100',
    },
    {
      'title': 'Encourage people!',
      'author': 'Dr. Last air Bender',
      'views': '3.1k views',
      'time': '2 hours ago',
      'duration': '30:21',
      'image': 'https://picsum.photos/seed/vid4/400/220',
      'avatar': 'https://picsum.photos/seed/av4/100/100',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 25),
                    _buildAppBar(),
                    SizedBox(height: 25),
                    Categorieswidget(
                      categories: [
                        'All',
                        'Motivation',
                        'Self improvement',
                        'Psychology',
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Most relevant',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2E2C35),
                      ),
                    ),
                    SizedBox(height: 12),
                    _buildTopVideoRow(),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 14),
                  child: _buildVideoCard(_videos[index + 2]),
                );
              }, childCount: _videos.length - 2),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 15)),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Watch video',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2E2C35),
              ),
            ),
            Text(
              'Take a break and enjoy watching video',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFF9F9DA4),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTopVideoRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      primary: false,
      child: Row(
        children: List.generate(_videos.length, (index) {
          return Padding(
            padding: EdgeInsets.only(
              right: index == _videos.length - 1 ? 0 : 12,
            ),
            child: SizedBox(
              width: 180,
              child: _buildSmallVideoCard(_videos[index]),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildSmallVideoCard(Map<String, String> video) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              Image.network(
                video['image']!,
                height: 110,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 6,
                right: 6,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    video['duration']!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 7),
        Text(
          video['title']!,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2E2C35),
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 2),
        Text(
          video['author']!,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: Color(0xFF9F9DA4),
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          '${video['views']} · ${video['time']}',
          style: TextStyle(fontSize: 11, color: Color(0xFF9F9DA4)),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildVideoCard(Map<String, String> video) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              Image.network(
                video['image']!,
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    video['duration']!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(video['avatar']!),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    video['title']!,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2E2C35),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2),
                  Text(
                    video['author']!,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF9F9DA4),
                    ),
                  ),
                  Text(
                    '${video['views']} · ${video['time']}',
                    style: TextStyle(fontSize: 12, color: Color(0xFF9F9DA4)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
