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
        translatesAutoresizingMaskIntoConstraints = false
    }

    func setup(with: (UIButtonBase) -> Void)
    {
        setup()
        with(self)
    }
}
