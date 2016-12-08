import UIKit

extension UIView {
    func pinToSuperview() {
        guard let superview = superview else {return}
        translatesAutoresizingMaskIntoConstraints = false
        let left = NSLayoutConstraint(item: superview, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        let right = NSLayoutConstraint(item: superview, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        let top = NSLayoutConstraint(item: superview, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        let bot = NSLayoutConstraint(item: superview, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        superview.addConstraints([left, right, top, bot])
    }
}

/// 0 ... 1
func random() -> CGFloat {
    return CGFloat(CGFloat(arc4random())/CGFloat(UInt32.max))
}

/// 0...1000
func random() -> Int {
    return Int(arc4random_uniform(1000))
}



class ViewController: UIViewController {
    let tableView = UITableView()
    var data = [(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat)]()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "defult")
        view.addSubview(tableView)
        tableView.pinToSuperview()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refreshValues), for: .valueChanged)
        refreshValues()
    }
    
    func refreshValues() {
        data.removeAll()
        for _ in 0..<random() {
            data.append((r: random(), g: random(), b: random(), alpha: random()))
        }
        tableView.refreshControl?.endRefreshing()
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "defult", for: indexPath) as! TableViewCell
        let tuple = data[indexPath.row]
        let color = UIColor(red: tuple.r, green: tuple.g, blue: tuple.b, alpha: tuple.alpha)
        cell.backgroundColor = color
        cell.label.text = String(format: "%d) alpha %.2f", indexPath.row, tuple.alpha)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailedViewController()
        vc.tuple = data[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
