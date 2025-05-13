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
        const SectionDivider(title: 'Projects'),
        const SizedBox(height: 40),

        Text(
          'Some of my recent work',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
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
          'Mobile E-Commerce App',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'A modern e-commerce mobile application with advanced animations, beautiful UI, and seamless user experience. Includes features like product search, filtering, user authentication, and payment processing.',
          style: theme.textTheme.bodyLarge,
        ),
        const SizedBox(height: 24),
        const Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: [
            TechChip(label: 'Flutter'),
            TechChip(label: 'Firebase'),
            TechChip(label: 'State Management'),
            TechChip(label: 'Payment Gateway'),
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
        title: 'Portfolio Website',
        description:
            'A responsive portfolio website built with modern web technologies and animations.',
        image: ImageConstants.project2,
        tags: ['React', 'JavaScript', 'CSS', 'Animation'],
      ),
      ProjectData(
        title: 'Task Management App',
        description:
            'A productivity app for managing tasks, with reminders and progress tracking.',
        image: ImageConstants.project3,
        tags: ['Flutter', 'Firebase', 'State Management'],
      ),
      ProjectData(
        title: 'Social Media Dashboard',
        description:
            'An analytics dashboard for social media performance monitoring and reporting.',
        image: ImageConstants.project1,
        tags: ['React', 'Node.js', 'Data Visualization'],
      ),
      ProjectData(
        title: 'Weather Application',
        description:
            'Real-time weather application with beautiful UI and accurate forecasts.',
        image: ImageConstants.project2,
        tags: ['Flutter', 'API Integration', 'Animations'],
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
                    children: widget.project.tags
                        .map((tag) => TechChip(label: tag, isSmall: true))
                        .toList(),
                  ),
                ],
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
