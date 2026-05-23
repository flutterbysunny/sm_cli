import '../generators/feature_generator.dart';

Future<void> makeFeature({
  required String projectName,
  required String featureName,
}) async {
  generateFeature(
    projectName: projectName,
    featureName: featureName,
  );
}