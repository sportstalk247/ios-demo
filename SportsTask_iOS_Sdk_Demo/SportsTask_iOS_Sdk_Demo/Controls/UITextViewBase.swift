import UIKit

class UITextViewBase: UITextView
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

    func setup(with: (UITextViewBase) -> Void)
    {
        setup()
        with(self)
    }
}
