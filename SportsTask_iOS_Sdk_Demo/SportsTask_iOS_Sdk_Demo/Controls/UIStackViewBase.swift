import UIKit

class UIStackViewBase: UIStackView
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

    func setup(with: (UIStackViewBase) -> Void)
    {
        setup()
        with(self)
    }
}
