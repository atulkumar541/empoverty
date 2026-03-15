import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingLarge),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              // Logo/Icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(60),
                ),
                child: const Center(
                  child: Icon(
                    Icons.business,
                    size: 60,
                    color: AppColors.white,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // Title
              Text(
                'EmPoverty',
                style: AppTypography.heading1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              // Subtitle
              Text(
                'Empowering Employment Through Trust & Credibility',
                style: AppTypography.subtitle1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              // Description
              Text(
                'Connect with trusted skilled workers and local businesses. Find reliable services in your area.',
                style: AppTypography.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              CustomButton(
                label: 'Join as Service Provider',
                onPressed: () {
                  Navigator.of(context).pushNamed('/register-worker');
                },
                backgroundColor: AppColors.secondary,
              ),
              const SizedBox(height: 10),
              CustomOutlinedButton(
                label: 'Join as Customer',
                onPressed: () {
                  Navigator.of(context).pushNamed('/home');
                },
              ),
            ],
            ),
          ),
        ),
      ),
    );
  }
}
