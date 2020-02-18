import UIKit

@IBDesignable class UITextFieldBase: UITextField
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

        borderStyle = .roundedRect
    }

    func setup(with: (UITextFieldBase) -> Void)
    {
        setup()
        with(self)
    }
}
