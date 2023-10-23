import 'package:url_launcher/url_launcher.dart';

void sendEmail(String email) async {
  final Uri emailUri = Uri(
    scheme: 'mailto',
    path: email,
  );
  if (await canLaunchUrl(emailUri)) {
    await launchUrl(emailUri);
  } else {
    throw 'Could not launch email client';
  }
}

void callPhone(String phone) async {
  final Uri phoneUri = Uri(
    scheme: 'tel',
    path: phone,
  );
  if (await canLaunchUrl(phoneUri)) {
    await launchUrl(phoneUri);
  } else {
    throw 'Could not launch phone dialer';
  }
}
