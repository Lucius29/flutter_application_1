import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/profile_provider.dart';
import 'package:flutter_application_1/screens/edit_profile.dart';
import 'package:provider/provider.dart';

class DetailProfile extends StatelessWidget {
  final int profileId;

  const DetailProfile({super.key, required this.profileId});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, provider, child) {
        final profile = provider.getProfileById(profileId);

        return Scaffold(
          appBar: AppBar(title: const Text("Detail Profile")),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 300,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        height: 200,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/wp.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 110,
                        child: CircleAvatar(
                          radius: 80,
                          backgroundImage: NetworkImage(
                            "https://icon-icons.com/download-file?file=https%3A%2F%2Fimages.icon-icons.com%2F2620%2FPNG%2F512%2Famong_us_player_red_icon_156942.png&id=156942&pack_or_individual=pack",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  profile.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(profile.bio, style: const TextStyle(fontSize: 18)),

                const SizedBox(height: 8),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "desc28",
                    textAlign: TextAlign.justify,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),

                const SizedBox(height: 24),

                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Back"),
                ),

                const SizedBox(height: 8),

                ElevatedButton(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfile(profile: profile),
                      ),
                    );
                  },
                  child: const Text("Edit Profile"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
