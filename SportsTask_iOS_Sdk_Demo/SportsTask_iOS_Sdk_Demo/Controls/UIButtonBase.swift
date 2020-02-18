import UIKit

class UIButtonBase: UIButton
{
    override func awakeFromNib()
    {
        setup()
    }

    override func prepareForInterfaceBuilder()
    {
        setup()
    }

    func setup()
    {
        // Create an inset for the button.
        contentEdgeInsets = UIEdgeInsets(top: DimensionUtils.buttonInset, left: DimensionUtils.buttonInset, bottom: DimensionUtils.buttonInset, right: DimensionUtils.buttonInset)

        translatesAutoresizingMaskIntoConstraints = false
    }

    func setup(with: (UIButtonBase) -> Void)
    {
        setup()
        with(self)
    }
}
