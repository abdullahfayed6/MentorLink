import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';
import 'package:mentor_link/src/features/profile/presentation/widgets/camera_option_button.dart';

class EditAvatar extends StatelessWidget {
  const EditAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          // Outer circle with border
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: context.colorScheme.primary, width: 3),
            ),
            child: CircleAvatar(
              radius: 60.r,
              backgroundImage: const AssetImage(
                "assets/images/default_profile_image.png",
              ),
            ),
          ),

          // Edit button
          CircleAvatar(
            radius: 18.r,
            backgroundColor: context.colorScheme.primary,
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(Icons.edit_outlined, size: 16.sp, color: Colors.black),
              onPressed: () async {
                final RenderBox button =
                context.findRenderObject() as RenderBox;
                final RenderBox overlay =
                Overlay.of(context).context.findRenderObject() as RenderBox;
                final Offset position =
                button.localToGlobal(Offset.zero, ancestor: overlay);

                await showMenu(
                color: context.colorScheme.surface,
                  context: context,
                  position: RelativeRect.fromLTRB(
                    position.dx, //in the same of the avatar postion
                    position.dy + 120, // under the avatar
                    position.dx + button.size.width,
                    0,
                  ),
                  items: [
                    PopupMenuItem(
                      padding: EdgeInsets.zero,
                      child: Center(
                        child: CameraOptionButton(
                          text: "Take using camera",
                          icon: Icons.camera_alt_outlined,
                          onTap: () {
                            context.pop();
                            //  implementation for pick image from camera
                          },
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      padding: EdgeInsets.zero,
                      child: Center(
                        child: CameraOptionButton(
                          text: "Upload from files",
                          icon: Icons.upload_file_outlined,
                          onTap: () {
                            context.pop();
                            // implementation for upload image as file
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
