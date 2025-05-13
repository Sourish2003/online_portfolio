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
        const SectionDivider(title: 'About Me'),
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
            'I am a passionate software developer with over 5 years of experience in building web and mobile applications. I specialize in frontend development and creating beautiful user interfaces with smooth animations.',
            style: theme.textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),
          Text(
            'My journey in software development began during my college years when I discovered my passion for creating digital experiences that people love to use. Since then, I\'ve worked with various technologies and frameworks to build responsive and user-friendly applications.',
            style: theme.textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),
          Text(
            'When I\'m not coding, you can find me exploring nature, reading books, or learning new technologies to stay updated with the rapidly evolving tech industry.',
            style: theme.textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  Widget _buildSkills(BuildContext context) {
    final theme = Theme.of(context);

    final List<SkillData> skills = [
      SkillData(name: 'Flutter', level: 0.9),
      SkillData(name: 'Dart', level: 0.9),
      SkillData(name: 'React', level: 0.8),
      SkillData(name: 'JavaScript', level: 0.85),
      SkillData(name: 'HTML/CSS', level: 0.95),
      SkillData(name: 'UI/UX Design', level: 0.75),
      SkillData(name: 'Firebase', level: 0.7),
      SkillData(name: 'Node.js', level: 0.6),
    ];

    return AnimatedContainerCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Skills',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
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
                          title: 'Senior Flutter Developer',
                          organization: 'Tech Solutions Inc.',
                          duration: '2021 - Present',
                          description:
                              'Lead developer for multiple mobile applications with complex animations and responsive designs.',
                        ),
                        TimelineItem(
                          title: 'Frontend Developer',
                          organization: 'Web Designs Co.',
                          duration: '2018 - 2021',
                          description:
                              'Developed responsive web applications using React and modern JavaScript.',
                        ),
                        TimelineItem(
                          title: 'Junior Developer',
                          organization: 'Startup Hub',
                          duration: '2016 - 2018',
                          description:
                              'Worked on various web projects using HTML, CSS, and JavaScript.',
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
                          title: 'Master\'s in Computer Science',
                          organization: 'Tech University',
                          duration: '2014 - 2016',
                          description:
                              'Specialized in User Interface Design and Web Technologies.',
                        ),
                        TimelineItem(
                          title: 'Bachelor\'s in Computer Science',
                          organization: 'State University',
                          duration: '2010 - 2014',
                          description:
                              'Graduated with honors. Participated in various coding competitions.',
                        ),
                        TimelineItem(
                          title: 'High School Diploma',
                          organization: 'City High School',
                          duration: '2006 - 2010',
                          description:
                              'Focused on Mathematics and Computer Science.',
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
                        title: 'Senior Flutter Developer',
                        organization: 'Tech Solutions Inc.',
                        duration: '2021 - Present',
                        description:
                            'Lead developer for multiple mobile applications with complex animations and responsive designs.',
                      ),
                      TimelineItem(
                        title: 'Frontend Developer',
                        organization: 'Web Designs Co.',
                        duration: '2018 - 2021',
                        description:
                            'Developed responsive web applications using React and modern JavaScript.',
                      ),
                      TimelineItem(
                        title: 'Junior Developer',
                        organization: 'Startup Hub',
                        duration: '2016 - 2018',
                        description:
                            'Worked on various web projects using HTML, CSS, and JavaScript.',
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  _buildTimelineSection(
                    context,
                    'Education',
                    [
                      TimelineItem(
                        title: 'Master\'s in Computer Science',
                        organization: 'Tech University',
                        duration: '2014 - 2016',
                        description:
                            'Specialized in User Interface Design and Web Technologies.',
                      ),
                      TimelineItem(
                        title: 'Bachelor\'s in Computer Science',
                        organization: 'State University',
                        duration: '2010 - 2014',
                        description:
                            'Graduated with honors. Participated in various coding competitions.',
                      ),
                      TimelineItem(
                        title: 'High School Diploma',
                        organization: 'City High School',
                        duration: '2006 - 2010',
                        description:
                            'Focused on Mathematics and Computer Science.',
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
