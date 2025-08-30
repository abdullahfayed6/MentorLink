import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'mentor_link_app.dart';
import 'src/core/di/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies(baseUrl: "http://mentorlink.runasp.net");
  ScreenUtil.ensureScreenSize();
  runApp(const MentorLinkApp());
}
