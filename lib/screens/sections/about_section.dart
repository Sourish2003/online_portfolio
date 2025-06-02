import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:online_portfolio/widgets/animated_container_card.dart';
import 'package:online_portfolio/widgets/section_divider.dart';
import 'package:responsive_framework/responsive_framework.dart';

class AboutSection extends StatelessWidget {
  final bool isDarkMode;

  const AboutSection({
    super.key,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveBreakpoints.of(context).largerThan(TABLET);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionDivider(title: 'About Me', color: Theme.of(context).textTheme.headlineMedium?.color),
        const SizedBox(height: 40),

        // Bio and Skills in a Row/Column based on screen size
        isDesktop
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Bio Column
                  Expanded(
                    flex: 3,
                    child: _buildBio(context),
                  ),
                  const SizedBox(width: 40),
                  // Skills Column
                  Expanded(
                    flex: 2,
                    child: _buildSkills(context),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBio(context),
                  const SizedBox(height: 40),
                  _buildSkills(context),
                ],
              ),

        const SizedBox(height: 60),

        // Education & Experience
        _buildExperience(context),
      ],
    );
  }

  Widget _buildBio(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedContainerCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Who Am I?',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Hello, I am a motivated Software Engineer with a passion for Frontend Development '
                'for both Web and Cross-Platform Apps, along with a strong interest in video editing '
                'and graphics designing.',
            style: theme.textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),
          Text(
            'Currently working as a Flutter Developer at Quantasis, I\'ve been developing '
                'comprehensive healthcare applications using MVVM architecture. Previously, I completed '
                'an 8-month internship at BARC where I worked on real-time object detection using YOLOv8 '
                'and machine learning.',
            style: theme.textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),
          Text(
            'When I\'m not working, you can usually find me enjoying my hobbies. I\'m an avid '
                'video gamer and music listener and love to play basketball in my free time. '
                'Additionally, I am proud to have achieved a Black Belt in Karate.',
            style: theme.textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),
          Text(
            'I am always looking to learn new skills and take on new challenges. I am confident '
                'that my strong work ethic, creativity, and passion will make me a valuable asset to any team.',
            style: theme.textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  Widget _buildSkills(BuildContext context) {
    final theme = Theme.of(context);

    final List<SkillData> skills = [
      SkillData(name: 'Flutter', level: 0.90),
      SkillData(name: 'Dart', level: 0.90),
      SkillData(name: 'Firebase', level: 0.80),
      SkillData(name: 'Python', level: 0.75),
      SkillData(name: 'C++', level: 0.75),
      SkillData(name: 'Machine Learning', level: 0.70),
      SkillData(name: 'YOLOv8', level: 0.70),
      SkillData(name: 'MVVM Architecture', level: 0.65),
      SkillData(name: 'ReactJS', level: 0.60),
      SkillData(name: 'Video Editing', level: 0.70),
    ];

    return AnimatedContainerCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Skills',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.textTheme.headlineMedium?.color,
            ),
          ),
          const SizedBox(height: 24),
          ...List.generate(
            skills.length,
            (index) => AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 600),
              child: SlideAnimation(
                horizontalOffset: 50.0,
                child: FadeInAnimation(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              skills[index].name,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '${(skills[index].level * 100).toInt()}%',
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        SkillProgressBar(
                          level: skills[index].level,
                          color: theme.colorScheme.primary,
                          backgroundColor: isDarkMode
                              ? Colors.white.withValues(alpha: 0.1)
                              : Colors.black.withValues(alpha: 0.1),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExperience(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = ResponsiveBreakpoints.of(context).largerThan(TABLET);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Experience & Education',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.textTheme.headlineMedium?.color,
          ),
        ),
        const SizedBox(height: 24),

        // Experience Timeline
        isDesktop
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Work Experience
                  Expanded(
                    child: _buildTimelineSection(
                      context,
                      'Work Experience',
                      [
                        TimelineItem(
                          title: 'Flutter Developer',
                          organization: 'Quantasis Private Limited',
                          duration: 'Nov 2024 - Present',
                          description:
                          'Developing comprehensive healthcare applications using Flutter with MVVM architecture. '
                              'Implemented secure authentication, video consultation functionality with Jitsi Meet, '
                              'and created robust family profile management systems. Improved user experience by 13%.',
                        ),
                        TimelineItem(
                          title: 'Project Trainee',
                          organization: 'Bhabha Atomic Research Centre (BARC)',
                          duration: 'Sep 2023 - Apr 2024',
                          description:
                          'Developed real-time object detection system using YOLOv8 for industrial environments. '
                              'Achieved 80% accuracy in conveyor belt detection and reduced error margin by 15% '
                              'through camera calibration integration.',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 40),

                  // Education
                  Expanded(
                    child: _buildTimelineSection(
                      context,
                      'Education',
                      [
                        TimelineItem(
                          title: 'Bachelor of Engineering (B.E.)',
                          organization: 'Shah and Anchor Kutchhi Engineering College',
                          duration: '2020 - 2024',
                          description:
                          'Information Technology major with 7.6/9.0 GPA (92%). Relevant coursework included '
                              'DBMS, OOP, Computer Networks, Data Mining and BI, AIDS, and Software Engineering.',
                        ),
                        TimelineItem(
                          title: 'Senior Secondary (Class XII)',
                          organization: 'Ryan International School, Mumbai',
                          duration: '2018 - 2020',
                          description:
                          'CBSE Board - Science stream. Focused on Mathematics and Computer Science.',
                        ),
                        TimelineItem(
                          title: 'Secondary (Class X)',
                          organization: 'Atomic Energy Central School-3',
                          duration: '2010 - 2018',
                          description:
                          'CBSE Board - Achieved strong foundation in Science and Mathematics.',
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Column(
                children: [
                  _buildTimelineSection(
                    context,
                    'Work Experience',
                    [
                      TimelineItem(
                        title: 'Flutter Developer',
                        organization: 'Quantasis Private Limited',
                        duration: 'Nov 2024 - Present',
                        description:
                        'Developing comprehensive healthcare applications using Flutter with MVVM architecture. '
                            'Implemented secure authentication, video consultation functionality with Jitsi Meet, '
                            'and created robust family profile management systems. Improved user experience by 13%.',
                      ),
                      TimelineItem(
                        title: 'Project Trainee',
                        organization: 'Bhabha Atomic Research Centre (BARC)',
                        duration: 'Sep 2023 - Apr 2024',
                        description:
                        'Developed real-time object detection system using YOLOv8 for industrial environments. '
                            'Achieved 80% accuracy in conveyor belt detection and reduced error margin by 15% '
                            'through camera calibration integration.',
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  _buildTimelineSection(
                    context,
                    'Education',
                    [
                      TimelineItem(
                        title: 'Bachelor of Engineering (B.E.)',
                        organization: 'Shah and Anchor Kutchhi Engineering College',
                        duration: '2020 - 2024',
                        description:
                        'Information Technology major with 7.6/9.0 GPA (92%). Relevant coursework included '
                            'DBMS, OOP, Computer Networks, Data Mining and BI, AIDS, and Software Engineering.',
                      ),
                      TimelineItem(
                        title: 'Senior Secondary (Class XII)',
                        organization: 'Ryan International School, Mumbai',
                        duration: '2018 - 2020',
                        description:
                        'CBSE Board - Science stream. Focused on Mathematics and Computer Science.',
                      ),
                      TimelineItem(
                        title: 'Secondary (Class X)',
                        organization: 'Atomic Energy Central School-3',
                        duration: '2010 - 2018',
                        description:
                        'CBSE Board - Achieved strong foundation in Science and Mathematics.',
                      ),
                    ],
                  ),
                ],
              ),
      ],
    );
  }

  Widget _buildTimelineSection(
    BuildContext context,
    String title,
    List<TimelineItem> items,
  ) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: theme.textTheme.headlineMedium?.color,
          ),
        ),
        const SizedBox(height: 24),
        ...List.generate(
          items.length,
          (index) => TimelineItemWidget(
            item: items[index],
            isLast: index == items.length - 1,
            isDarkMode: isDarkMode,
          ),
        ),
      ],
    );
  }
}

class SkillData {
  final String name;
  final double level;

  SkillData({required this.name, required this.level});
}

class SkillProgressBar extends StatelessWidget {
  final double level;
  final Color color;
  final Color backgroundColor;

  const SkillProgressBar({
    super.key,
    required this.level,
    required this.color,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8,
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: level,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}

class TimelineItem {
  final String title;
  final String organization;
  final String duration;
  final String description;

  TimelineItem({
    required this.title,
    required this.organization,
    required this.duration,
    required this.description,
  });
}

class TimelineItemWidget extends StatelessWidget {
  final TimelineItem item;
  final bool isLast;
  final bool isDarkMode;

  const TimelineItemWidget({
    super.key,
    required this.item,
    required this.isLast,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline Node and Line
        Column(
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.colorScheme.primary,
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 120,
                color: isDarkMode
                    ? Colors.white.withValues(alpha: 0.2)
                    : Colors.black.withValues(alpha: 0.1),
              ),
          ],
        ),
        const SizedBox(width: 16),

        // Content
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: AnimatedContainerCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item.title,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 4.0,
                        ),
                        decoration: BoxDecoration(
                          color:
                              theme.colorScheme.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          item.duration,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.organization,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: isDarkMode
                          ? Colors.white.withValues(alpha: 0.7)
                          : Colors.black.withValues(alpha: 0.7),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    item.description,
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
