import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:share_plus/share_plus.dart';
import '../constant.dart';
import '../contrrol/helpnote.dart';
import 'addnote.dart';
import 'desscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    HelpNote().db.then((value) {
      print("value $value");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "ToDo",
            style: TextStyle(color: textcolor, fontSize: fontLarge),
          ),
          backgroundColor: primarydarkcolor,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(RadiusCircular),
                  bottomRight: Radius.circular(RadiusCircular))),
        ),
        backgroundColor: primarycolor,
        body: Padding(
          padding: const EdgeInsets.all(5.0),
          child: FutureBuilder(
            future: HelpNote().getDB(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                return (snapshot.data.length == 0)
                    ? Center(
                    child: Text(
                      "Take Notes Now ( ^ _ ~ )",
                      style:TextStyle(
                        fontSize: fontXSmall
                      ),
                    )) : ListView.builder(
                     itemCount: snapshot.data.length,
                     itemBuilder: (BuildContext context, int index) {
                      return Slidable(
                      key: const ValueKey(0),
                      endActionPane: ActionPane(
                        motion: ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (val) {
                              setState(() {
                                HelpNote()
                                    .delet_DB_ByID(snapshot.data[index].id);
                              });
                            },
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.black,
                            icon: Icons.delete,
                          ),
                          SlidableAction(
                            onPressed: (val) {
                              Share.share(
                                  """From ToDo App ( ^ _ ' )  ${snapshot.data[index].title} ${snapshot.data[index].date}                             
                                      ${snapshot.data[index].description}""");
                            },
                            backgroundColor: Colors.transparent,
                            foregroundColor: textcolor,
                            icon: Icons.share,
                          ),
                        ],
                      ),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              topLeft: Radius.circular(10),
                            )),
                        elevation: 5,
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(context, CupertinoPageRoute(
                                  builder: (BuildContext context) {
                                    return DescriptionScreen(
                                        id:  "${snapshot.data[index].id}", description:  "${snapshot.data[index].description}",
                                        title:  "${snapshot.data[index].title}", date:  "${snapshot.data[index].date}",
                                        done:  "${snapshot.data[index].done}");
                                  }));
                            },
                            title: Text(
                              "${snapshot.data[index].title}",
                              style: TextStyle(color: textcolor),
                            ),
                            subtitle: Text(
                              "${snapshot.data[index].date}",
                              style: TextStyle(color: textcolor),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return CircularProgressIndicator(
                  backgroundColor: primarycolor,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                );
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (BuildContext context) {
                    return AddNote();
                  }));
            },
            elevation: 5,
            backgroundColor: primarydarkcolor,
            child: Icon(Icons.add, color: textcolor, size: 30),
            ),
        );
    }
}