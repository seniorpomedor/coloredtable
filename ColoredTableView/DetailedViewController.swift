import UIKit

class DetailedViewController: UIViewController {
    var tuple: (r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: tuple.r, green: tuple.g, blue: tuple.b, alpha: tuple.alpha)
    }
}
