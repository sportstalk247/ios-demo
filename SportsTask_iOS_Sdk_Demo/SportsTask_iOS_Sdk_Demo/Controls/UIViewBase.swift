import UIKit

class UIViewBase: UIView
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
        translatesAutoresizingMaskIntoConstraints = false
    }

    func setup(with: (UIViewBase) -> Void)
    {
        setup()
        with(self)
    }
}
