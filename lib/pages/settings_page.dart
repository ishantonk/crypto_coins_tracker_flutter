import 'package:crypto_coins_tracker_flutter/pages/about_us_page.dart';
import 'package:crypto_coins_tracker_flutter/pages/change_theme_page.dart';
import 'package:crypto_coins_tracker_flutter/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
          child: ListView(
            children: [
              // title
              const Padding(
                padding:
                    EdgeInsets.only(top: 0, bottom: 16, left: 16, right: 16),
                child: Text(
                  "Settings",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
              ),
              // theme mode
              Consumer<ThemeProvider>(
                builder: (context, value, child) {
                  return ListTile(
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangeThemePage(
                            themeModeValue: value.currentThemeMode,
                          ),
                        ),
                      ),
                    },
                    leading: const Icon(Icons.color_lens_rounded),
                    title: const Text("Appearance"),
                    subtitle: const Text("Change theme mode"),
                  );
                },
              ),

              const SizedBox(height: 4),

              // about
              ListTile(
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AboutUsPage()),
                  ),
                },
                leading: const Icon(Icons.help),
                title: const Text("About us"),
                subtitle: const Text("Version 1.0"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
