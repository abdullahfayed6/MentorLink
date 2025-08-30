// Defines the data model for an onboarding page item.
class OnboardingItem {
  final String asset;
  final String title;
  final String subtitle;
  final String? highlight;
  const OnboardingItem({
    required this.asset,
    required this.title,
    required this.subtitle,
    this.highlight,
  });
}
