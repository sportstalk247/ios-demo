import UIKit

enum ConstraintType
{
    case bottom
    case centerX
    case centerY
    case height
    case left
    case right
    case top
    case width
}

extension UIView
{
    @discardableResult
    func alignCenterConstraints(
            centerX: NSLayoutXAxisAnchor? = nil, centerXConstant: CGFloat = 0,
            centerY: NSLayoutYAxisAnchor? = nil, centerYConstant: CGFloat = 0) -> Dictionary<ConstraintType, NSLayoutConstraint>
    {
        var ret = Dictionary<ConstraintType, NSLayoutConstraint>()

        if let centerX = centerX
        {
            ret[.centerX] = centerXAnchor.constraint(equalTo: centerX, constant: centerXConstant)
        }

        if let centerY = centerY
        {
            ret[.centerY] = centerYAnchor.constraint(equalTo: centerY, constant: centerYConstant)
        }

        // Activate the constraints.
        for item in ret
        {
            item.value.isActive = true
        }

        return ret
    }
    @discardableResult
    func anchorConstraints(
            left: NSLayoutXAxisAnchor? = nil, leftConstant: CGFloat = 0,
            top: NSLayoutYAxisAnchor? = nil, topConstant: CGFloat = 0,
            right: NSLayoutXAxisAnchor? = nil, rightConstant: CGFloat = 0,
            bottom: NSLayoutYAxisAnchor? = nil, bottomConstant: CGFloat = 0) -> Dictionary<ConstraintType, NSLayoutConstraint>
    {
        var ret = Dictionary<ConstraintType, NSLayoutConstraint>()

        if let left = left
        {
            ret[.left] = leftAnchor.constraint(equalTo: left, constant: leftConstant)
        }

        if let top = top
        {
            ret[.top] = topAnchor.constraint(equalTo: top, constant: topConstant)
        }

        if let right = right
        {
            ret[.right] = rightAnchor.constraint(equalTo: right, constant: rightConstant)
        }

        if let bottom = bottom
        {
            ret[.bottom] = bottomAnchor.constraint(equalTo: bottom, constant: bottomConstant)
        }

        // Activate the constraints.
        for item in ret
        {
            item.value.isActive = true
        }

        return ret
    }
    @discardableResult
    func anchorConstraintsWithSystemSpacing(
            left: NSLayoutXAxisAnchor? = nil, leftMultiplier: CGFloat = 1.0,
            top: NSLayoutYAxisAnchor? = nil, topMultiplier: CGFloat = 1.0,
            right: NSLayoutXAxisAnchor? = nil, rightMultiplier: CGFloat = 1.0,
            bottom: NSLayoutYAxisAnchor? = nil, bottomMultiplier: CGFloat = 1.0) -> Dictionary<ConstraintType, NSLayoutConstraint>
    {
        var ret = Dictionary<ConstraintType, NSLayoutConstraint>()

        if let left = left
        {
            ret[.left] = leftAnchor.constraint(equalToSystemSpacingAfter: left, multiplier: leftMultiplier)
        }

        if let top = top
        {
            ret[.top] = topAnchor.constraint(equalToSystemSpacingBelow: top, multiplier: topMultiplier)
        }

        if let right = right
        {
            ret[.right] = right.constraint(equalToSystemSpacingAfter: rightAnchor, multiplier: rightMultiplier)
        }

        if let bottom = bottom
        {
            ret[.bottom] = bottom.constraint(equalToSystemSpacingBelow: bottomAnchor, multiplier: bottomMultiplier)
        }

        // Activate the constraints.
        for item in ret
        {
            item.value.isActive = true
        }

        return ret
    }

    @discardableResult
    func safeAnchorConstraints(
            left: NSLayoutXAxisAnchor? = nil, leftConstant: CGFloat = 0,
            top: NSLayoutYAxisAnchor? = nil, topConstant: CGFloat = 0,
            right: NSLayoutXAxisAnchor? = nil, rightConstant: CGFloat = 0,
            bottom: NSLayoutYAxisAnchor? = nil, bottomConstant: CGFloat = 0) -> Dictionary<ConstraintType, NSLayoutConstraint>
    {
        var ret = Dictionary<ConstraintType, NSLayoutConstraint>()

        if let left = left
        {
            ret[.left] = safeAreaLayoutGuide.leftAnchor.constraint(equalTo: left, constant: leftConstant)
        }

        if let top = top
        {
            ret[.top] = safeAreaLayoutGuide.topAnchor.constraint(equalTo: top, constant: topConstant)
        }

        if let right = right
        {
            ret[.right] = safeAreaLayoutGuide.rightAnchor.constraint(equalTo: right, constant: rightConstant)
        }

        if let bottom = bottom
        {
            ret[.bottom] = safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: bottom, constant: bottomConstant)
        }

        // Activate the constraints.
        for item in ret
        {
            item.value.isActive = true
        }

        return ret
    }
    @discardableResult
    func sizeConstraints(size: CGSize? = nil) -> Dictionary<ConstraintType, NSLayoutConstraint>
    {
        return sizeConstraints(height: size?.height, width: size?.width)
    }
    @discardableResult
    func sizeConstraints(height: CGFloat? = nil, width: CGFloat? = nil) -> Dictionary<ConstraintType, NSLayoutConstraint>
    {
        var ret = Dictionary<ConstraintType, NSLayoutConstraint>()

        if let height = height
        {
            ret[.height] = heightAnchor.constraint(equalToConstant: height)
        }

        if let width = width
        {
            ret[.width] = widthAnchor.constraint(equalToConstant: width)
        }

        // Activate the constraints.
        for item in ret
        {
            item.value.isActive = true
        }

        return ret
    }
}
