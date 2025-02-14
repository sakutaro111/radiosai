import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Settings Section - used in settings page
///
/// [title] - title of the section
///
/// [child] - the content of the section
class SettingsSection extends StatelessWidget {
  const SettingsSection({Key key, this.title, this.child}) : super(key: key);

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // check if dark theme
    bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Card(
        elevation: 0.2,
        color: isDarkTheme ? Colors.grey[800] : Colors.grey[200],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
              child: Text(
                title,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
