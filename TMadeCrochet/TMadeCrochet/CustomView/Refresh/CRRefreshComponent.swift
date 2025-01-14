

import UIKit

public typealias CRRefreshHandler = (() -> ())

public enum CRRefreshState {
    case idle
    case pulling
    case refreshing
    case willRefresh
    case noMoreData
}

open class CRRefreshComponent: UIView {
    
    open weak var scrollView: UIScrollView?
    
    open var scrollViewInsets: UIEdgeInsets = .zero
    
    open var handler: CRRefreshHandler?
    
    open var animator: CRRefreshProtocol!
    
    open var state: CRRefreshState = .idle {
        didSet {
            if state != oldValue {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.animator.refresh(view: self, stateDidChange: self.state)
                }
            }
        }
    }
    
    fileprivate var isObservingScrollView = false
    
    fileprivate var isIgnoreObserving     = false
    
    fileprivate(set) var isRefreshing     = false
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        autoresizingMask = [.flexibleLeftMargin, .flexibleWidth, .flexibleRightMargin]
    }
    
    public convenience init(animator: CRRefreshProtocol = CRRefreshAnimator(), handler: @escaping CRRefreshHandler) {
        self.init(frame: .zero)
        self.handler  = handler
        self.animator = animator
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        removeObserver()
        if let newSuperview = newSuperview as? UIScrollView {
            scrollViewInsets = newSuperview.contentInset
            DispatchQueue.main.async { [weak self, newSuperview] in
                guard let weakSelf = self else { return }
                weakSelf.addObserver(newSuperview)
            }
        }
    }
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        scrollView = superview as? UIScrollView
        let view = animator.view
        if view.superview == nil {
            let inset = animator.insets
            addSubview(view)
            view.frame = CGRect(x: inset.left,
                                y: inset.top,
                                width: bounds.size.width - inset.left - inset.right,
                                height: bounds.size.height - inset.top - inset.bottom)
            view.autoresizingMask = [
                .flexibleWidth,
                .flexibleTopMargin,
                .flexibleHeight,
                .flexibleBottomMargin
            ]
        }
    }
    
    //MARK: Public Methods
    public final func beginRefreshing() -> Void {
        guard isRefreshing == false else { return }
        if self.window != nil {
            state = .refreshing
            start()
        }else {
            if state != .refreshing {
                state = .willRefresh
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.scrollViewInsets = self.scrollView?.contentInset ?? .zero
                    if self.state == .willRefresh {
                        self.state = .refreshing
                        self.start()
                    }
                }
            }
        }
    }
    
    public final func endRefreshing() -> Void {
        guard isRefreshing else { return }
        self.stop()
    }
    
    public func ignoreObserver(_ ignore: Bool = false) {
        isIgnoreObserving = ignore
    }
    
    public func start() {
        isRefreshing = true
    }
    
    public func stop() {
        isRefreshing = false
    }
    
    public func sizeChange(change: [NSKeyValueChangeKey : Any]?) {}
    
    public func offsetChange(change: [NSKeyValueChangeKey : Any]?) {}
}



//MARK: Observer Methods 
extension CRRefreshComponent {
    
    fileprivate static var context            = "CRRefreshContext"
    fileprivate static let offsetKeyPath      = "contentOffset"
    fileprivate static let contentSizeKeyPath = "contentSize"
    public static let animationDuration       = 0.25
    
    fileprivate func removeObserver() {
        if let scrollView = superview as? UIScrollView, isObservingScrollView {
            withUnsafeMutablePointer(to: &CRRefreshComponent.context) { unsafePointer in
                scrollView.removeObserver(self, forKeyPath: CRRefreshComponent.offsetKeyPath, context: unsafePointer)
                scrollView.removeObserver(self, forKeyPath: CRRefreshComponent.contentSizeKeyPath, context: unsafePointer)
                isObservingScrollView = false
            }
        }
    }
    
    fileprivate func addObserver(_ view: UIView?) {
        if let scrollView = view as? UIScrollView, !isObservingScrollView {
            withUnsafeMutablePointer(to: &CRRefreshComponent.context) { unsafePointer in
                scrollView.addObserver(self, forKeyPath: CRRefreshComponent.offsetKeyPath, options: [.initial, .new], context: unsafePointer)
                scrollView.addObserver(self, forKeyPath: CRRefreshComponent.contentSizeKeyPath, options: [.initial, .new], context: unsafePointer)
                isObservingScrollView = true
            }
        }
    }
    
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, 
                                    context: UnsafeMutableRawPointer?) {
        withUnsafeMutablePointer(to: &CRRefreshComponent.context) { unsafePointer in
            if let context = context,
               context == unsafePointer {
                guard isUserInteractionEnabled == true && isHidden == false else {
                    return
                }
                if keyPath == CRRefreshComponent.contentSizeKeyPath {
                    if isIgnoreObserving == false {
                        sizeChange(change: change)
                    }
                } else if keyPath == CRRefreshComponent.offsetKeyPath {
                    if isIgnoreObserving == false {
                        offsetChange(change: change)
                    }
                }
            }
        }
    }
}
