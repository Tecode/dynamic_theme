import UIKit
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate {
    private var splashWindow: UIWindow?

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        // 创建自定义启动画面
        showSplashScreen()

        // 延迟隐藏启动画面并显示 Flutter 界面
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) { [weak self] in
            self?.hideSplashScreen()
        }

        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    // MARK: - 启动画面

    private func showSplashScreen() {
        // 创建启动画面窗口
        let splashVC = SplashViewController()
        splashWindow = UIWindow(frame: UIScreen.main.bounds)
        splashWindow?.rootViewController = splashVC
        splashWindow?.windowLevel = .alert + 1
        splashWindow?.makeKeyAndVisible()

        // 开始动画
        splashVC.startAnimations()
    }

    private func hideSplashScreen() {
        guard let splashWindow = splashWindow else { return }

        // 简单的淡出动画
        UIView.animate(withDuration: 0.5, animations: {
            splashWindow.alpha = 0
        }) { _ in
            // 清理启动画面窗口
            splashWindow.isHidden = true
            self.splashWindow = nil
        }
    }
}

// MARK: - 启动画面视图控制器

class SplashViewController: UIViewController {

    private var logoContainerView: UIView!
    private var logoView: UIView!
    private var iconView: StarIconView!
    private var loadingRingView: LoadingRingView!
    private var titleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = UIColor(red: 0.039, green: 0.055, blue: 0.153, alpha: 1.0)

        // Logo 容器（用于居中）
        logoContainerView = UIView()
        logoContainerView.translatesAutoresizingMaskIntoConstraints = false
        logoContainerView.alpha = 0
        logoContainerView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        view.addSubview(logoContainerView)

        // Logo 图标
        logoView = UIView()
        logoView.translatesAutoresizingMaskIntoConstraints = false
        logoView.backgroundColor = UIColor(red: 0.4, green: 0.494, blue: 0.918, alpha: 1.0)
        logoView.layer.cornerRadius = 30
        logoView.layer.shadowColor = UIColor(red: 0.4, green: 0.494, blue: 0.918, alpha: 1.0).cgColor
        logoView.layer.shadowOffset = CGSize(width: 0, height: 10)
        logoView.layer.shadowRadius = 20
        logoView.layer.shadowOpacity = 0.5
        logoContainerView.addSubview(logoView)

        // Logo 图标（自定义绘制）
        iconView = StarIconView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        iconView.translatesAutoresizingMaskIntoConstraints = false
        logoView.addSubview(iconView)

        // 标题
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "动态主题"
        titleLabel.textColor = UIColor(red: 0.4, green: 0.85, blue: 1, alpha: 1.0)
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        titleLabel.textAlignment = .center
        titleLabel.alpha = 0
        logoContainerView.addSubview(titleLabel)

        // Loading 环
        loadingRingView = LoadingRingView()
        loadingRingView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingRingView)

        // 约束
        NSLayoutConstraint.activate([
            // logo 容器居中
            logoContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),

            // logo 大小
            logoView.widthAnchor.constraint(equalToConstant: 120),
            logoView.heightAnchor.constraint(equalToConstant: 120),
            logoView.topAnchor.constraint(equalTo: logoContainerView.topAnchor),
            logoView.centerXAnchor.constraint(equalTo: logoContainerView.centerXAnchor),

            // icon 在 logo 内居中
            iconView.centerXAnchor.constraint(equalTo: logoView.centerXAnchor),
            iconView.centerYAnchor.constraint(equalTo: logoView.centerYAnchor),

            // title 在 logo 下方
            titleLabel.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 24),
            titleLabel.centerXAnchor.constraint(equalTo: logoContainerView.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: logoContainerView.bottomAnchor),

            // loading 环
            loadingRingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingRingView.topAnchor.constraint(equalTo: logoContainerView.bottomAnchor, constant: 60),
            loadingRingView.widthAnchor.constraint(equalToConstant: 40),
            loadingRingView.heightAnchor.constraint(equalToConstant: 40),
        ])
    }

    func startAnimations() {
        // Logo 动画：缩放 + 淡入
        UIView.animate(withDuration: 1.2,
                       delay: 0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.5,
                       options: .curveEaseOut) {
            self.logoContainerView.alpha = 1
            self.logoContainerView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }

        // 标题延迟淡入
        UIView.animate(withDuration: 0.6, delay: 0.5, options: .curveEaseIn) {
            self.titleLabel.alpha = 1
        }

        // 开始 loading 动画
        loadingRingView.startAnimating()
    }
}

// MARK: - 加载环动画视图

class LoadingRingView: UIView {

    private let shapeLayer = CAShapeLayer()
    private var isAnimating = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayer()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayer()
    }

    private func setupLayer() {
        backgroundColor = .clear

        // 外圈
        let circlePath = UIBezierPath(ovalIn: bounds.insetBy(dx: 3, dy: 3))
        let circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = UIColor.white.withAlphaComponent(0.3).cgColor
        circleLayer.lineWidth = 3
        layer.addSublayer(circleLayer)

        // 旋转的弧形
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor(red: 0.4, green: 0.494, blue: 0.918, alpha: 1.0).cgColor
        shapeLayer.lineWidth = 3
        shapeLayer.lineCap = .round
        shapeLayer.strokeStart = 0
        shapeLayer.strokeEnd = 0.4
        layer.addSublayer(shapeLayer)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let path = UIBezierPath(ovalIn: bounds.insetBy(dx: 3, dy: 3))
        shapeLayer.path = path.cgPath
    }

    func startAnimating() {
        guard !isAnimating else { return }
        isAnimating = true

        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.fromValue = 0
        rotation.toValue = CGFloat.pi * 2
        rotation.duration = 1.5
        rotation.repeatCount = .infinity
        rotation.isRemovedOnCompletion = false
        layer.add(rotation, forKey: "rotation")
    }
}

// MARK: - 星星图标视图（纯代码绘制，兼容 iOS 12）

class StarIconView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }

        let center = CGPoint(x: rect.midX, y: rect.midY)
        let outerRadius: CGFloat = min(rect.width, rect.height) / 2
        let innerRadius = outerRadius * 0.38
        let points = 5

        var path = UIBezierPath()
        var angle: CGFloat = -.pi / 2

        for i in 0..<(points * 2) {
            let radius = i % 2 == 0 ? outerRadius : innerRadius
            let x = center.x + radius * cos(angle)
            let y = center.y + radius * sin(angle)

            if i == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }

            angle += .pi / CGFloat(points)
        }

        path.close()

        // 填充白色
        context.setFillColor(UIColor.white.cgColor)
        path.fill()

        // 添加发光效果
        context.setShadow(offset: .zero, blur: 8, color: UIColor.white.withAlphaComponent(0.8).cgColor)
        path.fill()
    }
}