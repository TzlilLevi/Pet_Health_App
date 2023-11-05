import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_health_app/services/auth.dart';

import 'pet_card.dart';
import 'models/pet.dart';
import 'add_pet_dialog.dart';
import 'repository/data_repository.dart';

class HomeList extends StatefulWidget {
  const HomeList({Key? key}) : super(key: key);
  @override
  _HomeListState createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {
  final AuthService _auth = AuthService();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final DataRepository repository = DataRepository();
  final boldStyle =
      const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return _buildHome(context);
  }

  Widget _buildHome(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      body: StreamBuilder<QuerySnapshot>(
          stream: repository.getStream(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const LinearProgressIndicator();

            return _buildList(context, snapshot.data?.docs ?? []);
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          _addPet();
        },
        tooltip: 'Add Pet',
        child: const Icon(Icons.add),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _addPet() {
    showDialog<Widget>(
      context: context,
      builder: (BuildContext context) {
        return const AddPetDialog();
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot) {
    final User? user = auth.currentUser;
    final pet = Pet.fromSnapshot(snapshot);
    if (pet.uid == user!.uid) {
      return PetCard(pet: pet, boldStyle: boldStyle);
    }
    return SizedBox.shrink();
  }
}
