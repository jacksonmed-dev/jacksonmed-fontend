import 'package:flutter/material.dart';

import 'patient_view.dart';
import 'patient_form.dart';
import 'patients.dart';

class FacilityView extends StatefulWidget {
  const FacilityView({super.key});

  @override
  State<FacilityView> createState() => _FacilityViewState();
}

class _FacilityViewState extends State<FacilityView> {
  final facilityName = 'Jackson Medical Solutions';
//  List<User> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            facilityName,
          ),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: 0,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 50,
            color: Colors.blue,
            child: null,
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const PatientForm();
              },
            ),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.person_add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}


//DraggableScrollableSheet would be fantastic for the facility grid view,
//otherwise, we would have to do filtering options...
//>> filter by: fname, lname, bday (age), brisk, frisk, room#, even length of
//stay or weight... but those last 2 probably would not be approrpiate for the
//context https://docs.flutter.dev/development/ui/widgets/interaction

//silvers are extremely neat too, check out CustomScrollView
//https://api.flutter.dev/flutter/widgets/CustomScrollView-class.html


/*
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: name.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 256,
            color: Color.lerp(Colors.green, Colors.red, bRisk[index]),
            child: Row(
              children: [
                Container(
                  color: Colors.grey,
                  width: 128,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Icon(
                        Icons.image,
                        size: 128,
                      ),
                      Text(
                        name[index],
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Icon(Icons.favorite),
                        Text('${hr[index]}', textAlign: TextAlign.center),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Icon(Icons.account_circle),
                        Text('${rr[index]}', textAlign: TextAlign.center),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
      */