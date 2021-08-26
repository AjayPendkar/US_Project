import 'package:flutter/material.dart';
import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  var _caseName;
  var _location;
  var _descriptionOfComplaint;
  String image;
  List<String> _towncase = [];
  List<String> _finished = [];
  TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  Widget _build__caseList() {
    return new ListView.builder(
      itemBuilder: (context, index) {
        if (index < _towncase.length) {
          return _build__caseItem(_towncase[index], index);
        }
      },
    );
  }

  Widget _build__caseItem(String __caseText, int index) {
    return Container(
      child: Card(
        elevation: 5.0,
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Column(
          children: [
            Container(
              child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                leading: Container(
                  padding: EdgeInsets.only(right: 12.0),
                  decoration: BoxDecoration(
                      border: Border(
                          right:
                              BorderSide(width: 1.0, color: Colors.black87))),
                  child: Icon(
                    Icons.kitchen,
                    color: Colors.black87,
                  ),
                ),
                title: Text(__caseText),
                subtitle: Row(
                  children: <Widget>[Icon(Icons.linear_scale), Text("$index")],
                ),
                trailing: IconButton(
                  color: Colors.green,
                  onPressed: () {
                    _finishedItem(__caseText);
                  },
                  icon: Icon(Icons.check_circle),
                ),
                onLongPress: () => _promptRemove__caseItem(index),
              ),
            ),
            InkWell(
              onTap: () {
                show_Complaint(context);
              },
              child: Container(
                child: Row(
                  children: [
                    Icon(
                      Icons.home,
                      color: Colors.black87,
                    ),
                    Text("Open Comaplaint")
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFinishedList() {
    return new ListView.builder(
      itemBuilder: (context, index) {
        if (index < _finished.length) {
          return _build__caseItem(_finished[index], index);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        bottom: TabBar(
          isScrollable: true,
          tabs: <Widget>[
            Tab(
              text: "complaint".toUpperCase(),
              icon: Icon(Icons.playlist_add),
            ),
            Tab(
              text: "Case Compleated".toUpperCase(),
              icon: Icon(Icons.playlist_add_check),
            )
          ],
          controller: _tabController,
          labelColor: Colors.white,
          indicatorColor: Colors.black87,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[_build__caseList(), _buildFinishedList()],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: pushAdd__case_Screen,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void pushAdd__case_Screen() {
    final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("case Registration".toUpperCase()),
        ),
        body: Container(
          child: Form(
            key: _formkey,
            child: Center(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Case Name',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(),
                            borderRadius: BorderRadius.circular(25.0))),
                    onSaved: (val) {
                      _caseName = val;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'location',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(),
                            borderRadius: BorderRadius.circular(25.0))),
                    onSaved: (val) {
                      _location = val;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Case Description',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(),
                            borderRadius: BorderRadius.circular(25.0))),
                    onSaved: (val) {
                      _descriptionOfComplaint = val;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RaisedButton(
                    child: Text("Submit"),
                    onPressed: () {
                      _formkey.currentState.save();
                      _add__caseItem(
                        _caseName,
                      );

                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }));
  }

  void _add__caseItem(String _case) {
    if (_case.length > 0) {
      setState(() => _towncase.add(_case));
      print(_case);
    }
  }

  void _finishedItem(String _case) {
    _remove__caseItem(_case);
    if (_case.length > 0) {
      setState(() {
        _finished.add(_case);
      });
    }
  }

  void _remove__caseItem(String _case) {
    setState(() => _towncase.remove(_case));
  }

  show_Complaint(context) {
    showAdaptiveActionSheet(
      context: context,
      title: Column(
        children: [
          Text("GHMC COMPLAINTS"),
          Divider(
            height: 20,
            thickness: 5,
            indent: 20,
            endIndent: 20,
          ),
        ],
      ),
      actions: <BottomSheetAction>[
        BottomSheetAction(title: Text(_caseName), onPressed: () {}),
        BottomSheetAction(title: Text(_location), onPressed: () {}),
        BottomSheetAction(
            title: Text(
              _descriptionOfComplaint,
              style: TextStyle(fontSize: 12),
            ),
            onPressed: () {}),
        // BottomSheetAction(title: Text(_location), onPressed: () {}),
      ],
    );
  }

  void _promptRemove__caseItem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("REMOVE the CASE '${_towncase[index]}' from the list?"),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Delete'),
                onPressed: () {
                  _remove__caseItem(_towncase[index]);
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      title: const Text('Popup example'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Hello"),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Close'),
        ),
      ],
    );
  }
}
