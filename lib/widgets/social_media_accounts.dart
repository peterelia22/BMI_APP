import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaAccounts extends StatelessWidget {
  const SocialMediaAccounts({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(FontAwesomeIcons.facebookF, color: Colors.blue),
          onPressed: () => _launchURL(
              'https://www.facebook.com/profile.php?id=100008335519291'),
        ),
        const SizedBox(width: 20),
        IconButton(
          icon: const Icon(FontAwesomeIcons.github, color: Colors.black),
          onPressed: () => _launchURL('https://github.com/peterelia22'),
        ),
        const SizedBox(width: 20),
        IconButton(
          icon: const Icon(FontAwesomeIcons.linkedinIn, color: Colors.blue),
          onPressed: () =>
              _launchURL('https://www.linkedin.com/in/peter-elia-648485240/'),
        ),
      ],
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      print('Could not launch $url');
    }
  }
}
