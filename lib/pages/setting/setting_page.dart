import 'package:flutter/material.dart';
import 'package:spims/common/app_colors.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'General Settings',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            SettingItem(
              title: 'Dark Mode',
              subtitle: 'Enable dark mode for the app',
              trailing: Switch(
                value: true, // Replace with your dark mode state
                onChanged: (value) {
                  // Implement dark mode toggling logic
                },
              ),
            ),
            SettingItem(
              title: 'Notifications',
              subtitle: 'Receive app notifications',
              trailing: Switch(
                value: true, // Replace with your notifications state
                onChanged: (value) {
                  // Implement notifications toggling logic
                },
              ),
            ),
            SettingItem(
              title: 'Sound Effects',
              subtitle: 'Enable sound effects',
              trailing: Switch(
                value: true, // Replace with your sound effects state
                onChanged: (value) {
                  // Implement sound effects toggling logic
                },
              ),
            ),
            SettingItem(
              title: 'Language',
              subtitle: 'Select app language',
              trailing: DropdownButton<String>(
                value: 'English', // Replace with your language value
                onChanged: (newValue) {
                  // Implement language selection logic
                },
                items: const [
                  DropdownMenuItem<String>(
                    value: 'English',
                    child: Text('English'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Spanish',
                    child: Text('Spanish'),
                  ),
                  // Add more language options as needed
                ],
              ),
            ),
            const Divider(height: 32, thickness: 1, color: Colors.grey),
            const Text(
              'Account Settings',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: const [
                ChangePasswordTile(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SettingItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? trailing;

  SettingItem({
    required this.title,
    required this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontSize: 18, color: Colors.black),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          color: Colors.grey,
        ),
      ),
      trailing: trailing,
    );
  }
}

class ChangePasswordTile extends StatefulWidget {
  const ChangePasswordTile({Key? key}) : super(key: key);

  @override
  _ChangePasswordTileState createState() => _ChangePasswordTileState();
}

class _ChangePasswordTileState extends State<ChangePasswordTile> {
  TextEditingController originalPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isPasswordVisible = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: AppColor.background, // Set the color of the card to AppColor.white
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(0), // Remove the round shape of the card
      ),
      child: ExpansionTile(
        key: UniqueKey(),
        title: const Text(
          'Change Password',
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: originalPasswordController,
                  obscureText: !isPasswordVisible,
                  decoration: const InputDecoration(
                      labelText: 'Original Password',
                      labelStyle: TextStyle(color: AppColor.grey)),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: newPasswordController,
                  obscureText: !isPasswordVisible,
                  decoration: const InputDecoration(
                      labelText: 'New Password',
                      labelStyle: TextStyle(color: AppColor.grey)),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: !isPasswordVisible,
                  decoration: const InputDecoration(
                      labelText: 'Confirm New Password',
                      labelStyle: TextStyle(color: AppColor.grey)),
                ),
                if (errorMessage.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Text(
                    errorMessage,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Show Password'),
                    Switch(
                      value: isPasswordVisible,
                      onChanged: (value) {
                        setState(() {
                          isPasswordVisible = value;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    final originalPassword = originalPasswordController.text;
                    final newPassword = newPasswordController.text;
                    final confirmPassword = confirmPasswordController.text;
                    if (newPassword == confirmPassword) {
                      // Passwords match, implement the change logic
                      // You can also validate password strength here

                      // Reset error message
                      setState(() {
                        errorMessage = '';
                      });
                    } else {
                      // Passwords don't match, show an error message
                      setState(() {
                        errorMessage = 'Passwords do not match';
                      });
                    }
                  },
                  child: const Text('Change Password'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
