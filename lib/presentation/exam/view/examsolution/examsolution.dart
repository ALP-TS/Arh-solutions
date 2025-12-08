import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:arh_solution_app/core/helpers/appbarhelper.dart';

import '../../../../app/Di/dimensions.dart';
import '../../../shared/view/animatedlistview.dart';
import '../../../shared/view/nodatafound.dart';
import '../../viewmodel/examresultvm.dart';

import 'src/listitem.dart';
import 'src/progress.dart';

class Examsolution extends StatelessWidget {
  const Examsolution({super.key});

  @override
  Widget build(BuildContext context) {
    final examResultvm = Get.find<Examresultvm>();
    return Scaffold(
      appBar: Appbarhelper.pageAppbar(title: 'Exam Solution'),
      body: Obx(
        () => examResultvm.resultData.isEmpty && examResultvm.isloading.value
            ? const CircularProgressIndicator()
            : examResultvm.resultData.isEmpty
            ? const Emptypage()
            : Padding(
                padding: EdgeInsets.only(
                  top: Di.screenWidth * 0.02,
                  left: Di.screenWidth * 0.02,
                  right: Di.screenWidth * 0.02,
                ),
                child: AnimatedListView(
                  itemcount: examResultvm.resultData.length,
                  itemBuilder: (context, index, animation) {
                    return Column(
                      children: [
                        if (index == 0) ...[
                          examResultvm.mark != null
                              ? MarkPer(
                                  value: examResultvm.mark!.totalMark
                                      .toDouble(),
                                  size: 100,
                                  strokeWidth: 8,
                                  percent: -100,
                                  totalmark: examResultvm.mark!.totalmarkscored
                                      .toDouble(),
                                )
                              : examResultvm.mark!.totalMark == 0 &&
                                    examResultvm.mark!.totalMark == 0
                              ? Container(
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color(0xFF667eea),
                                        Color(0xFF764ba2),
                                      ],
                                    ),
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Container(
                                        constraints: const BoxConstraints(
                                          maxWidth: 400,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.95),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(
                                                0.1,
                                              ),
                                              blurRadius: 30,
                                              offset: const Offset(0, 15),
                                              spreadRadius: 0,
                                            ),
                                            BoxShadow(
                                              color: Colors.black.withOpacity(
                                                0.05,
                                              ),
                                              blurRadius: 10,
                                              offset: const Offset(0, 5),
                                              spreadRadius: 0,
                                            ),
                                          ],
                                          border: Border.all(
                                            color: Colors.white.withOpacity(
                                              0.2,
                                            ),
                                            width: 1,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(40.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              // Animated Icon
                                              TweenAnimationBuilder(
                                                tween: Tween<double>(
                                                  begin: 0,
                                                  end: 1,
                                                ),
                                                duration: const Duration(
                                                  milliseconds: 800,
                                                ),
                                                builder: (context, double value, child) {
                                                  return Transform.scale(
                                                    scale: value,
                                                    child: Container(
                                                      width: 80,
                                                      height: 80,
                                                      decoration: BoxDecoration(
                                                        gradient:
                                                            const LinearGradient(
                                                              colors: [
                                                                Color(
                                                                  0xFFFF6B6B,
                                                                ),
                                                                Color(
                                                                  0xFFFFB74D,
                                                                ),
                                                              ],
                                                            ),
                                                        shape: BoxShape.circle,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: const Color(
                                                              0xFFFF6B6B,
                                                            ).withOpacity(0.3),
                                                            blurRadius: 15,
                                                            offset:
                                                                const Offset(
                                                                  0,
                                                                  8,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                      child: const Icon(
                                                        Icons.warning_rounded,
                                                        color: Colors.white,
                                                        size: 40,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),

                                              const SizedBox(height: 25),

                                              // Title
                                              const Text(
                                                'Score Not Calculated',
                                                style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF2D3748),
                                                  letterSpacing: -0.5,
                                                ),
                                              ),

                                              const SizedBox(height: 15),

                                              // Message
                                              Text(
                                                'Your score is not calculated because you didn\'t complete the exam.',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey[600],
                                                  height: 1.5,
                                                  letterSpacing: 0.2,
                                                ),
                                              ),

                                              const SizedBox(height: 30),

                                              // Action Button
                                              SizedBox(
                                                width: double.infinity,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    // Handle retry action
                                                    Navigator.of(context).pop();
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        const Color(0xFF667eea),
                                                    foregroundColor:
                                                        Colors.white,
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          vertical: 15,
                                                        ),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12,
                                                          ),
                                                    ),
                                                    elevation: 5,
                                                    shadowColor: const Color(
                                                      0xFF667eea,
                                                    ).withOpacity(0.3),
                                                  ),
                                                  child: const Text(
                                                    'Try Again',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      letterSpacing: 0.5,
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              const SizedBox(height: 15),

                                              // Secondary Button
                                              SizedBox(
                                                width: double.infinity,
                                                child: TextButton(
                                                  onPressed: () {
                                                    // Handle back to dashboard
                                                    Navigator.of(context).pop();
                                                  },
                                                  style: TextButton.styleFrom(
                                                    foregroundColor:
                                                        Colors.grey[600],
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          vertical: 15,
                                                        ),
                                                  ),
                                                  child: const Text(
                                                    'Back to Dashboard',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox(),
                          // ProgressIndicater(
                          //   currentQuestion: null,
                          //   totalQuestions: null,
                          //   onTimerFinish: (bool) {},
                          //   minutes: null,
                          // )
                        ],
                        FadeTransition(
                          opacity: animation.drive(
                            CurveTween(curve: Curves.easeIn),
                          ),
                          child: Resultitem(
                            resultModel: examResultvm.resultData[index],
                            index: index,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
      ),
    );
  }
}
