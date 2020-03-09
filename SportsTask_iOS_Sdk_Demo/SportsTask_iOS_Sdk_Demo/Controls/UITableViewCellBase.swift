import UIKit

class UITableViewCellBase: UITableViewCell
{
    private var isSetup = false

    override func awakeFromNib()
    {
        if !isSetup
        {
            setup()
        }
    }

    override func prepareForInterfaceBuilder()
    {
        if !isSetup
        {
            setup()
        }
    }

    func setup()
    {
        isSetup = true

        translatesAutoresizingMaskIntoConstraints = false
    }

    func setup(with: (UITableViewCellBase) -> Void)
    {
        if !isSetup
        {
            setup()
        }

        with(self)
    }
}

extension UITableViewCellBase
{
    struct CellConfiguration<TCell> where TCell: UITableViewCellBase
    {
        let identifier = String(describing: TCell.self)

        func dequeue(tableView: UITableView) -> TCell?
        {
            if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? TCell
            {
                if !cell.isSetup
                {
                    cell.setup()
                }

                return cell
            }

            return nil
        }

        func register(tableView: UITableView)
        {
            tableView.register(TCell.self, forCellReuseIdentifier: identifier)
        }
    }
}
