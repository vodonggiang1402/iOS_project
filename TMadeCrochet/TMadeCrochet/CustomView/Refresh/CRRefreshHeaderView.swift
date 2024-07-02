import UIKit

open class CRRefreshHeaderView: CRRefreshComponent {
    
    fileprivate var previousOffsetY: CGFloat = 0.0
    fileprivate var scrollViewBounces: Bool  = true
    fileprivate var insetTDelta: CGFloat     = 0.0
    fileprivate var holdInsetTDelta: CGFloat = 0.0
    private var isEnding: Bool = false
    
    public convenience init(animator: CRRefreshProtocol = NormalHeaderAnimator(), handler: @escaping CRRefreshHandler) {
        self.init(frame: .zero)
        self.handler  = handler
        self.animator = animator
    }
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        DispatchQueue.main.async { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.scrollViewBounces = weakSelf.scrollView?.bounces ?? true
        }
    }
    
    open override func start() {
        guard let scrollView = scrollView else { return }
        ignoreObserver(true)
        scrollView.bounces = false
        super.start()
        animator.refreshBegin(view: self)
        var insets           = scrollView.contentInset
        scrollViewInsets.top = insets.top
        insets.top          += animator.execute
        insetTDelta          = -animator.execute
        holdInsetTDelta      = -(animator.execute - animator.hold)
        var point = scrollView.contentOffset;
        point.y = -insets.top
        UIView.animate(withDuration: CRRefreshComponent.animationDuration, animations: {
            
            scrollView.contentOffset.y = self.previousOffsetY
            scrollView.contentInset    = insets
            scrollView.setContentOffset(point, animated: false);
        }) { [weak self] (finished) in
            guard let self = self else {return}
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.handler?()
                self.ignoreObserver(false)
                scrollView.bounces = self.scrollViewBounces
            }
        }
    }
    
    open override func stop() {
        guard let scrollView = scrollView else { return }
        ignoreObserver(true)
        animator.refreshWillEnd(view: self)
        if self.animator.hold != 0 {
            UIView.animate(withDuration: CRRefreshComponent.animationDuration) {
                scrollView.contentInset.top += self.holdInsetTDelta
            }
        }
        func beginStop() {
            guard isEnding == false, isRefreshing else {
                return
            }
            isEnding = true
            animator.refreshEnd(view: self, finish: false)
            super.stop()
            UIView.animate(withDuration: CRRefreshComponent.animationDuration, animations: {
                scrollView.contentInset.top += self.insetTDelta - self.holdInsetTDelta
            }) { [weak self] (finished) in
                guard let self = self else {return}
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.state = .idle
                    self.animator.refreshEnd(view: self, finish: true)
                    self.ignoreObserver(false)
                    self.isEnding = false
                }
            }
        }
        if animator.endDelay > 0 {
            if self.isEnding == false {
                let delay =  DispatchTimeInterval.milliseconds(Int(animator.endDelay * 1000))
                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                    beginStop()
                })
            }
        } else {
            beginStop()
        }
    }

    open override func offsetChange(change: [NSKeyValueChangeKey : Any]?) {
        guard let scrollView = scrollView else { return }
        super.offsetChange(change: change)
        guard isRefreshing == false else {
            if self.window == nil {return}
            let top          = scrollViewInsets.top
            let offsetY      = scrollView.contentOffset.y
            let height       = frame.size.height
            var scrollingTop = (-offsetY > top) ? -offsetY : top
            scrollingTop     = (scrollingTop > height + top) ? (height + top) : scrollingTop
            scrollView.contentInset.top = scrollingTop
            insetTDelta      = scrollViewInsets.top - scrollingTop
            return
        }
        
        var isRecordingProgress = false
        defer {
            if isRecordingProgress == true {
                let percent = -(previousOffsetY + scrollViewInsets.top) / animator.trigger
                animator.refresh(view: self, progressDidChange: percent)
            }
        }
        
        let offsets = previousOffsetY + scrollViewInsets.top
        if offsets < -animator.trigger {
            if isRefreshing == false {
                if scrollView.isDragging == false, state == .pulling {
                    beginRefreshing()
                    state = .refreshing
                } else {
                    if scrollView.isDragging {
                        state = .pulling
                        isRecordingProgress = true
                    }
                }
            }
        } else if offsets < 0 {
            if isRefreshing == false {
                state = .idle
                isRecordingProgress = true
            }
        }
        previousOffsetY = scrollView.contentOffset.y
    }
}
