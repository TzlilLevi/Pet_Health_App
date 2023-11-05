import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_health_app/general/add_statics_weight.dart';
import 'package:pet_health_app/models/pet.dart';
import 'package:pet_health_app/models/weight.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class StaticsWeight extends StatefulWidget {
  final Pet pet;
  final String subject;
  const StaticsWeight({Key? key, required this.pet, required this.subject})
      : super(key: key);

  @override
  State<StaticsWeight> createState() => _StaticsWeightState();
}

class _StaticsWeightState extends State<StaticsWeight> {
  late DateFormat dateFormat = DateFormat('dd-MM-yyyy');
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: StreamBuilder<List<Weight>>(
              stream: FirebaseFirestore.instance
                  .collection('pet')
                  .doc(widget.pet.referenceId)
                  .snapshots()
                  .map((doc) => Pet.fromJson(doc.data() ?? {}))
                  .map((pet) => pet.weight!),
              builder: (context, snapshot) {
                if (snapshot.data == null)
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.red,
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.teal),
                    ),
                  );

                return Column(
                  children: [
                    Container(
                        width: double.infinity,
                        height: 350,
                        child: SfCartesianChart(
                          primaryXAxis: DateTimeAxis(),
                          series: <ChartSeries<Weight, DateTime>>[
                            LineSeries<Weight, DateTime>(
                              dataSource: snapshot.data!,
                              xValueMapper: (Weight weight, _) => weight.date,
                              yValueMapper: (Weight weight, _) => weight.weight,
                            )
                          ],
                        )),
                    Container(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.weight,
                            color: Colors.blueAccent,
                          ),
                          Text(
                            '   ' + widget.pet.name + '\'s weights',
                            style: TextStyle(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => Divider(
                          height: 2.0,
                          color: Colors.black87,
                        ),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final item = snapshot.data![index].weight;
                          return Dismissible(
                              key: UniqueKey(),
                              background: Container(
                                color: Colors.red,
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(Icons.delete, color: Colors.white),
                                      Text('Delete',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ],
                                  ),
                                ),
                              ),
                              confirmDismiss:
                                  (DismissDirection direction) async {
                                if (direction == DismissDirection.endToStart) {
                                  return await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title:
                                            const Text("Delete Confirmation"),
                                        content: const Text(
                                            "Are you sure you want to delete this weight?"),
                                        actions: <Widget>[
                                          FlatButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(true),
                                              child: const Text("Delete")),
                                          FlatButton(
                                            onPressed: () =>
                                                Navigator.of(context)
                                                    .pop(false),
                                            child: const Text("Cancel"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                              onDismissed: (direction) async {
                                try {
                                  await FirebaseFirestore.instance
                                      .collection('pet')
                                      .doc(widget.pet.referenceId)
                                      .update(
                                    {
                                      'weight': FieldValue.arrayRemove(
                                        [
                                          snapshot.data!
                                              .removeAt(index)
                                              .toJson()
                                        ],
                                      )
                                    },
                                  );
                                } catch (e) {
                                  print(e);
                                }
                                widget.pet.weight!.removeAt(index);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('$item deleted')));
                              },
                              child: ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(children: [
                                      //height: 40.0,
                                      Icon(
                                        FontAwesomeIcons.checkCircle,
                                        color: Colors.green,
                                        size: 18,
                                      ),

                                      Text(
                                          "  " +
                                              'weight: ' +
                                              item.toString() +
                                              ' kg',
                                          style: TextStyle(
                                            color:
                                                Color.fromARGB(221, 61, 61, 61),
                                            fontWeight: FontWeight.normal,
                                            fontSize: 16,
                                          )),
                                    ]),
                                    Text(
                                        '\n' +
                                            dateFormat.format(
                                                snapshot.data![index].date),
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                221, 99, 99, 99)))
                                  ],
                                ),
                                // title: Text(
                                //     'weight: ' + item.toString() + ' kg'),
                                // subtitle: Text('\n' +
                                //     dateFormat.format(
                                //         snapshot.data![index].date))
                              ));
                        },
                      ),
                      //)
                      //],
                    )
                  ],
                );
              }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AddStaticsWeight(pet: widget.pet);
            },
          ),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
