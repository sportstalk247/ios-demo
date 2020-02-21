import UIKit

class UIImageViewBase: UIImageView
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
        layer.masksToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }

    func setup(with: (UIImageViewBase) -> Void)
    {
        setup()
        with(self)
    }
}
