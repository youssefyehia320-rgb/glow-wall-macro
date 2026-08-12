package com.macro.freefire

import android.accessibilityservice.AccessibilityService
import android.accessibilityservice.GestureDescription
import android.graphics.Path
import android.view.accessibility.AccessibilityEvent

class FastMacroService : AccessibilityService() {

    override fun onAccessibilityEvent(event: AccessibilityEvent?) {}
    override fun onInterrupt() {}

    // تنفيذ ضربة الماكرو السريعة جداً (Ultra Fast Sequence)
    fun triggerUltraGlooMacro(xGloo: Float, yGloo: Float, xSit: Float, ySit: Float, xFire: Float, yFire: Float) {
        val builder = GestureDescription.Builder()

        // 1. ضغطة الثلج (تبدأ عند 0 مللي ثانية)
        val path1 = Path().apply { moveTo(xGloo, yGloo) }
        builder.addStroke(GestureDescription.StrokeDescription(path1, 0, 10))

        // 2. ضغطة القرفصاء (تبدأ بعد 15 مللي ثانية)
        val path2 = Path().apply { moveTo(xSit, ySit) }
        builder.addStroke(GestureDescription.StrokeDescription(path2, 15, 10))

        // 3. ضغطة الضرب (تبدأ بعد 30 مللي ثانية)
        val path3 = Path().apply { moveTo(xFire, yFire) }
        builder.addStroke(GestureDescription.StrokeDescription(path3, 30, 10))

        // إرسال الأمر للنظام فوراً
        dispatchGesture(builder.build(), null, null)
    }
}
