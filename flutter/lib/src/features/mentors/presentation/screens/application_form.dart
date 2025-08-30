import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mentor_link/src/core/presentation/custom_button.dart';
import 'package:mentor_link/src/core/presentation/header.dart';
import 'package:mentor_link/src/core/routing/routes.dart';
import 'package:mentor_link/src/features/mentors/presentation/data/models/mentor_card_models.dart';
import 'package:mentor_link/src/features/mentors/presentation/widgets/application_form1.dart';
import 'package:mentor_link/src/features/mentors/presentation/widgets/application_form3.dart';

import '../widgets/step_indicator.dart';
import '../widgets/application_form2.dart';

class ApplicationForm extends StatefulWidget {
  const ApplicationForm({super.key, required this.mentor});

  final MentorModel mentor;

  @override
  State<ApplicationForm> createState() => _ApplicationFormState();
}

class _ApplicationFormState extends State<ApplicationForm> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  final int _totalSteps = 3;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void nextPage() {
    if (_currentStep < _totalSteps - 1) {
      setState(() => _currentStep++);
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      //here we will navigate to payment page
      context.push(AppRoutePaths.paymentScreen, extra: widget.mentor);
    }
  }

  void previousPage() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        title: "Application",
        onTap: () => previousPage(),
        showDefaultLeading: true,
        topPadding: 10,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.w),
              child: StepIndicator(
                totalSteps: _totalSteps,
                currentStep: _currentStep,
              ),
            ),

            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  //screens
                  const ApplicationForm1(),
                  ApplicationForm2(mentor: widget.mentor),
                  ApplicationForm3(mentor: widget.mentor),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(right: 20.w, left: 20.w, bottom: 32.h),
        child: CustomButton(
          text: _currentStep == _totalSteps - 1 ? "Go to Payment" : "Next",
          onPressed: nextPage,
          backgroundColor: const Color(0xFF89C01C),
          radius: 12,
        ),
      ),
    );
  }
}
