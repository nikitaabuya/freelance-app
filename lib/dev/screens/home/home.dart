import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freelance_app/dev/screens/home/widgets/blog.dart';
import 'package:freelance_app/dev/screens/home/widgets/category.dart';
import 'package:freelance_app/dev/screens/home/widgets/search.dart';
import 'package:freelance_app/dev/screens/home/widgets/services.dart';
import 'package:freelance_app/dev/screens/home/widgets/static_section.dart';
import 'package:freelance_app/dev/screens/home/widgets/static_section1.dart';
import 'package:freelance_app/dev/screens/home/widgets/stats.dart';
import 'package:freelance_app/dev/screens/home/widgets/testimonial.dart';
import 'package:freelance_app/dev/screens/home/widgets/trending_service.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70.0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: SvgPicture.network(
                'https://demoapus1.com/freeio/wp-content/themes/freeio/images/logo.svg'),
          ),
          leadingWidth: 120.0,
          actions: [
            Text(
              'Login',
              style: GoogleFonts.lato(
                fontSize: 14.0,
                color: Colors.black87,
              ),
            ),
            const SizedBox(width: 25.0),
            const Icon(Icons.menu),
            const SizedBox(width: 8.0),
          ],
        ),
        body: Container(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          color: Colors.grey.shade200,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const HomeWidget1(),
                const SizedBox(height: 20.0),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Browse talent by category',
                          style: GoogleFonts.roboto(
                            fontSize: 23.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          'Get some Inspirations from 1800+ skills',
                          style: GoogleFonts.roboto(
                            fontSize: 13.0,
                          ),
                        ),
                        Text(
                          'All Categories',
                          style: GoogleFonts.roboto(
                            fontSize: 13.0,
                          ),
                        ),
                        // first-category
                        const SizedBox(height: 24.0),
                        const CategorySpace(
                          iconAsset1: 'coding.svg',
                          services1: '8 Services',
                          title1: 'Development & IT',
                          // ----------
                          iconAsset2: 'graphic-design.svg',
                          services2: '1 Services',
                          title2: 'Design & Creative',
                        ),
                        // second-category
                        const SizedBox(height: 24.0),
                        const CategorySpace(
                          iconAsset1: 'digital-marketing.svg',
                          services1: '8 Services',
                          title1: 'Digital Marketing',
                          // ----------
                          iconAsset2: 'translation.svg',
                          services2: '1 Services',
                          title2: 'Writing & Translation',
                        ),
                        // third-category
                        const SizedBox(height: 24.0),
                        const CategorySpace(
                          iconAsset1: 'microphone.svg',
                          services1: '0 Services',
                          title1: 'Music & Audio',
                          // ----------
                          iconAsset2: 'video.svg',
                          services2: '0 Services',
                          title2: 'Video & Animation',
                        ),
                        // fourth-category
                        const SizedBox(height: 24.0),
                        const CategorySpace(
                          iconAsset1: 'programming.svg',
                          services1: '1 Services',
                          title1: 'Programming & Tech',
                          // ----------
                          iconAsset2: 'graph.svg',
                          services2: '4 Services',
                          title2: 'Finance & Accounting',
                        ),
                        const SizedBox(height: 24.0),
                        const TrendingSection(),
                        const SizedBox(height: 24.0),
                      ],
                    ),
                  ),
                ),
                const ServicesPage(),
                const SizedBox(height: 24.0),
                const StaticSectionOne(),
                SizedBox(
                  child: CachedNetworkImage(
                      imageUrl:
                          'https://demoapus1.com/freeio/wp-content/uploads/2022/09/h1.jpg'),
                ),
                const SizedBox(height: 24.0),
                const StatsApp(),
                const SizedBox(height: 24.0),
                const TestimonialSection(),
                const SizedBox(height: 24.0),
                const StaticSectionTwo(),
                const SizedBox(height: 24.0),
                const BlogSection(),
                const SizedBox(height: 24.0),
                Container(
                  color: const Color(0xffffede8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 24.0),
                        Text(
                          'Find the talent needed to get your business growing.',
                          style: GoogleFonts.roboto(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 24.0),
                        Text(
                          'Advertise your jobs to millions of monthly users and search 15.8 million CVs',
                          style: GoogleFonts.roboto(
                              fontSize: 14.0, color: Colors.black87),
                        ),
                        const SizedBox(height: 24.0),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            height: 50.0,
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: ElevatedButton.icon(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff1f4b3f),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.north_east,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  'Find Talent',
                                  style: GoogleFonts.roboto(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30.0),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
