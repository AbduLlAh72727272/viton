import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

const String accessKeyId = "b2b89a63a230409baf8e508eb15f855a";
const String accessKeySecret = "b7e2e905819c4767aa7bae1ba35df630";

const String baseUrl = "https://api.klingai.com";
const String createTaskUrl = "$baseUrl/v1/images/kolors-virtual-try-on";
const String checkTaskStatusUrl = "$baseUrl/v1/images/kolors-virtual-try-on";

class TryOnResultScreen extends StatefulWidget {
  final String userImagePath;
  final String clothingImagePath;
  final String category;

  const TryOnResultScreen({
    super.key,
    required this.userImagePath,
    required this.clothingImagePath,
    required this.category,
  });

  @override
  State<TryOnResultScreen> createState() => _TryOnResultScreenState();
}

class _TryOnResultScreenState extends State<TryOnResultScreen> {
  String? generatedImageUrl;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    applyVirtualTryOn();
  }

  String generateJwtToken() {
    final jwt = JWT({
      'iss': accessKeyId,
      'exp': DateTime.now().millisecondsSinceEpoch ~/ 1000 + 1800,
      'nbf': DateTime.now().millisecondsSinceEpoch ~/ 1000 - 5,
    });
    return jwt.sign(SecretKey(accessKeySecret), algorithm: JWTAlgorithm.HS256);
  }

  Future<String> _convertToBase64(String imagePath) async {
    final imageFile = File(imagePath);
    final imageBytes = await imageFile.readAsBytes();
    return base64Encode(imageBytes);
  }

  Future<void> applyVirtualTryOn() async {
    try {
      final jwtToken = generateJwtToken();
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken',
      };

      final userImageBase64 = await _convertToBase64(widget.userImagePath);
      final clothingImageBase64 = await _convertToBase64(widget.clothingImagePath);

      final body = jsonEncode({
        "model_name": "kolors-virtual-try-on-v1-5",
        "human_image": userImageBase64,
        "cloth_image": clothingImageBase64,
      });

      final response = await http.post(Uri.parse(createTaskUrl), headers: headers, body: body);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['code'] == 0 && jsonResponse['data']?['task_id'] != null) {
          final String taskId = jsonResponse['data']['task_id'];
          await pollForResult(taskId);
        } else {
          setState(() => isLoading = false);
        }
      } else {
        setState(() => isLoading = false);
      }
    } catch (_) {
      setState(() => isLoading = false);
    }
  }

  Future<void> pollForResult(String taskId) async {
    final jwtToken = generateJwtToken();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $jwtToken',
    };

    while (true) {
      final response = await http.get(
        Uri.parse("$checkTaskStatusUrl/$taskId"),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final taskStatus = jsonResponse['data']?['task_status'];

        if (taskStatus == "succeed") {
          final List<dynamic> images =
              (jsonResponse['data']?['task_result']?['images'] as List?) ?? <dynamic>[];

          String? firstUrl;
          if (images.isNotEmpty) {
            final first = images.first;
            if (first is Map && first['url'] is String && (first['url'] as String).isNotEmpty) {
              firstUrl = first['url'] as String;
            }
          }

          if (firstUrl != null) {
            setState(() {
              generatedImageUrl = firstUrl;
              isLoading = false;
            });
          } else {
            setState(() => isLoading = false);
          }
          break;
        } else if (taskStatus == "failed") {
          setState(() => isLoading = false);
          break;
        }
      } else {
        setState(() => isLoading = false);
        break;
      }

      await Future.delayed(const Duration(seconds: 3));
    }
  }

  Future<void> shareImage() async {
    if (generatedImageUrl == null) return;

    try {
      final uri = Uri.parse(generatedImageUrl!);
      final response = await http.get(uri);
      final tempDir = await getTemporaryDirectory();
      final file = File("${tempDir.path}/shared_image.jpg");
      await file.writeAsBytes(response.bodyBytes);

      await Share.shareXFiles([XFile(file.path)], text: "share_text".tr);
    } catch (_) {
      // ignore
    }
  }

  void _redirectToBuyNow() async {
    final Uri url = Uri.parse("https://www.google.com");
    if (await canLaunchUrl(url)) {
      final launched = await launchUrl(url, mode: LaunchMode.externalApplication);
      if (!launched) {
        throw "Could not launch $url";
      }
    } else {
      throw "Could not launch $url";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          isLoading ? "generating".tr : "try_on_result".tr,
          style: const TextStyle(color: Colors.black, fontSize: 18),
        ),
        centerTitle: true,
        actions: generatedImageUrl != null
            ? [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.black),
            onPressed: shareImage,
          ),
        ]
            : null,
      ),
      body: Center(
        child: isLoading
            ? _GeneratingPreview(imagePath: widget.userImagePath)
            : (generatedImageUrl == null)
            ? _FailureView(onRetry: () {
          setState(() {
            isLoading = true;
            generatedImageUrl = null;
          });
          applyVirtualTryOn();
        })
            : SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(generatedImageUrl!),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _redirectToBuyNow,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                child: Text(
                  "shop_now".tr,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* ======================= SIMPLE GENERATING VIEW (USER IMAGE + ROTATING ROD) ======================= */

class _GeneratingPreview extends StatefulWidget {
  final String imagePath;
  const _GeneratingPreview({required this.imagePath});

  @override
  State<_GeneratingPreview> createState() => _GeneratingPreviewState();
}

class _GeneratingPreviewState extends State<_GeneratingPreview>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(); // continuous rotation
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final boxW = w.clamp(260.0, 520.0);
    final boxH = boxW * 1.25; // portrait preview

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: boxW,
          height: boxH,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.black12,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 24,
                spreadRadius: 2,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // User photo
                Positioned.fill(
                  child: Image.file(
                    File(widget.imagePath),
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const ColoredBox(
                      color: Color(0xFFE9E9E9),
                      child: Center(child: Icon(Icons.image_not_supported, size: 42)),
                    ),
                  ),
                ),

                // Subtle dark veil for contrast (VERY light)
                Positioned.fill(
                  child: Container(color: Colors.black.withOpacity(0.08)),
                ),

                // Rotating rod overlay
                Positioned.fill(
                  child: AnimatedBuilder(
                    animation: _ctrl,
                    builder: (_, __) {
                      final angle = _ctrl.value * 2 * pi;
                      return CustomPaint(
                        painter: _RodPainter(angle: angle),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          "generating".tr,
          style: const TextStyle(
            fontSize: 14.5,
            color: Colors.black54,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _RodPainter extends CustomPainter {
  final double angle; // radians
  _RodPainter({required this.angle});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.shortestSide * 0.42;

    // Optional: faint scan ring
    final ring = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Colors.white.withOpacity(0.25);
    canvas.drawCircle(center, radius, ring);

    // The “rod”
    final rodLength = radius * 1.6; // extends beyond ring
    final dx = cos(angle) * rodLength / 2;
    final dy = sin(angle) * rodLength / 2;

    // Glow underlay
    final glow = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round
      ..color = Colors.white.withOpacity(0.20)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
    canvas.drawLine(center - Offset(dx, dy), center + Offset(dx, dy), glow);

    // Main rod line
    final rod = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.5
      ..strokeCap = StrokeCap.round
      ..color = Colors.white.withOpacity(0.9);
    canvas.drawLine(center - Offset(dx, dy), center + Offset(dx, dy), rod);

    // Moving head dot
    final head = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white.withOpacity(0.95);
    final headPos = center + Offset(dx, dy);
    canvas.drawCircle(headPos, 5.5, head);

    // trailing sparkle dots along rod (simple, tasteful)
    final trailCount = 4;
    for (int i = 1; i <= trailCount; i++) {
      final t = i / (trailCount + 1);
      final pos = Offset(
        center.dx + dx * (1 - t),
        center.dy + dy * (1 - t),
      );
      final alpha = (0.6 - 0.12 * i).clamp(0.0, 1.0);
      final p = Paint()..color = Colors.white.withOpacity(alpha);
      canvas.drawCircle(pos, 2.5 - 0.3 * i, p);
    }
  }

  @override
  bool shouldRepaint(covariant _RodPainter oldDelegate) => oldDelegate.angle != angle;
}

/* ======================= FAILURE VIEW ======================= */

class _FailureView extends StatelessWidget {
  final VoidCallback onRetry;
  const _FailureView({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.warning_amber_rounded, size: 36, color: Colors.black54),
          const SizedBox(height: 10),
          const Text(
            "Oops — couldn't generate the try-on.",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          const Text(
            "Tap retry to run it again.",
            style: TextStyle(fontSize: 13.5, color: Colors.black54),
          ),
          const SizedBox(height: 14),
          ElevatedButton(
            onPressed: onRetry,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
            child: const Text("Retry", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
