import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:radiosai/constants/constants.dart';

class StreamSelect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      margin: const EdgeInsets.all(0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            SizedBox(height: 12),
            DraggingHandle(),
            SizedBox(height: 8),
            Text(
              'Select Stream',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            StreamList(),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

class DraggingHandle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5,
      width: 30,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}

class StreamList extends StatefulWidget {
  StreamList({Key key}) : super(key: key);

  @override
  _StreamList createState() => _StreamList(); 
}

class _StreamList extends State<StreamList> {

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<int> _streamIndex;

  @override
  void initState() {
    super.initState();
    _streamIndex = _prefs.then((SharedPreferences prefs) {return (prefs.getInt('stream') ?? 0);});
  }

  Future<void> setStream(int index) async {
    final SharedPreferences prefs = await _prefs;
    final int streamIndex = index;
    setState(() {
      _streamIndex = prefs.setInt('stream', streamIndex).then((bool success) {
        return streamIndex;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 5/4,
      ),
      itemCount: MyConstants.of(context).streamName.length,
      primary: false,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.all(8),
          child: GestureDetector(
            onTap: () async {
            // TODO: add the stream
            setStream(index);
            // print(index);
          },
            child: Card(
                child: Text(MyConstants.of(context).streamName[index]),
              ),
            ),
        );
      },
    );
  }
}
