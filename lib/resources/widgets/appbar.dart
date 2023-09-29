import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelance_app/resources/constants/colors.dart';

class TopAppBar extends StatefulWidget {
  const TopAppBar({super.key, required this.onTap});
  final void Function() onTap;

  @override
  State<TopAppBar> createState() => _TopAppBarState();
}

class _TopAppBarState extends State<TopAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: 70.0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: SvgPicture.network(
            'https://demoapus1.com/freeio/wp-content/themes/freeio/images/logo.svg'),
      ),
      leadingWidth: 120.0,
      actions: [
        const SizedBox(width: 15.0),
        IconButton(
          onPressed: widget.onTap,
          icon: SvgPicture.asset(
              'lib/resources/assets/icons/menu-strawberry.svg'),
        ),
        const SizedBox(width: 8.0),
      ],
    );
  }
}

class JobAppBar extends StatefulWidget {
  const JobAppBar({super.key, required this.onTap});
  final void Function() onTap;

  @override
  State<JobAppBar> createState() => _JobAppBarState();
}

class _JobAppBarState extends State<JobAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: JobCustomColors.primaryBackground,
      toolbarHeight: 70.0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: SvgPicture.network(
          'https://demoapus1.com/freeio/wp-content/themes/freeio/images/logo.svg',
        ),
      ),
      leadingWidth: 120.0,
      actions: [
        const SizedBox(width: 15.0),
        IconButton(
          onPressed: widget.onTap,
          icon: SvgPicture.asset(
              'lib/resources/assets/icons/menu-strawberry.svg'),
        ),
        const SizedBox(width: 8.0),
      ],
    );
  }
}
