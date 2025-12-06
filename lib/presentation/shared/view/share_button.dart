import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../app/config/theme/colors.dart';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http; // Add this import

class ShareButton extends StatefulWidget {
  final String textContent;
  final String url;
  final String? imageAssetPath;
  final File? imageFile;
  final String? imageNetworkUrl; // New parameter for network image

  const ShareButton({
    super.key,
    required this.textContent,
    required this.url,
    this.imageAssetPath,
    this.imageFile,
    this.imageNetworkUrl, // Add this parameter
  });

  @override
  State<ShareButton> createState() => _ShareButtonState();
}

class _ShareButtonState extends State<ShareButton> {
  bool _isSharing = false;

  Future<XFile?> _getImageFile() async {
    if (widget.imageFile != null) {
      return XFile(widget.imageFile!.path);
    } else if (widget.imageAssetPath != null) {
      final byteData = await rootBundle.load(widget.imageAssetPath!);
      final tempDir = await getTemporaryDirectory();
      final tempFile = File(
          '${tempDir.path}/share_image_${DateTime.now().millisecondsSinceEpoch}.png');
      await tempFile.writeAsBytes(byteData.buffer.asUint8List());
      return XFile(tempFile.path);
    } else if (widget.imageNetworkUrl != null) {
      // Download network image
      final response = await http.get(Uri.parse(widget.imageNetworkUrl!));
      final tempDir = await getTemporaryDirectory();
      final tempFile = File(
          '${tempDir.path}/network_image_${DateTime.now().millisecondsSinceEpoch}.jpg');
      await tempFile.writeAsBytes(response.bodyBytes);
      return XFile(tempFile.path);
    }
    return null;
  }

  Future<void> _shareToWhatsApp() async {
    if (_isSharing) return;

    setState(() => _isSharing = true);

    try {
      final String fullText = '${widget.textContent}\n${widget.url}';
      final imageXFile = await _getImageFile();

      if (imageXFile != null) {
        await Share.shareXFiles(
          [imageXFile],
          text: fullText,
        );
      } else {
        await Share.share(fullText);
      }
    } on PlatformException catch (e) {
      debugPrint('PlatformException: $e');
      _showError('Failed to share: ${e.message}');
    } catch (e) {
      debugPrint('Error: $e');
      _showError('Failed to share content');
    } finally {
      if (mounted) {
        setState(() => _isSharing = false);
      }
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _isSharing ? null : _shareToWhatsApp,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.6),
              offset: const Offset(0, 5),
              blurRadius: 8,
            ),
          ],
        ),
        child: const HugeIcon(
          icon: HugeIcons.strokeRoundedShare08,
          color: AppColors.primary,
        ),
      ),
    );

    // ElevatedButton.icon(
    //   onPressed: _isSharing ? null : _shareToWhatsApp,
    //   icon: _isSharing
    //       ? const SizedBox(
    //           width: 16,
    //           height: 16,
    //           child: CircularProgressIndicator(strokeWidth: 2),
    //         )
    //       : const Icon(Icons.share),
    //   label: Text(_isSharing ? 'Sharing...' : 'Share to WhatsApp'),
    //   style: ElevatedButton.styleFrom(
    //     backgroundColor: Colors.green,
    //     foregroundColor: Colors.white,
    //   ),
    // );
  }
}















// class ShareButton extends StatelessWidget {
//   const ShareButton({
//     super.key,
//   });
  

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(5),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.8),
//         borderRadius: BorderRadius.circular(50),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.6),
//             offset: const Offset(0, 5),
//             blurRadius: 8,
//           ),
//         ],
//       ),
//       child:const HugeIcon(
//         icon: HugeIcons.strokeRoundedShare08,
//         color: AppColors.primary,
//       ),
//     );
//   }
// }