import UIKit
import EventKit

class EventCalendarTableViewCell: UITableViewCell {

    @IBOutlet var titileLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    var event: EKEvent! {
        didSet {
            
            titileLabel.text = event.title
            dateLabel.text = formatToString(date: event.startDate!) + "~" + formatToString(date: event.endDate!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func tappedURLButton(_ sender: Any) {
    
        let interval = event.startDate!.timeIntervalSinceReferenceDate
        let url = URL(string: "calshow:\(interval)")!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func formatToString(date: Date) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        return dateFormatter.string(from: date)
    }
    
}
