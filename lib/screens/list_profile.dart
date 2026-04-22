import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/profile.dart';
import 'package:flutter_application_1/screens/detail_profile.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ListProfile extends StatefulWidget {
  const ListProfile({super.key});

  @override
  State<ListProfile> createState() => _ListProfileState();
}

class _ListProfileState extends State<ListProfile> {
  List<Profile> profiles = [];

  void addItem() {
    setState(() {
      int counter = 0;
      counter = counter + 1;
      profiles.add(
        Profile(
          id: counter,
          name: "Astawa ${counter}",
          bio: "Junior Developer",
        ),
      );
    });
  }

  void deleteItem(int index) {
    setState(() {
      profiles.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("List Profile")),
      body: ListView.builder(
        itemCount: profiles.length,
        itemBuilder: (context, index) {
          final profile = profiles[index];
          return Dismissible(
            key: Key(profile.id.toString()),
            onDismissed: (direction) {
              final deletedItem = profiles[index];
              deleteItem(index);
              Fluttertoast.showToast(msg: "${deletedItem.name} dihapus");
            },
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://cdn.rafled.com/anime-icons/images/38a2377321a223af660b401135cc29df4ef2590166f6e3a2abaf9fa448ecd07a.jpg',
                ),
              ),
              title: Text(profile.name),
              subtitle: Text(profile.bio),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailProfile(profile: profile),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addItem();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
