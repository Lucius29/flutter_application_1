import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/profile.dart';
import 'package:flutter_application_1/provider/profile_provider.dart';
import 'package:flutter_application_1/screens/detail_profile.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ListProfile extends StatefulWidget {
  const ListProfile({super.key});

  @override
  State<ListProfile> createState() => _ListProfileState();
}

class _ListProfileState extends State<ListProfile> {
  void addItem() {
    final provider = context.read<ProfileProvider>();

    int lastIndex = provider.profiles.length;

    final newProfile = Profile(
      id: lastIndex + 1,
      name: "Astawa ${lastIndex + 1}",
      bio: "Flutter Developer",
    );

    provider.addProfile(newProfile);
  }

  void deleteItem(int id) {
    context.read<ProfileProvider>().deleteProfile(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("List Profile")),

      body: Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
          final profiles = profileProvider.profiles;

          return ListView.builder(
            itemCount: profiles.length,
            itemBuilder: (context, index) {
              final profile = profiles[index];

              return Dismissible(
                key: Key(profile.id.toString()),

                onDismissed: (direction) {
                  final deletedItem = profile;

                  deleteItem(profile.id);

                  Fluttertoast.showToast(msg: "${deletedItem.name} dihapus");
                },

                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundImage: NetworkImage(
                      'https://cdn.rafled.com/anime-icons/images/38a2377321a223af660b401135cc29df4ef2590166f6e3a2abaf9fa448ecd07a.jpg',
                    ),
                  ),

                  title: Text(profile.name),

                  subtitle: Text(profile.bio),

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailProfile(profileId: profile.id),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: addItem,
        child: const Icon(Icons.add),
      ),
    );
  }
}
