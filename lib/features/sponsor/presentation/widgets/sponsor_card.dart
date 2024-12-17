import 'package:flutter/material.dart';
import '../../domain/entities/sponsor.dart';
import '../../../../core/constants/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class SponsorCard extends StatelessWidget {
  final Sponsor sponsor;

  const SponsorCard({
    super.key,
    required this.sponsor,
  });

  Future<void> _launchUrl() async {
    if (sponsor.websiteUrl == null) return;
    
    final url = Uri.parse(sponsor.websiteUrl!);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.grey[50],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                // Logo
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    image: sponsor.logoUrl != null
                        ? DecorationImage(
                            image: NetworkImage(sponsor.logoUrl!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: sponsor.logoUrl == null
                      ? const Icon(Icons.business, size: 30, color: Colors.grey)
                      : null,
                ),
                const SizedBox(width: 16),
                
                // Name and Duck ID
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        sponsor.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      if (sponsor.duckId != null)
                        Text(
                          'Duck #${sponsor.duckId}',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Website Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: sponsor.websiteUrl != null ? _launchUrl : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Link to website'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
