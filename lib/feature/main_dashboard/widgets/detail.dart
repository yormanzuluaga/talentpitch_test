import 'package:talentpitch_ui/talentpitch_ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:talentpitch_test/app/routes/routes_names.dart';

class Detail extends StatelessWidget {
  const Detail({
    super.key,
    required this.id,
    required this.title,
    required this.email,
    required this.phone,
  });

  final String title;
  final String id;
  final String email;
  final String phone;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.go(RoutesNames.home);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
        centerTitle: true,
        title: Text(
          title,
          style: UITextStyle.titles.title2Medium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Nombre: ',
                  style: UITextStyle.titles.title3Medium,
                ),
                Text(
                  title,
                  style: UITextStyle.paragraphs.paragraph1Regular,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Email: ',
                  style: UITextStyle.titles.title3Medium,
                ),
                Text(
                  email,
                  style: UITextStyle.paragraphs.paragraph1Regular,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Telefono: ',
                  style: UITextStyle.titles.title3Medium,
                ),
                Text(
                  phone,
                  style: UITextStyle.paragraphs.paragraph1Regular,
                ),
              ],
            ),
            SizedBox(
              height: AppSpacing.md,
            ),
          ],
        ),
      ),
    );
  }
}
