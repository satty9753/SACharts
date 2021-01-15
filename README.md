# SACharts
## This is a framework all about gradient chart.



## Demo
<img src="https://github.com/satty9753/SACharts/blob/master/demo_images/singleArc.PNG?raw=true"  alt="singleArc" width="300">

<img src="https://github.com/satty9753/SACharts/blob/master/demo_images/pieChart.PNG?raw=true" alt="pieChart" width="300">

<img src="https://github.com/satty9753/SACharts/blob/master/demo_images/arcsChart.PNG?raw=true" alt="ArcsChart" width="300">

## Usage
```swift
import UIKit
import SACharts

class ViewController: UIViewController {
    @IBOutlet weak var chartView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //create a gradient chart
        let circle = SingleCircleChart(frame: CGRect(x: 0, y: 0, width: view.frame.width/2, height: view.frame.width/2))
        //draw chart
        circle.drawArcsChart(value: [0.7, 0.5, 0.7], gradientColors: [UIColor.gradientDefaultBlue, UIColor.gradientDefaultYellow, UIColor.gradientDefaultGreen])
        //add chart to view
        self.chartView.addSubview(circle)
    }
}
```
### !IMPORTANT!
✅ Put your gradient chart inside a view, and adjust view's frame through autoLayout

❌ Change gradient chart's origin directly
