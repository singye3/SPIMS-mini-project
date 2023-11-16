import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

Future<void> sendEmail(String email, String username, String password) async {
  const smtpUsername = 'your_smtp_username';
  const smtpPassword = 'your_smtp_password';

  final smtpServer = SmtpServer('smtp.example.com',
      username: smtpUsername, password: smtpPassword);

  final message = Message()
    ..from = const Address(smtpUsername)
    ..recipients.add(email)
    ..subject = 'Account Credentials'
    ..text = 'Username: $username\nPassword: $password';

  try {
    final sendReport = await send(message, smtpServer);
    print('Email sent successfully: ${sendReport.toString()}');
  } catch (e) {
    print('Error sending email: $e');
  }
}
