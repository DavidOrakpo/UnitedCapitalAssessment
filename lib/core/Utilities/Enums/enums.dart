// ignore_for_file: unused_field

enum RiskLevel {
  Low(
    title: 'Low',
  ),
  Medium(
    title: 'Medium',
  ),
  High(
    title: 'High',
  ),
  ;

  const RiskLevel({required this.title});
  final String title;
}
