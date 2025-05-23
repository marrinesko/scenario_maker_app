import 'package:flutter/material.dart';
import 'package:scenario_maker_app/ui/screens/scenario_generation/scenario_generation_screen.dart';
import 'package:scenario_maker_app/ui/screens/scenario_generation/components/generate_scenario_title.dart';

class PlatformSelectionScreen extends StatelessWidget {
  const PlatformSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Выбор платформы'),
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 4,
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // YouTube
              GenerateScenarioTitle(
                backgroundColor: Colors.white,
                iconBackgroundColor: Colors.red[50]!,
                assetPath: 'assets/icons/yb.svg',
                title: 'YouTube',
                description: 'Генерация сценария для YouTube Shorts',
                borderColor: Colors.red[400]!,
                onTap:
                    () => _navigateToPlatform(
                      context,
                      'YouTube',
                      'assets/icons/yb.svg',
                      Colors.red[400]!,
                    ),
              ),
              const SizedBox(height: 16),

              // VK
              GenerateScenarioTitle(
                backgroundColor: Colors.white,
                iconBackgroundColor: Colors.blue[50]!,
                assetPath: 'assets/icons/vk.svg',
                title: 'VK',
                description: 'Генерация сценария для VK Клипы',
                borderColor: Colors.blue[600]!,
                onTap:
                    () => _navigateToPlatform(
                      context,
                      'VK',
                      'assets/icons/vk.svg',
                      Colors.blue[600]!,
                    ),
              ),
              const SizedBox(height: 16),

              // Instagram
              GenerateScenarioTitle(
                backgroundColor: Colors.white,
                iconBackgroundColor: Colors.purple[50]!,
                assetPath: 'assets/icons/inst.svg',
                title: 'Instagram',
                description: 'Генерация сценария для Instagram Reels',
                borderColor: const Color(0xFFE1306C),
                onTap:
                    () => _navigateToPlatform(
                      context,
                      'Instagram',
                      'assets/icons/inst.svg',
                      const Color(0xFFE1306C),
                    ),
              ),
              const SizedBox(height: 16),

              // TikTok
              GenerateScenarioTitle(
                backgroundColor: Colors.white,
                iconBackgroundColor: Colors.grey[900]!,
                assetPath: 'assets/icons/tik.svg',
                title: 'TikTok',
                description: 'Генерация сценария для TikTok Видео',
                borderColor: Colors.black,
                iconColor: Colors.white,
                textColor: Colors.black,
                onTap:
                    () => _navigateToPlatform(
                      context,
                      'TikTok',
                      'assets/icons/tik.svg',
                      Colors.black,
                    ),
              ),
              const SizedBox(height: 16),

              // Дзен
              GenerateScenarioTitle(
                backgroundColor: Colors.white,
                iconBackgroundColor: Colors.orange[50]!,
                assetPath: 'assets/icons/zen.svg',
                title: 'Дзен',
                description: 'Генерация сценария для Дзен Клипы',
                borderColor: Colors.orange[400]!,
                onTap:
                    () => _navigateToPlatform(
                      context,
                      'Дзен',
                      'assets/icons/zen.svg',
                      Colors.orange[400]!,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToPlatform(
    BuildContext context,
    String platformName,
    String platformIcon,
    Color platformColor,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => ScenarioGenerationScreen(
              platformName: platformName,
              platformIcon: platformIcon,
              platformColor: platformColor,
            ),
      ),
    );
  }
}
