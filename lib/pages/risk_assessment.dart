import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tanzmed/helpers/constants.dart';
import 'package:tanzmed/helpers/settings.dart';
import 'package:tanzmed/widgets/custom_loading.dart';

import 'tabia/qns_answers.dart';
import 'tabia/tabia_answers.dart';

class RiskAssessment extends StatefulWidget {
  const RiskAssessment({super.key});

  @override
  State<RiskAssessment> createState() => _RiskAssessmentState();
}

class _RiskAssessmentState extends State<RiskAssessment> {
  String recentAnswer = "";
  String recentQuestion = "";
  dynamic recentanswerValue = "";
  String recentanswerContribution = "";
  dynamic totalContribution = 0;
  int currentQuestionIndex = 0;
  List<dynamic> answerValues = [];
  bool isLoading = false;
  void updateTotalContribution(dynamic contribution) {
    setState(() {
      totalContribution += contribution; // Update total contribution
    });
    // print('Total Contribution: $totalContribution');
  }

  final apiClient = ApiClient();
  @override
  Widget build(BuildContext context) {
    // print(tabiaQuestionss(context));
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Kikokotoa tabia hatarishi",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: AppSettings.primaryColor,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          // systemNavigationBarColor: TwitterColor.black,
          statusBarIconBrightness: Brightness.light,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: isLoading == true
          ? const CustomLoadingDialog()
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      singleQuestion(
                          tabiaQuestionss(context)[currentQuestionIndex]
                              ['question']),
                      // const Text("List of answers"),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 40,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.only(right: 10),
                          children: List.generate(
                            tabiaAnswers1(context)[currentQuestionIndex].length,
                            (index) => Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    recentAnswer = tabiaAnswers1(context)[
                                        currentQuestionIndex][index]['answer'];
                                    recentQuestion = tabiaQuestionss(context)[
                                        currentQuestionIndex]['question'];
                                    recentanswerValue = tabiaAnswers1(context)[
                                        currentQuestionIndex][index]['value'];
                                    dynamic contribution = tabiaAnswers1(
                                            context)[currentQuestionIndex]
                                        [index]['contribution'];
                                    updateTotalContribution(contribution);

                                    answerValues.add(recentanswerValue);
                                  });
                                  // print(answerValues);
                                  if (currentQuestionIndex <
                                      tabiaQuestionss(context).length - 1) {
                                    // If it's not the last question, increment the index
                                    setState(() {
                                      currentQuestionIndex++;
                                    });
                                  } else {
                                    // If it's the last question, save data to database
                                    saveDataToDatabase(answerValues,
                                        totalContribution.toDouble());
                                  }
                                },
                                child: Container(
                                  // width: 100,
                                  // height: 50,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    // shape: BoxShape.circle,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    border: Border.all(
                                        color: AppSettings.primaryColor),
                                    color: Colors.white, //.withAlpha(50),
                                  ),
                                  child: Text(tabiaAnswers1(context)[
                                      currentQuestionIndex][index]['answer']),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     setState(() {
                      //       recentAnswer = 'Answer A';
                      //       recentQuestion = tabiaQuestionss(context)[currentQuestionIndex];
                      //       currentQuestionIndex++;
                      //     });
                      //   },
                      //   child: const Text('Answer A'),
                      //   // color: Colors.blue,
                      // ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    recentQuestion != ""
                        ? singleQuestion2(recentQuestion)
                        : Container(),
                    recentAnswer != ""
                        ? singleAnswer2(recentAnswer)
                        : Container(),
                    // singleAnswer2
                  ],
                ),
                Container(
                  padding:
                      Platform.isIOS ? const EdgeInsets.only(bottom: 20) : null,
                ),
              ],
            ),
    );
  }

  singleQuestion(String qn) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppSettings.primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        qn,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  singleQuestion2(String qn) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          // color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          // border: Border.all(color: primaryColor),
          color: const Color(0xffE1E8ED).withAlpha(100),
        ),
        child: Text(
          qn,
          style: const TextStyle(
              // color: Colors.white,
              ),
        ),
      ),
    );
  }

  singleAnswer2(String qn) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppSettings.secondaryColor,
          borderRadius: BorderRadius.circular(10),
          // border: Border.all(color: primaryColor),
        ),
        child: Text(
          qn,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Future<void> saveDataToDatabase(
      List<dynamic> answerValues, double totalContribution) async {
    try {
      setState(() {
        isLoading = true;
      });
      // Make the API call to save the data
      var response = await apiClient.post(
        '/api/hiv/submit-risk',
        body: {
          'answerValues': answerValues,
          'totalContribution': totalContribution.toString(),
        },
      );

      // Check the response status
      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
        });
        Get.to(TabiaAnswersPage(
          answerValues: answerValues,
          totalContribution: totalContribution,
        ));
      } else {
        setState(() {
          isLoading = false;
        });
        Get.to(TabiaAnswersPage(
          answerValues: answerValues,
          totalContribution: totalContribution,
        ));
        // print('Failed to save data. Error: ${response.body}');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // Handle any exceptions
      Get.to(TabiaAnswersPage(
        answerValues: answerValues,
        totalContribution: totalContribution,
      ));
    }
  }
}
