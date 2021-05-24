import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:radiosai/constants/constants.dart';
import 'package:radiosai/screens/radio_schedule/radio_schedule.dart';
import 'package:radiosai/screens/sai_inspires/sai_inspires.dart';
import 'package:radiosai/screens/settings/settings.dart';
import 'package:radiosai/widgets/browser.dart';

class TopMenu extends StatefulWidget {
  TopMenu({
    Key key,
  }) : super(key: key);

  @override
  _TopMenu createState() => _TopMenu();
}

class _TopMenu extends State<TopMenu> {
  @override
  Widget build(BuildContext context) {
    double topPadding = MediaQuery.of(context).padding.top + 5;
    double rightPadding = MediaQuery.of(context).size.width * 0.02;
    List<String> menuTitles = MyConstants.of(context).menuTitles;
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: EdgeInsets.only(
          top: topPadding,
          right: rightPadding,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Material(
            color: Colors.transparent,
            child: PopupMenuButton<String>(
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              iconSize: 30,
              offset: const Offset(-10, 10),
              itemBuilder: (context) {
                // Takes list of data from constants
                return menuTitles.map<PopupMenuEntry<String>>((value) {
                  return PopupMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                    ),
                  );
                }).toList();
              },
              onSelected: (value) {
                switch (value) {
                  // TODO: don't hardcode this and maybe add enum
                  case 'Sai Inspires':
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SaiInspires()));
                    break;
                  case 'Settings':
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Settings()));
                    break;
                  case 'Schedule':
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => RadioSchedule()));
                    break;
                  case 'Audio Archive':
                    Browser.launchURL(context,
                        "https://media.radiosai.org/journals/Archives/audio_downloads/downloads_2013.htm");
                    break;
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
