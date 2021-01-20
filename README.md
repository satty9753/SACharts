# SACharts
This is a framework all about gradient chart.

## Installation
### cocoapods
```
pod 'SACharts'
```
## Demo
<img src="https://github.com/satty9753/SACharts/blob/master/demo_images/singleArc.PNG?raw=true"  alt="singleArc" width="300">

<img src="https://github.com/satty9753/SACharts/blob/master/demo_images/pieChart.PNG?raw=true" alt="pieChart" width="300">

<img src="https://github.com/satty9753/SACharts/blob/master/demo_images/arcsChart.PNG?raw=true" alt="ArcsChart" width="300"> 

<img src="https://github.com/satty9753/SACharts/blob/master/demo_images/concentricChart.PNG?raw=true"
alt="ConcentricChart" width="300">


## Usage
#### SingleCircleChart
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
#### ConcentricChart
```swift
let circles = ConcentricChart(frame: CGRect(x: 0, y: 0, width: view.frame.width/2, height: view.frame.width/2))
//set appearence for label & color
circles.setItems(contents: ["aaa", "bbb", "ccc"], colors: [UIColor.gradientDefaultBlue, UIColor.gradientDefaultYellow, UIColor.gradientDefaultPurple])
//set value
circles.draw(numbers: [300, 100, 64])
```

### !IMPORTANT!
✅ Put your gradient chart inside a view, and adjust view's frame through autoLayout

❌ Change gradient chart's origin directly
