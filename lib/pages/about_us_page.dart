import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // title
              const Padding(
                padding:
                    EdgeInsets.only(top: 0, bottom: 16, left: 16, right: 16),
                child: Text(
                  "About us",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
              ),

              // app version
              ListTile(
                onTap: () => {},
                leading: const Icon(Icons.info_rounded),
                title: const Text("App Version"),
                subtitle: const Text("beta 0.1"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
