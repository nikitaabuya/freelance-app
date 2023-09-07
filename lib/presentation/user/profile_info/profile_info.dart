import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/models/users.dart';
import 'package:freelance_app/presentation/global/drawer/global_drawer.dart';
import 'package:freelance_app/services/get_remote_services.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';

import '../../../res/widgets/appbar.dart';
import '../../../res/widgets/text_widget.dart';
import '../dashboard/views/profile_stats.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Users>? users;

  // functions

  Future<void> getInfo() async {
    users = await GetRemoteService().getProfileInfo('email');
    // print('object');
    // print(users?[0].phone);
  }

  @override
  void initState() {
    getInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: const GlobalDrawer(),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            TopAppBar(
              onTap: () => _scaffoldKey.currentState?.openDrawer(),
            ),
          ],
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CircleAvatar(
                                maxRadius: 50.0,
                                backgroundColor: Colors.grey,
                                child: ClipOval(
                                  child: SizedBox(
                                    width:
                                        140.0, // Set a fixed width and height
                                    height: 140.0,
                                    child: CachedNetworkImage(
                                      imageUrl: 'https://shorturl.at/elV34',
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    title: 'John Doe',
                                    size: 16.0,
                                    color: Colors.black,
                                    weight: FontWeight.bold,
                                  ),
                                  CustomText(
                                    title: '@johndoe_',
                                    size: 16.0,
                                    color: Colors.black54,
                                  ),

                                  // review
                                  Row(
                                    children: [
                                      CustomText(
                                        title: '★',
                                        size: 20.0,
                                        color: Color(0xffE1C03F),
                                      ),
                                      CustomText(
                                        title: ' 4.0  (1 Reviews)',
                                        size: 16.0,
                                        color: Colors.black87,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(),
                            ],
                          ),
                          const SizedBox(height: 20.0),
                        ],
                      ),
                    ),

                    // bio
                    const SizedBox(height: 20.0),
                    const CustomText(
                      title: 'About Me',
                      size: 16.0,
                      color: Colors.black87,
                      weight: FontWeight.w600,
                    ),

                    const CustomText(
                      title:
                          'Software Engineer with 5+ years of experience in web development. Passionate about building innovative solutions to real-world problems.',
                      size: 14.0,
                      color: Colors.black54,
                    ),
                    const SizedBox(height: 20.0),

                    // statistics
                    const CustomText(
                      title: 'Your stats so far...',
                      size: 16.0,
                      color: Colors.black87,
                      weight: FontWeight.w600,
                    ),
                    const UserProfileStats(
                      image1: 'contract.svg',
                      image2: 'checked.svg',
                      title1: 'Posted Projects',
                      title2: 'Completed Projects',
                      stat1: '5',
                      stat2: '0',
                    ),

                    // posts

                    const CustomText(
                      title: 'Posts',
                      size: 16.0,
                      color: Colors.black87,
                      weight: FontWeight.w600,
                    ),
                    const SizedBox(height: 20.0),
                    // posts
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Card(
                            color: Colors.amber.shade50,
                            child: const SizedBox(
                              height: 150,
                              width: 300,
                            ),
                          ),
                          Card(
                            color: Colors.red.shade50,
                            child: const SizedBox(
                              height: 150,
                              width: 300,
                            ),
                          ),
                          Card(
                            color: Colors.green.shade50,
                            child: const SizedBox(
                              height: 150,
                              width: 300,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // education
                    const SizedBox(height: 20.0),
                    const CustomText(
                      title: 'Education',
                      size: 16.0,
                      color: Colors.black87,
                      weight: FontWeight.w600,
                    ),
                    const SizedBox(height: 10.0),
                    // education listview

                    // Experience
                    // const SizedBox(height: 20.0),
                    // const CustomText(
                    //   title: 'Experience',
                    //   size: 16.0,
                    //   color: Colors.black87,
                    //   weight: FontWeight.w600,
                    // ),
                    // const SizedBox(height: 10.0),
                    // experience listview

                    // skills
                    const SizedBox(height: 20.0),
                    const CustomText(
                      title: 'Skills',
                      size: 16.0,
                      color: Colors.black87,
                      weight: FontWeight.w600,
                    ),
                    const SizedBox(height: 10.0),
                    // Skills listview

                    //
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
