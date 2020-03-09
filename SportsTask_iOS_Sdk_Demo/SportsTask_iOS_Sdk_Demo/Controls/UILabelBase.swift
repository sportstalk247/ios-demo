import UIKit

class UILabelBase: UILabel
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

    func setup(with: (UILabelBase) -> Void)
    {
        setup()
        with(self)
    }
}
