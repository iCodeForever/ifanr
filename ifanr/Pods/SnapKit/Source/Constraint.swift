//
//  SnapKit
//
//  Copyright (c) 2011-Present SnapKit Team - https://github.com/SnapKit
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#if os(iOS) || os(tvOS)
    import UIKit
#else
    import AppKit
#endif

public class Constraint {
    
    internal let sourceLocation: (String, UInt)
    internal let label: String?
    
<<<<<<< HEAD
    public func updateOffset(amount: Float) -> Void { fatalError("Must be implemented by Concrete subclass.") }
    public func updateOffset(amount: Double) -> Void { fatalError("Must be implemented by Concrete subclass.") }
    public func updateOffset(amount: CGFloat) -> Void { fatalError("Must be implemented by Concrete subclass.") }
    public func updateOffset(amount: Int) -> Void { fatalError("Must be implemented by Concrete subclass.") }
    public func updateOffset(amount: UInt) -> Void { fatalError("Must be implemented by Concrete subclass.") }
    public func updateOffset(amount: CGPoint) -> Void { fatalError("Must be implemented by Concrete subclass.") }
    public func updateOffset(amount: CGSize) -> Void { fatalError("Must be implemented by Concrete subclass.") }
    public func updateOffset(amount: EdgeInsets) -> Void { fatalError("Must be implemented by Concrete subclass.") }
    
    public func updateInsets(amount: EdgeInsets) -> Void { fatalError("Must be implemented by Concrete subclass.") }
    
    public func updatePriority(priority: Float) -> Void { fatalError("Must be implemented by Concrete subclass.") }
    public func updatePriority(priority: Double) -> Void { fatalError("Must be implemented by Concrete subclass.") }
    public func updatePriority(priority: CGFloat) -> Void { fatalError("Must be implemented by Concrete subclass.") }
    public func updatePriority(priority: UInt) -> Void { fatalError("Must be implemented by Concrete subclass.") }
    public func updatePriority(priority: Int) -> Void { fatalError("Must be implemented by Concrete subclass.") }
    public func updatePriorityRequired() -> Void { fatalError("Must be implemented by Concrete subclass.") }
    public func updatePriorityHigh() -> Void { fatalError("Must be implemented by Concrete subclass.") }
    public func updatePriorityMedium() -> Void { fatalError("Must be implemented by Concrete subclass.") }
    public func updatePriorityLow() -> Void { fatalError("Must be implemented by Concrete subclass.") }

    public var layoutConstraints: [LayoutConstraint] { fatalError("Must be implemented by Concrete subclass.") }
    
    internal var makerFile: String = "Unknown"
    internal var makerLine: UInt = 0
    
}

/**
    Used internally to implement a ConcreteConstraint
*/
internal class ConcreteConstraint: Constraint {
    
    internal override func updateOffset(amount: Float) -> Void {
        self.constant = amount
    }
    internal override func updateOffset(amount: Double) -> Void {
        self.updateOffset(Float(amount))
    }
    internal override func updateOffset(amount: CGFloat) -> Void {
        self.updateOffset(Float(amount))
    }
    internal override func updateOffset(amount: Int) -> Void {
        self.updateOffset(Float(amount))
    }
    internal override func updateOffset(amount: UInt) -> Void {
        self.updateOffset(Float(amount))
    }
    internal override func updateOffset(amount: CGPoint) -> Void {
        self.constant = amount
    }
    internal override func updateOffset(amount: CGSize) -> Void {
        self.constant = amount
    }
    internal override func updateOffset(amount: EdgeInsets) -> Void {
        self.constant = amount
    }
    
    internal override func updateInsets(amount: EdgeInsets) -> Void {
        self.constant = EdgeInsets(top: amount.top, left: amount.left, bottom: -amount.bottom, right: -amount.right)
    }
    
    internal override func updatePriority(priority: Float) -> Void {
        self.priority = priority
    }
    internal override func updatePriority(priority: Double) -> Void {
        self.updatePriority(Float(priority))
    }
    internal override func updatePriority(priority: CGFloat) -> Void {
        self.updatePriority(Float(priority))
    }
    internal override func updatePriority(priority: UInt) -> Void {
        self.updatePriority(Float(priority))
    }
    internal override func updatePriority(priority: Int) -> Void {
        self.updatePriority(Float(priority))
    }
    internal override func updatePriorityRequired() -> Void {
        self.updatePriority(Float(1000.0))
    }
    internal override func updatePriorityHigh() -> Void {
        self.updatePriority(Float(750.0))
    }
    internal override func updatePriorityMedium() -> Void {
        #if os(iOS) || os(tvOS)
        self.updatePriority(Float(500.0))
        #else
        self.updatePriority(Float(501.0))
        #endif
    }
    internal override func updatePriorityLow() -> Void {
        self.updatePriority(Float(250.0))
    }
    
    internal override func install() -> [LayoutConstraint] {
        return self.installOnView(updateExisting: false, file: self.makerFile, line: self.makerLine)
    }
    
    internal override func uninstall() -> Void {
        self.uninstallFromView()
    }
    
    internal override func activate() -> Void {
        guard self.installInfo != nil else {
            self.install()
            return
        }
        #if SNAPKIT_DEPLOYMENT_LEGACY
        guard #available(iOS 8.0, OSX 10.10, *) else {
            self.install()
            return
        }
        #endif
        let layoutConstraints = self.installInfo!.layoutConstraints.allObjects as! [LayoutConstraint]
        if layoutConstraints.count > 0 {
            NSLayoutConstraint.activateConstraints(layoutConstraints)
        }
    }
    
    internal override func deactivate() -> Void {
        guard self.installInfo != nil else {
            return
        }
        #if SNAPKIT_DEPLOYMENT_LEGACY
        guard #available(iOS 8.0, OSX 10.10, *) else {
            return
        }
        #endif
        let layoutConstraints = self.installInfo!.layoutConstraints.allObjects as! [LayoutConstraint]
        if layoutConstraints.count > 0 {
            NSLayoutConstraint.deactivateConstraints(layoutConstraints)
        }
    }
    
    private let fromItem: ConstraintItem
    private let toItem: ConstraintItem
=======
    private let from: ConstraintItem
    private let to: ConstraintItem
>>>>>>> b18bd8c21aabb1c63e51708b735d2a09f40b6baf
    private let relation: ConstraintRelation
    private let multiplier: ConstraintMultiplierTarget
    private var constant: ConstraintConstantTarget {
        didSet {
            self.updateConstantAndPriorityIfNeeded()
        }
    }
    private var priority: ConstraintPriorityTarget {
        didSet {
          self.updateConstantAndPriorityIfNeeded()
        }
    }
    private var layoutConstraints: [LayoutConstraint]
    
    // MARK: Initialization
    
<<<<<<< HEAD
    private var installInfo: ConcreteConstraintInstallInfo? = nil
    
    override var layoutConstraints: [LayoutConstraint] {
        if installInfo == nil {
            install()
        }
        
        guard let installInfo = installInfo else {
            return []
        }
        return installInfo.layoutConstraints.allObjects as! [LayoutConstraint]
    }

    internal init(fromItem: ConstraintItem, toItem: ConstraintItem, relation: ConstraintRelation, constant: Any, multiplier: Float, priority: Float, label: String? = nil) {
        self.fromItem = fromItem
        self.toItem = toItem
=======
    internal init(from: ConstraintItem,
                  to: ConstraintItem,
                  relation: ConstraintRelation,
                  sourceLocation: (String, UInt),
                  label: String?,
                  multiplier: ConstraintMultiplierTarget,
                  constant: ConstraintConstantTarget,
                  priority: ConstraintPriorityTarget) {
        self.from = from
        self.to = to
>>>>>>> b18bd8c21aabb1c63e51708b735d2a09f40b6baf
        self.relation = relation
        self.sourceLocation = sourceLocation
        self.label = label
        self.multiplier = multiplier
        self.constant = constant
        self.priority = priority
        self.layoutConstraints = []
        
        // get attributes
        let layoutFromAttributes = self.from.attributes.layoutAttributes
        let layoutToAttributes = self.to.attributes.layoutAttributes
        
        // get layout from
        let layoutFrom: ConstraintView = self.from.view!
        
        // get relation
        let layoutRelation = self.relation.layoutRelation
        
        for layoutFromAttribute in layoutFromAttributes {
            // get layout to attribute
            let layoutToAttribute: NSLayoutAttribute
            #if os(iOS) || os(tvOS)
                if layoutToAttributes.count > 0 {
                    if self.from.attributes == .edges && self.to.attributes == .margins {
                        switch layoutFromAttribute {
                        case .left:
                            layoutToAttribute = .leftMargin
                        case .right:
                            layoutToAttribute = .rightMargin
                        case .top:
                            layoutToAttribute = .topMargin
                        case .bottom:
                            layoutToAttribute = .bottomMargin
                        default:
                            fatalError()
                        }
                    } else if self.from.attributes == .margins && self.to.attributes == .edges {
                        switch layoutFromAttribute {
                        case .leftMargin:
                            layoutToAttribute = .left
                        case .rightMargin:
                            layoutToAttribute = .right
                        case .topMargin:
                            layoutToAttribute = .top
                        case .bottomMargin:
                            layoutToAttribute = .bottom
                        default:
                            fatalError()
                        }
                    } else if self.from.attributes == self.to.attributes {
                        layoutToAttribute = layoutFromAttribute
                    } else {
                        layoutToAttribute = layoutToAttributes[0]
                    }
                } else {
                    if self.to.target == nil && (layoutFromAttribute == .centerX || layoutFromAttribute == .centerY) {
                        layoutToAttribute = layoutFromAttribute == .centerX ? .left : .top
                    } else {
                        layoutToAttribute = layoutFromAttribute
                    }
                }
            #else
                if self.from.attributes == self.to.attributes {
                    layoutToAttribute = layoutFromAttribute
                } else if layoutToAttributes.count > 0 {
                    layoutToAttribute = layoutToAttributes[0]
                } else {
                    layoutToAttribute = layoutFromAttribute
                }
            #endif
            
            // get layout constant
            let layoutConstant: CGFloat = self.constant.constraintConstantTargetValueFor(layoutAttribute: layoutToAttribute)
            
            // get layout to
            var layoutTo: AnyObject? = self.to.target
            
            // use superview if possible
            if layoutTo == nil && layoutToAttribute != .width && layoutToAttribute != .height {
                layoutTo = layoutFrom.superview
            }
            
            // create layout constraint
            let layoutConstraint = LayoutConstraint(
                item: layoutFrom,
                attribute: layoutFromAttribute,
                relatedBy: layoutRelation,
                toItem: layoutTo,
                attribute: layoutToAttribute,
                multiplier: self.multiplier.constraintMultiplierTargetValue,
                constant: layoutConstant
            )
            
            // set label
            layoutConstraint.label = self.label
            
            // set priority
            layoutConstraint.priority = self.priority.constraintPriorityTargetValue
            
            // set constraint
            layoutConstraint.constraint = self
            
            // append
            self.layoutConstraints.append(layoutConstraint)
        }
    }
    
    // MARK: Public
    
    @available(*, deprecated:3.0, message:"Use activate().")
    public func install() {
        self.activate()
    }
    
    @available(*, deprecated:3.0, message:"Use deactivate().")
    public func uninstall() {
        self.deactivate()
    }
    
    public func activate() {
        self.activateIfNeeded()
    }
    
    public func deactivate() {
        self.deactivateIfNeeded()
    }
    
<<<<<<< HEAD
    private func snp_constantForValue(value: Any?) -> CGFloat {
        // Float
        if let float = value as? Float {
            return CGFloat(float)
        }
            // Double
        else if let double = value as? Double {
            return CGFloat(double)
        }
            // UInt
        else if let int = value as? Int {
            return CGFloat(int)
        }
            // Int
        else if let uint = value as? UInt {
            return CGFloat(uint)
        }
            // CGFloat
        else if let float = value as? CGFloat {
            return float
        }
            // CGSize
        else if let size = value as? CGSize {
            if self == .Width {
                return size.width
            } else if self == .Height {
                return size.height
            }
        }
            // CGPoint
        else if let point = value as? CGPoint {
            #if os(iOS) || os(tvOS)
                switch self {
                case .Left, .CenterX, .LeftMargin, .CenterXWithinMargins: return point.x
                case .Top, .CenterY, .TopMargin, .CenterYWithinMargins, .LastBaseline, .FirstBaseline: return point.y
                case .Right, .RightMargin: return point.x
                case .Bottom, .BottomMargin: return point.y
                case .Leading, .LeadingMargin: return point.x
                case .Trailing, .TrailingMargin: return point.x
                case .Width, .Height, .NotAnAttribute: return CGFloat(0)
                }
            #else
                switch self {
                case .Left, .CenterX: return point.x
                case .Top, .CenterY, .LastBaseline: return point.y
                case .Right: return point.x
                case .Bottom: return point.y
                case .Leading: return point.x
                case .Trailing: return point.x
                case .Width, .Height, .NotAnAttribute: return CGFloat(0)
                case .FirstBaseline: return point.y
                }
            #endif
        }
            // EdgeInsets
        else if let insets = value as? EdgeInsets {
            #if os(iOS) || os(tvOS)
                switch self {
                case .Left, .CenterX, .LeftMargin, .CenterXWithinMargins: return insets.left
                case .Top, .CenterY, .TopMargin, .CenterYWithinMargins, .LastBaseline, .FirstBaseline: return insets.top
                case .Right, .RightMargin: return insets.right
                case .Bottom, .BottomMargin: return insets.bottom
                case .Leading, .LeadingMargin: return  (Config.interfaceLayoutDirection == .LeftToRight) ? insets.left : -insets.right
                case .Trailing, .TrailingMargin: return  (Config.interfaceLayoutDirection == .LeftToRight) ? insets.right : -insets.left
                case .Width: return -insets.left + insets.right
                case .Height: return -insets.top + insets.bottom
                case .NotAnAttribute: return CGFloat(0)
                }
            #else
                switch self {
                case .Left, .CenterX: return insets.left
                case .Top, .CenterY, .LastBaseline: return insets.top
                case .Right: return insets.right
                case .Bottom: return insets.bottom
                case .Leading: return  (Config.interfaceLayoutDirection == .LeftToRight) ? insets.left : -insets.right
                case .Trailing: return  (Config.interfaceLayoutDirection == .LeftToRight) ? insets.right : -insets.left
                case .Width: return -insets.left + insets.right
                case .Height: return -insets.top + insets.bottom
                case .NotAnAttribute: return CGFloat(0)
                case .FirstBaseline: return insets.bottom
                }
=======
    @discardableResult
    public func update(offset: ConstraintOffsetTarget) -> Constraint {
        self.constant = offset.constraintOffsetTargetValue
        return self
    }
    
    @discardableResult
    public func update(inset: ConstraintInsetTarget) -> Constraint {
        self.constant = inset.constraintInsetTargetValue
        return self
    }
    
    @discardableResult
    public func update(priority: ConstraintPriorityTarget) -> Constraint {
        self.priority = priority.constraintPriorityTargetValue
        return self
    }
    
    @available(*, deprecated:3.0, message:"Use update(offset: ConstraintOffsetTarget) instead.")
    public func updateOffset(amount: ConstraintOffsetTarget) -> Void { self.update(offset: amount) }
    
    @available(*, deprecated:3.0, message:"Use update(inset: ConstraintInsetTarget) instead.")
    public func updateInsets(amount: ConstraintInsetTarget) -> Void { self.update(inset: amount) }
    
    @available(*, deprecated:3.0, message:"Use update(priority: ConstraintPriorityTarget) instead.")
    public func updatePriority(amount: ConstraintPriorityTarget) -> Void { self.update(priority: amount) }
    
    @available(*, obsoleted:3.0, message:"Use update(priority: ConstraintPriorityTarget) instead.")
    public func updatePriorityRequired() -> Void {}
    
    @available(*, obsoleted:3.0, message:"Use update(priority: ConstraintPriorityTarget) instead.")
    public func updatePriorityHigh() -> Void { fatalError("Must be implemented by Concrete subclass.") }
    
    @available(*, obsoleted:3.0, message:"Use update(priority: ConstraintPriorityTarget) instead.")
    public func updatePriorityMedium() -> Void { fatalError("Must be implemented by Concrete subclass.") }
    
    @available(*, obsoleted:3.0, message:"Use update(priority: ConstraintPriorityTarget) instead.")
    public func updatePriorityLow() -> Void { fatalError("Must be implemented by Concrete subclass.") }
    
    // MARK: Internal
    
    internal func updateConstantAndPriorityIfNeeded() {
        for layoutConstraint in self.layoutConstraints {
            let attribute = (layoutConstraint.secondAttribute == .notAnAttribute) ? layoutConstraint.firstAttribute : layoutConstraint.secondAttribute
            layoutConstraint.constant = self.constant.constraintConstantTargetValueFor(layoutAttribute: attribute)
            
            #if os(iOS) || os(tvOS)
                let requiredPriority: UILayoutPriority = UILayoutPriorityRequired
            #else
                let requiredPriority: Float = 1000.0
>>>>>>> b18bd8c21aabb1c63e51708b735d2a09f40b6baf
            #endif
            
            
            if (layoutConstraint.priority < requiredPriority), (self.priority.constraintPriorityTargetValue != requiredPriority) {
                layoutConstraint.priority = self.priority.constraintPriorityTargetValue
            }
        }
    }
    
    internal func activateIfNeeded(updatingExisting: Bool = false) {
        guard let view = self.from.view else {
            print("WARNING: SnapKit failed to get from view from constraint. Activate will be a no-op.")
            return
        }
        let layoutConstraints = self.layoutConstraints
        let existingLayoutConstraints = view.snp.constraints.map({ $0.layoutConstraints }).reduce([]) { $0 + $1 }
        
        if updatingExisting {
            for layoutConstraint in layoutConstraints {
                let existingLayoutConstraint = existingLayoutConstraints.first { $0 == layoutConstraint }
                guard let updateLayoutConstraint = existingLayoutConstraint else {
                    fatalError("Updated constraint could not find existing matching constraint to update: \(layoutConstraint)")
                }
                
                let updateLayoutAttribute = (updateLayoutConstraint.secondAttribute == .notAnAttribute) ? updateLayoutConstraint.firstAttribute : updateLayoutConstraint.secondAttribute
                updateLayoutConstraint.constant = self.constant.constraintConstantTargetValueFor(layoutAttribute: updateLayoutAttribute)
            }
        } else {
            NSLayoutConstraint.activate(layoutConstraints)
            view.snp.add(constraints: [self])
        }
    }
    
    internal func deactivateIfNeeded() {
        guard let view = self.from.view else {
            print("WARNING: SnapKit failed to get from view from constraint. Deactivate will be a no-op.")
            return
        }
        let layoutConstraints = self.layoutConstraints
        NSLayoutConstraint.deactivate(layoutConstraints)
        view.snp.remove(constraints: [self])
    }
}
