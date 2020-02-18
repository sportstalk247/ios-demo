import UIKit

class UITableViewBase: UITableView
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
        estimatedRowHeight = 44
        keyboardDismissMode = .onDrag
        rowHeight = UITableView.automaticDimension
        translatesAutoresizingMaskIntoConstraints = false
    }

    func setup(with: (UITableViewBase) -> Void)
    {
        setup()
        with(self)
    }
}
