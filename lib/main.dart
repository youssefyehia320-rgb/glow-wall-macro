import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const UltraMacroApp());
}

class UltraMacroApp extends StatelessWidget {
  const UltraMacroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ultra Gloo Macro',
      // تصميم أسود كاملاً (Dark OLED Theme)
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0D0D0D),
        cardColor: const Color(0xFF1A1A1A),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFFF0055), // أحمر نيون قياسي للجيمينج
          secondary: Color(0xFF00FFCC), // سيان نيون
        ),
      ),
      home: const MacroHomeScreen(),
    );
  }
}

class MacroHomeScreen extends StatefulWidget {
  const MacroHomeScreen({super.key});

  @override
  State<MacroHomeScreen> createState() => _MacroHomeScreenState();
}

class _MacroHomeScreenState extends State<MacroHomeScreen> {
  static const platform = MethodChannel('com.macro.freefire/accessibility');
  bool isMacroEnabled = false;

  // دالة تفعيل/إيقاف الزر العائم والماكرو
  Future<void> toggleMacro(bool value) async {
    try {
      if (value) {
        await platform.invokeMethod('enableMacro');
      } else {
        await platform.invokeMethod('disableMacro');
      }
      setState(() {
        isMacroEnabled = value;
      });
    } on PlatformException catch (e) {
      debugPrint("Error toggling macro: ${e.message}");
    }
  }

  // فتح إعدادات إمكانية الوصول
  Future<void> openSettings() async {
    try {
      await platform.invokeMethod('openAccessibilitySettings');
    } on PlatformException catch (e) {
      debugPrint("Error opening settings: ${e.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF141414),
        title: const Text(
          '⚡ ULTRA GLOO MACRO',
          style: TextStyle(fontWeight: FontWeight.black, letterSpacing: 1.5, color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // كارت الحالة (Status Card)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isMacroEnabled ? const Color(0xFF00FFCC) : const Color(0xFFFF0055),
                  width: 1.5,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.bolt,
                        color: isMacroEnabled ? const Color(0xFF00FFCC) : Colors.grey,
                        size: 28,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        isMacroEnabled ? 'الماكرو شغال 🔥' : 'الماكرو واقف 🛑',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  // مفتاح التشغيل والإيقاف (Enable / Disable)
                  Switch(
                    value: isMacroEnabled,
                    activeColor: const Color(0xFF00FFCC),
                    inactiveTrackColor: Colors.black45,
                    onChanged: (val) => toggleMacro(val),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // لوحة الإعدادات والسرعة
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'معدل السرعة (Speed Rate)',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '⚡ 20ms Ultra Fast Sequence',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.black, color: Color(0xFFFF0055)),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'تم ضبط الماكرو على أقصى سرعة استجابة (ثلج ⬅️ قرفصاء ⬅️ رمي).',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // زرار طلب صلاحيات النظام
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: const BorderSide(color: Colors.white24),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: openSettings,
              icon: const Icon(Icons.security, color: Colors.white70),
              label: const Text(
                'تفعيل صلاحية Accessibility',
                style: TextStyle(color: Colors.white70, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
