import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/screen/doctor_feature/d_homescreen/d_homescreen_controller.dart';
import 'package:get/get.dart';


class DHomescreenView extends GetView<DHomescreenController> {
   DHomescreenView({super.key});

  static const primary = Color(0xFF7B61FF);
  static const  bg = Color(0xFFF8F5FF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding:  EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    _header(),
                     SizedBox(height: 20),
                    _overviewCard(),
                     SizedBox(height: 15),
                    _todayAppointment(),
                     SizedBox(height: 15),
                    _actions(),
                     SizedBox(height: 25),
                    _patientSection(),
                  ],
                ),
              ),
            ),
            _bottomBar(),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Row(
      children: [
         CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(
            "https://randomuser.me/api/portraits/men/75.jpg",
          ),
        ),
         SizedBox(width: 12),
         Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                "Good morning",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 3),
              Text(
                "Dr. Latte Latte",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        Obx(
          () => Stack(
            children: [
              Container(
                padding:  EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(12),
                ),
                child:  Icon(
                  Icons.notifications_none,
                  color: primary,
                ),
              ),
              if (controller.hasNotification.value)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration:
                         BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _overviewCard() {
    return Container(
      height: 140,
      width: double.infinity,
      padding:  EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(20),
        gradient:  LinearGradient(
          colors: [
            Color(0xFF7B61FF),
            Color(0xFF6BA6FF),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Container(
            padding:
                 EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius:
                  BorderRadius.circular(20),
            ),
            child:  Text(
              "Today's Overview",
              style: TextStyle(
                color: Colors.white,
                fontSize: 11,
              ),
            ),
          ),
           Spacer(),
           Text(
            "12",
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
           Text(
            "Total Appointments",
            style: TextStyle(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _todayAppointment() {
    return Container(
      padding:  EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            padding:  EdgeInsets.all(10),
            decoration: BoxDecoration(
              color:
                  primary.withOpacity(0.1),
              borderRadius:
                  BorderRadius.circular(10),
            ),
            child:  Icon(
              Icons.calendar_month,
              color: primary,
            ),
          ),
           SizedBox(width: 10),
           Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  "Today Appointment",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                Text(
                  "12",
                  style: TextStyle(
                    color: primary,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
           Icon(
            Icons.chevron_right,
          ),
        ],
      ),
    );
  }

  Widget _actions() {
    return Row(
      children: [
        Expanded(
          child: _actionCard(
            Icons.videocam_outlined,
            "Post Video",
            "Record clip",
          ),
        ),
         SizedBox(width: 12),
        Expanded(
          child: _actionCard(
            Icons.image_outlined,
            "Post Image",
            "Share update",
          ),
        ),
      ],
    );
  }

  Widget _actionCard(
    IconData icon,
    String title,
    String subtitle,
  ) {
    return Container(
      padding:  EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Container(
            padding:  EdgeInsets.all(10),
            decoration: BoxDecoration(
              color:
                  primary.withOpacity(0.1),
              borderRadius:
                  BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: primary,
            ),
          ),
           SizedBox(height: 10),
          Text(title),
           SizedBox(height: 3),
          Text(
            subtitle,
            style:  TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _patientSection() {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
         Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Recent Patients",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              "See all",
              style: TextStyle(
                color: primary,
              ),
            ),
          ],
        ),
         SizedBox(height: 15),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection:
                Axis.horizontal,
            itemCount:
                controller.patients.length,
            itemBuilder: (_, index) {
              final patient =
                  controller.patients[index];

              return Container(
                width: 150,
                margin:
                     EdgeInsets.only(
                  right: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(
                          18),
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius:
                           BorderRadius
                              .vertical(
                        top:
                            Radius.circular(
                                18),
                      ),
                      child: Image.network(
                        patient.image,
                        height: 110,
                        width:
                            double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                     SizedBox(
                        height: 10),
                    Text(
                      patient.name,
                      style:
                           TextStyle(
                        fontWeight:
                            FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                     Text(
                      "Cardiac follow-up",
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                    ),
                     SizedBox(
                        height: 10),
                    Container(
                      padding:
                           EdgeInsets
                              .symmetric(
                        horizontal: 15,
                        vertical: 6,
                      ),
                      decoration:
                          BoxDecoration(
                        color: primary
                            .withOpacity(
                                0.1),
                        borderRadius:
                            BorderRadius
                                .circular(
                                    10),
                      ),
                      child:  Text(
                        "Message",
                        style: TextStyle(
                          color: primary,
                          fontWeight:
                              FontWeight
                                  .bold,
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _bottomBar() {
    return Container(
      padding:
           EdgeInsets.symmetric(
        vertical: 10,
      ),
      color: Colors.white,
      child: Obx(
        () => Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceEvenly,
          children: [
            _navItem(
              0,
              Icons.home_outlined,
            ),
            _navItem(
              1,
              Icons.people_outline,
            ),
            _navItem(
              2,
              Icons.chat_bubble_outline,
            ),
            _navItem(
              3,
              Icons.person_outline,
            ),
          ],
        ),
      ),
    );
  }

  Widget _navItem(
      int index, IconData icon) {
    final selected =
        controller.selectedIndex.value ==
            index;

    return GestureDetector(
      onTap: () {
        controller.selectedIndex.value =
            index;
      },
      child: Icon(
        icon,
        color:
            selected ? primary : Colors.grey,
      ),
    );
  }
}