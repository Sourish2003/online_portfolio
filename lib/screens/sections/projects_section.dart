import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:online_portfolio/constants/imageconstants.dart';
import 'package:online_portfolio/widgets/animated_container_card.dart';
import 'package:online_portfolio/widgets/section_divider.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ProjectsSection extends StatelessWidget {
  final bool isDarkMode;

  const ProjectsSection({
    super.key,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionDivider(title: 'Projects', color: Theme.of(context).textTheme.headlineMedium?.color),
        const SizedBox(height: 40),

        Text(
          'Some of my recent work',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.textTheme.headlineMedium?.color,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Here are some of the projects I\'ve worked on. Click on a project to see more details.',
          style: theme.textTheme.bodyLarge,
        ),
        const SizedBox(height: 40),

        // Featured Project
        FeaturedProject(isDarkMode: isDarkMode),
        const SizedBox(height: 60),

        // Project Grid
        ProjectGrid(isDarkMode: isDarkMode),
      ],
    );
  }
}

class FeaturedProject extends StatelessWidget {
  final bool isDarkMode;

  const FeaturedProject({
    super.key,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveBreakpoints.of(context).largerThan(TABLET);

    return AnimatedContainerCard(
      height: null,
      padding: EdgeInsets.zero,
      child: isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Project Image (Left)
                Expanded(
                  flex: 3,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                    child: Image.asset(
                      ImageConstants.project1,
                      height: 400,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Project Details (Right)
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: _buildProjectDetails(context),
                  ),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Project Image (Top)
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: Image.asset(
                    ImageConstants.project1,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                // Project Details (Bottom)
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: _buildProjectDetails(context),
                ),
              ],
            ),
    );
  }

  Widget _buildProjectDetails(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 6.0,
          ),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'Featured Project',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Food Fitness Healthcare Apps',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.textTheme.headlineMedium?.color,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Comprehensive healthcare applications for doctors and patients with MVVM architecture. '
              'Features include secure OTP authentication, JWT token management, video consultations '
              'via Jitsi Meet, and family profile management. Reduced in-person appointments by 70%.',
          style: theme.textTheme.bodyLarge,
        ),
        const SizedBox(height: 24),
        const Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: [
            TechChip(label: 'Flutter'),
            TechChip(label: 'MVVM'),
            TechChip(label: 'Provider'),
            TechChip(label: 'Dio'),
            TechChip(label: 'Jitsi Meet'),
            TechChip(label: 'Go Router'),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            ActionButton(
              label: 'View Project',
              isPrimary: true,
              onTap: () {},
            ),
            const SizedBox(width: 16),
            ActionButton(
              label: 'Source Code',
              isPrimary: false,
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}

class ProjectGrid extends StatelessWidget {
  final bool isDarkMode;

  const ProjectGrid({
    super.key,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveBreakpoints.of(context).largerThan(TABLET);
    final isTablet = ResponsiveBreakpoints.of(context).between(MOBILE, DESKTOP);

    // List of projects
    final projects = [
      ProjectData(
        title: 'Real-time Object Detection System',
        description:
        'YOLOv8-based industrial object detection with camera calibration for BARC. '
            'Achieved 80% accuracy with GUI for real-time monitoring.',
        image: ImageConstants.project2,
        tags: ['YOLOv8', 'Python', 'OpenCV', 'Tkinter'],
      ),
      ProjectData(
        title: 'Fragile Asset Tracking App',
        description:
        'IoT-based mobile app for real-time asset tracking with GPS. Reduced lost '
            'assets by 25% and increased delivery efficiency by 15%.',
        image: ImageConstants.project3,
        tags: ['Flutter', 'Firebase', 'IoT', 'GPS'],
      ),
      ProjectData(
        title: 'SmartReps Fitness App',
        description:
        'ML-powered yoga pose detection with wearable temperature tracking. '
            'Integrates real-time feedback for safer workouts.',
        image: ImageConstants.project1,
        tags: ['Python', 'TensorFlow.js', 'Firebase', 'IoT'],
      ),
      ProjectData(
        title: 'Portfolio Website',
        description:
        'Modern responsive portfolio with smooth animations and beautiful UI. '
            'Built with Flutter Web and Firebase integration.',
        image: ImageConstants.project3,
        tags: ['Flutter Web', 'Firebase', 'Animations'],
      ),
    ];

    // Define column count based on screen size
    int crossAxisCount = isDesktop ? 3 : (isTablet ? 2 : 1);

    return AnimationLimiter(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: 0.9,
          crossAxisSpacing: 24.0,
          mainAxisSpacing: 24.0,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: projects.length,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredGrid(
            position: index,
            duration: const Duration(milliseconds: 500),
            columnCount: crossAxisCount,
            child: SlideAnimation(
              horizontalOffset: 50.0,
              child: FadeInAnimation(
                child: ProjectCard(
                  project: projects[index],
                  isDarkMode: isDarkMode,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ProjectData {
  final String title;
  final String description;
  final String image;
  final List<String> tags;

  ProjectData({
    required this.title,
    required this.description,
    required this.image,
    required this.tags,
  });
}

class ProjectCard extends StatefulWidget {
  final ProjectData project;
  final bool isDarkMode;

  const ProjectCard({
    super.key,
    required this.project,
    required this.isDarkMode,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: AnimatedContainerCard(
        padding: EdgeInsets.zero,
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project Image with Overlay
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: Image.asset(
                    widget.project.image,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                if (_isHovering)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        color: theme.colorScheme.primary.withValues(alpha: 0.7),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.visibility,
                              color: Colors.white,
                              size: 32,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'View Project',
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            // Project Details
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.project.title,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.project.description,
                      style: theme.textTheme.bodyMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: widget.project.tags.map((tag) => 
                        TechChip(label: tag, isSmall: true)
                      ).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TechChip extends StatelessWidget {
  final String label;
  final bool isSmall;

  const TechChip({
    super.key,
    required this.label,
    this.isSmall = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? 8.0 : 12.0,
        vertical: isSmall ? 4.0 : 6.0,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.secondary.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Text(
        label,
        style:
            (isSmall ? theme.textTheme.bodySmall : theme.textTheme.bodyMedium)
                ?.copyWith(
          color: theme.colorScheme.secondary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class ActionButton extends StatefulWidget {
  final String label;
  final bool isPrimary;
  final VoidCallback onTap;

  const ActionButton({
    super.key,
    required this.label,
    required this.isPrimary,
    required this.onTap,
  });

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          decoration: BoxDecoration(
            color: widget.isPrimary
                ? (_isHovering
                    ? theme.colorScheme.primary
                    : theme.colorScheme.primary.withValues(alpha: 0.8))
                : Colors.transparent,
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(
              color: widget.isPrimary
                  ? Colors.transparent
                  : theme.colorScheme.primary,
              width: 1,
            ),
          ),
          child: Text(
            widget.label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: widget.isPrimary
                  ? theme.colorScheme.onPrimary
                  : theme.colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
