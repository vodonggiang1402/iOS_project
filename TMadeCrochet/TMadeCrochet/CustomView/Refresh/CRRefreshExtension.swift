

import UIKit

private var kCRRefreshHeaderKey = "kCRRefreshHeaderKey"
private var kCRRefreshFooterKey = "kCRRefreshFooterKey"

public typealias CRRefreshView = UIScrollView

extension CRRefreshView {
    public var cr: CRRefreshDSL {
        return CRRefreshDSL(scroll: self)
    }
}

public struct CRRefreshDSL: CRRefreshViewProtocol {
    
    public var scroll: CRRefreshView
    
    internal init(scroll: CRRefreshView) {
        self.scroll = scroll
    }
    @discardableResult
    public func addHeadRefresh(animator: CRRefreshProtocol = NormalHeaderAnimator(), handler: @escaping CRRefreshHandler) -> CRRefreshHeaderView {
        return CRRefreshMake.addHeadRefreshTo(refresh: scroll, animator: animator, handler: handler)
    }
    
    public func beginHeaderRefresh() {
        header?.beginRefreshing()
    }
    
    public func endHeaderRefresh() {
        header?.endRefreshing()
    }
    
    public func removeHeader() {
        var headRefresh = CRRefreshMake(scroll: scroll)
        headRefresh.removeHeader()
    }
    
    @discardableResult
    public func addFootRefresh(animator: CRRefreshProtocol = NormalFooterAnimator(), handler: @escaping CRRefreshHandler) -> CRRefreshFooterView {
        return CRRefreshMake.addFootRefreshTo(refresh: scroll, animator: animator, handler: handler)
    }
    
    public func noticeNoMoreData() {
        footer?.endRefreshing()
        footer?.noticeNoMoreData()
    }
    
    public func resetNoMore() {
        footer?.resetNoMoreData()
    }
    
    public func endLoadingMore() {
        footer?.endRefreshing()
    }
    
    public func removeFooter() {
        endLoadingMore()
        var footRefresh = CRRefreshMake(scroll: scroll)
        footRefresh.removeFooter()
        scroll.contentSize.height = scroll.contentSize.height - NormalFooterAnimator().execute
        scroll.contentInset.bottom = 0
    }
    
    public func isRemoveLoadMore() -> Bool {
        return footer == nil
    }
}


public struct CRRefreshMake: CRRefreshViewProtocol {
    
    public var scroll: CRRefreshView
    
    internal init(scroll: CRRefreshView) {
        self.scroll = scroll
    }
    
    @discardableResult
    internal static func addHeadRefreshTo(refresh: CRRefreshView, animator: CRRefreshProtocol = NormalHeaderAnimator(), handler: @escaping CRRefreshHandler) -> CRRefreshHeaderView {
        var make = CRRefreshMake(scroll: refresh)
        make.removeHeader()
        let header     = CRRefreshHeaderView(animator: animator, handler: handler)
        let headerH    = header.animator.execute
        header.frame   = .init(x: 0, y: -headerH, width: refresh.bounds.size.width, height: headerH)
        refresh.addSubview(header)
        make.header = header
        return header
    }
    
    public mutating func removeHeader() {
        header?.endRefreshing()
        header?.removeFromSuperview()
        header = nil
    }
    
    @discardableResult
    internal static func addFootRefreshTo(refresh: CRRefreshView, animator: CRRefreshProtocol = NormalFooterAnimator(), handler: @escaping CRRefreshHandler) -> CRRefreshFooterView {
        var make = CRRefreshMake(scroll: refresh)
        make.removeFooter()
        let footer     = CRRefreshFooterView(animator: animator, handler: handler)
        let footerH    = footer.animator.execute
        footer.frame   = .init(x: 0, y: refresh.contentSize.height + refresh.contentInset.bottom, width: refresh.bounds.size.width, height: footerH)
        refresh.addSubview(footer)
        make.footer = footer
        return footer
    }
    
    public mutating func removeFooter() {
        footer?.endRefreshing()
        footer?.removeFromSuperview()
        footer = nil
    }
}

public protocol CRRefreshViewProtocol {
    var scroll: CRRefreshView {set get}
    var header: CRRefreshHeaderView? {set get}
    var footer: CRRefreshFooterView? {set get}
}

extension CRRefreshViewProtocol {
    
    public var header: CRRefreshHeaderView? {
        get {
            withUnsafePointer(to: &kCRRefreshHeaderKey) { unsafePointer in
                return (objc_getAssociatedObject(scroll, unsafePointer) as? CRRefreshHeaderView)
            }
        }
        set {
            withUnsafeMutablePointer(to: &kCRRefreshHeaderKey) { unsafePointer in
                objc_setAssociatedObject(scroll, unsafePointer, newValue, .OBJC_ASSOCIATION_RETAIN)
            }
        }
    }
    
    public var footer: CRRefreshFooterView? {
        get {
            withUnsafePointer(to: &kCRRefreshFooterKey) { unsafePointer in
                return (objc_getAssociatedObject(scroll, unsafePointer) as? CRRefreshFooterView)
            }
        }
        set {
            withUnsafeMutablePointer(to: &kCRRefreshFooterKey) { unsafePointer in
                objc_setAssociatedObject(scroll, unsafePointer, newValue, .OBJC_ASSOCIATION_RETAIN)
            }
        }
    }
}
