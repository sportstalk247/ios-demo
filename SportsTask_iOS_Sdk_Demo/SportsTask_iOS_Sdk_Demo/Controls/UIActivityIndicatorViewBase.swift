import UIKit

class UIActivityIndicatorViewBase: UIActivityIndicatorView
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

    func setup(with: (UIActivityIndicatorViewBase) -> Void)
    {
        setup()
        with(self)
    }
}
