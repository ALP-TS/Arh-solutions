import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:arh_solution_app/app/config/theme/colors.dart';

import '../../../../../core/helpers/toasthelper.dart';
import '../../../../../domain/models/zoommeetlist_model.dart';
import '../../../../zoom/view/meetingscreen.dart';

class MeetingCard extends StatelessWidget {
  const MeetingCard({
    super.key,
    required this.isNextMeeting,
    required this.date,
    required this.meeting,
    required this.stuname,
    required this.context,
    required this.starttime,
    required this.endtime,
  });
  final bool isNextMeeting;
  final String date;
  final ZoomMeeting meeting;
  final String stuname;
  final BuildContext context;
  final String starttime;
  final String endtime;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isNextMeeting) {
          Get.to(
            () => ZoomMeetingScreen(
              meetingUrl:
                  'https://us05web.zoom.us/wc/join/${meeting.meetingNumber}?pwd=${meeting.encryptedPassword}&uname=$stuname',
              stuname: stuname,
              topic: meeting.topic,
            ),
          );
        } else {
          ToastHelper.warningToast(
            context,
            title: 'Meting Scheduled',
            desc: 'Meeting not started yet',
          );
        }
      },
        child: Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          // height: 20,
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(color: Colors.white, offset: Offset(0, 3), blurRadius: 8),
            ],
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: isNextMeeting ? Colors.green : Colors.orange,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    isNextMeeting ? 'Starting soon' : 'Scheduled',
                    style: TextStyle(
                      fontSize: 12,
                      color: isNextMeeting ? Colors.green : Colors.orange,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: AppColors.white,
                    child: HugeIcon(
                      icon: HugeIcons.strokeRoundedUserStatus,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          meeting.staffName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          meeting.topic,
                          // '${meeting.topic} (ID: ${meeting.meetingNumber})',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const CircleAvatar(
                    backgroundColor: AppColors.white,
                    child: Icon(
                      HugeIcons.strokeRoundedVideo01,
                      color: AppColors.primary,
                      size: 28,
                    ),
                  ),
                ],
              ),
              const Divider(color: Colors.white24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: AppColors.secondary,
                        child: HugeIcon(
                          icon: HugeIcons.strokeRoundedCalendar03,
                          color: AppColors.white,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Date',
                            style: TextStyle(color: Colors.white60, fontSize: 12),
                          ),
                          Text(
                            date,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: AppColors.secondary,
                        child: HugeIcon(
                          icon: HugeIcons.strokeRoundedClock01,
                          color: AppColors.white,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Time',
                            style: TextStyle(color: Colors.white60, fontSize: 12),
                          ),
                          Text(
                            '$starttime - $endtime',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (isNextMeeting) {
                          Get.to(
                            () => ZoomMeetingScreen(
                              meetingUrl:
                                  'https://us05web.zoom.us/wc/join/${meeting.meetingNumber}?pwd=${meeting.encryptedPassword}&uname=$stuname',
                              stuname: stuname,
                              topic: meeting.topic,
                            ),
                          );
                        } else {
                          ToastHelper.warningToast(
                            context,
                            title: 'Meting Scheduled',
                            desc: 'Meeting not started yet',
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.white,
                        foregroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        isNextMeeting ? "Join Now" : "Scheduled",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
  }
}
