import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:online_portfolio/constants/imageconstants.dart';
import 'package:online_portfolio/widgets/animated_container_card.dart';
import 'package:online_portfolio/widgets/section_divider.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../home_screen.dart';

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
              onTap: () {
                // For Food Fitness, open Play Store links
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Food Fitness Apps'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.medical_services),
                          title: const Text('Doctor App'),
                          subtitle: const Text('For healthcare providers'),
                          onTap: () {
                            launchURL('https://play.google.com/store/apps/details?id=com.foodFitness.doctor');
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.person),
                          title: const Text('Patient App'),
                          subtitle: const Text('For patients'),
                          onTap: () {
                            launchURL('https://play.google.com/store/apps/details?id=com.food_fitness.patient');
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(width: 16),
            // ActionButton(
            //   label: 'Source Code',
            //   isPrimary: false,
            //   onTap: () {},
            // ),
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
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => ProjectDetailModal(
              project: widget.project,
              isDarkMode: widget.isDarkMode,
            ),
          );
        },
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

class ProjectDetailModal extends StatelessWidget {
  final ProjectData project;
  final bool isDarkMode;

  const ProjectDetailModal({
    super.key,
    required this.project,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(20),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 800,
          maxHeight: screenSize.height * 0.8,
        ),
        child: Container(
          width: screenSize.width * 0.9,
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            children: [
              // Header with close button
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        project.title,
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Project Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          project.image,
                          width: double.infinity,
                          height: 300,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Description
                      Text(
                        'Project Overview',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        project.description,
                        style: theme.textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 24),

                      // Technologies
                      Text(
                        'Technologies Used',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: project.tags.map((tag) =>
                            TechChip(label: tag)
                        ).toList(),
                      ),
                      const SizedBox(height: 24),

                      // Additional details based on project
                      if (project.title.contains('Food Fitness')) ...[
                        _buildDetailSection(
                          'Key Features',
                          [
                            '• Secure OTP authentication with JWT token management',
                            '• Video consultation via Jitsi Meet with end-to-end encryption',
                            '• Comprehensive family profile management system',
                            '• MVVM architecture with Provider state management',
                            '• Responsive UI with custom components and theme support',
                          ],
                          theme,
                        ),
                        const SizedBox(height: 16),
                        _buildDetailSection(
                          'Impact',
                          [
                            '• Reduced in-person appointments by 70%',
                            '• Improved user experience by 13%',
                            '• 10% reduction in unauthorized access attempts',
                            '• 80% improved data organization for family profiles',
                          ],
                          theme,
                        ),
                      ],

                      if (project.title.contains('Object Detection')) ...[
                        _buildDetailSection(
                          'Technical Details',
                          [
                            '• YOLOv8 model for real-time object detection',
                            '• Camera calibration for accurate object localization',
                            '• GUI development with Tkinter',
                            '• Data augmentation for improved model robustness',
                            '• Synthetic image generation',
                          ],
                          theme,
                        ),
                        const SizedBox(height: 16),
                        _buildDetailSection(
                          'Achievements',
                          [
                            '• 80% detection accuracy on conveyor belts',
                            '• 15% reduction in error margin',
                            '• 27% enhancement in industrial safety',
                            '• 80% increase in detection reliability',
                          ],
                          theme,
                        ),
                      ],

                      const SizedBox(height: 32),

                      // Action buttons
                      Row(
                        children: [
                          if (project.title.contains('Food Fitness')) ...[
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () => launchURL('https://play.google.com/store/apps/details?id=com.foodFitness.doctor'),
                                icon: const Icon(Icons.android),
                                label: const Text('Doctor App'),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () => launchURL('https://play.google.com/store/apps/details?id=com.food_fitness.patient'),
                                icon: const Icon(Icons.android),
                                label: const Text('Patient App'),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                ),
                              ),
                            ),
                          ],
                          if (project.title.contains('SmartReps'))
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () => launchURL('https://drive.google.com/file/d/1vBmnlZXPqxFQiafRPVVF1BXIj4xngNBZ/view'),
                                icon: const Icon(Icons.article),
                                label: const Text('Read Paper'),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, List<String> items, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ...items.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(item, style: theme.textTheme.bodyMedium),
        )),
      ],
    );
  }
}