import UIKit
import PassKit

class ViewController: UIViewController {
    
    private var paymentRequest = PKPaymentRequest()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        paymentRequest.merchantIdentifier = "merchant.com.bugsoft.pay"
        paymentRequest.supportedNetworks = [.masterCard, .visa, .amex]
        paymentRequest.supportedCountries = ["MX", "US"]
        paymentRequest.merchantCapabilities = .capability3DS
        paymentRequest.countryCode = "MX"
        paymentRequest.currencyCode = "MXN"
    }
    
    @IBAction func payAction(_ sender: Any) {
        // Esto es que compro
        paymentRequest.paymentSummaryItems = [PKPaymentSummaryItem(label: "Fabuloso iPhone 14 1 PB", amount: 0.01)]
        
        if let controllerPago = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest) {
            controllerPago.delegate = self
            present(controllerPago, animated: true)
        }
    }
    
}

extension ViewController: PKPaymentAuthorizationViewControllerDelegate {
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true)
    }
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
    }
    
}
