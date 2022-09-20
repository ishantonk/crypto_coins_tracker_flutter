import 'package:crypto_coins_tracker_flutter/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeThemePage extends StatefulWidget {
  const ChangeThemePage({Key? key, required this.themeModeValue})
      : super(key: key);

  final ThemeMode themeModeValue;

  @override
  State<ChangeThemePage> createState() => _ChangeThemePageState();
}

class _ChangeThemePageState extends State<ChangeThemePage> {
  late String _themeModeValue;

  @override
  void initState() {
    if (widget.themeModeValue == ThemeMode.system) {
      _themeModeValue = "system";
    } else if (widget.themeModeValue == ThemeMode.light) {
      _themeModeValue = "light";
    } else {
      _themeModeValue = "dark";
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // title
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Change theme mode",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            ),
            // system mode
            ListTile(
              onTap: () {
                setState(() {
                  _themeModeValue = "system";
                });
                Provider.of<ThemeProvider>(context, listen: false)
                    .changeTheme("system");
              },
              leading: const Icon(Icons.timelapse),
              title: const Text("System Mode"),
              trailing: Radio(
                value: 'system',
                groupValue: _themeModeValue,
                onChanged: (value) {
                  setState(() {
                    _themeModeValue = value!;
                  });
                  Provider.of<ThemeProvider>(context, listen: false)
                      .changeTheme(value);
                },
              ),
            ),
            // light mode
            ListTile(
              onTap: () {
                setState(() {
                  _themeModeValue = "light";
                });
                Provider.of<ThemeProvider>(context, listen: false)
                    .changeTheme("light");
              },
              leading: const Icon(Icons.light_mode_rounded),
              title: const Text("Light Mode"),
              trailing: Radio(
                value: 'light',
                groupValue: _themeModeValue,
                onChanged: (value) {
                  setState(() {
                    _themeModeValue = value!;
                  });
                  Provider.of<ThemeProvider>(context, listen: false)
                      .changeTheme(value);
                },
              ),
            ),
            // dark mode
            ListTile(
              onTap: () {
                setState(() {
                  _themeModeValue = "dark";
                });
                Provider.of<ThemeProvider>(context, listen: false)
                    .changeTheme("dark");
              },
              leading: const Icon(Icons.dark_mode_rounded),
              title: const Text("Dark Mode"),
              trailing: Radio(
                value: 'dark',
                groupValue: _themeModeValue,
                onChanged: (value) {
                  setState(() {
                    _themeModeValue = value!;
                  });
                  Provider.of<ThemeProvider>(context, listen: false)
                      .changeTheme(value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
