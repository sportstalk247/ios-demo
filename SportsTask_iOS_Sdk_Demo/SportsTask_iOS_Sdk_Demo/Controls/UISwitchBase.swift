import UIKit

class UISwitchBase: UISwitch
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

    func setup(with: (UISwitchBase) -> Void)
    {
        setup()
        with(self)
    }
}
