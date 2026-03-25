package aming.com.dynamic_theme

import android.content.Intent
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.view.View
import android.view.animation.AlphaAnimation
import android.view.animation.RotateAnimation
import android.view.animation.ScaleAnimation
import io.flutter.embedding.android.FlutterActivity

class SplashActivity : FlutterActivity() {

    private lateinit var logoContainer: View
    private lateinit var titleText: View
    private lateinit var loadingRing: View

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_splash)

        logoContainer = findViewById(R.id.logoContainer)
        titleText = findViewById(R.id.titleText)
        loadingRing = findViewById(R.id.loadingRing)

        startAnimations()
    }

    private fun startAnimations() {
        // Logo 缩放 + 淡入动画
        val scaleAnimation = ScaleAnimation(
            0.5f, 1.0f,
            0.5f, 1.0f,
            ScaleAnimation.RELATIVE_TO_SELF, 0.5f,
            ScaleAnimation.RELATIVE_TO_SELF, 0.5f
        ).apply {
            duration = 1200
            fillAfter = true
            interpolator = android.view.animation.OvershootInterpolator(0.6f)
        }

        val fadeInAnimation = AlphaAnimation(0f, 1f).apply {
            duration = 800
            fillAfter = true
        }

        logoContainer.startAnimation(scaleAnimation)
        logoContainer.startAnimation(fadeInAnimation)

        // 标题延迟淡入
        titleText.postDelayed({
            titleText.visibility = View.VISIBLE
            titleText.startAnimation(AlphaAnimation(0f, 1f).apply {
                duration = 600
                fillAfter = true
            })
        }, 500)

        // Loading 环旋转动画
        loadingRing.postDelayed({
            loadingRing.visibility = View.VISIBLE
            val rotateAnimation = RotateAnimation(
                0f, 360f,
                RotateAnimation.RELATIVE_TO_SELF, 0.5f,
                RotateAnimation.RELATIVE_TO_SELF, 0.5f
            ).apply {
                duration = 1500
                repeatCount = RotateAnimation.INFINITE
                interpolator = android.view.animation.LinearInterpolator()
                fillAfter = true
            }
            loadingRing.startAnimation(rotateAnimation)
        }, 300)

        // 2.5秒后跳转到主页面
        Handler(Looper.getMainLooper()).postDelayed({
            navigateToMain()
        }, 2500)
    }

    private fun navigateToMain() {
        // 淡出动画
        val fadeOut = AlphaAnimation(1f, 0f).apply {
            duration = 500
            fillAfter = true
        }

        fadeOut.setAnimationListener(object : android.view.animation.Animation.AnimationListener {
            override fun onAnimationStart(animation: android.view.animation.Animation?) {}
            override fun onAnimationRepeat(animation: android.view.animation.Animation?) {}
            override fun onAnimationEnd(animation: android.view.animation.Animation?) {
                startActivity(Intent(this@SplashActivity, MainActivity::class.java))
                overridePendingTransition(android.R.anim.fade_in, android.R.anim.fade_out)
                finish()
            }
        })

        logoContainer.startAnimation(fadeOut)
    }
}