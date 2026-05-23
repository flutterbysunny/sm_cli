import '../generators/feature_generator.dart';
import '../generators/api_generator.dart';

Future<void> makeFeature({
  required String projectName,
  required String featureName,
}) async {
  generateFeature(
    projectName: projectName,
    featureName: featureName,
  );
}

Future<void> makeApi({required String projectName}) async {
  await generateApi(projectName: projectName);
}
