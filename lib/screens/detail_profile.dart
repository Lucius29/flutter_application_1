import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/profile.dart';
import 'package:flutter_application_1/screens/edit_profile.dart';

class DetailProfile extends StatefulWidget {
  const DetailProfile({super.key, required this.profile});

  final Profile profile;

  @override
  State<DetailProfile> createState() => _DetailProfileState();
}

class _DetailProfileState extends State<DetailProfile> {
  late String nama;
  bool isChange = true;
  @override
  void initState() {
    super.initState();
    nama = widget.profile.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail Profile")),
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
                    decoration: BoxDecoration(
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
                      backgroundImage: Image.network(
                        "https://icon-icons.com/download-file?file=https%3A%2F%2Fimages.icon-icons.com%2F2620%2FPNG%2F512%2Famong_us_player_red_icon_156942.png&id=156942&pack_or_individual=pack",
                      ).image,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),

            Text(
              widget.profile.name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              widget.profile.bio,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w100),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                widget.profile.desc28,
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                isChange = !isChange;
                if (isChange) {
                  setState(() {
                    nama = "Astawa";
                  });
                } else {
                  setState(() {
                    nama = "I Wayan Astawa Putra";
                  });
                }
              },
              child: Text("Change name"),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Back to Home"),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                final Profile? updateProfile = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfile(profile: widget.profile),
                  ),
                );
                if (updateProfile != null) {
                  setState(() {
                    widget.profile.name = updateProfile.name;
                    widget.profile.bio = updateProfile.bio;
                    widget.profile.desc28 = updateProfile.desc28;
                  });

                  Navigator.pop(context, widget.profile);
                }
              },
              child: Text("Edit Profile"),
            ),
          ],
        ),
      ),
    );
  }
}
