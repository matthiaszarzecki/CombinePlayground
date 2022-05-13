import UIKit
import Combine
import PlaygroundSupport

// Outputs 1 piece of data every second
let subscription = Timer.publish(every: 1, on: .main, in: .common)
  .autoconnect()
  .sink { output in
    print("finishes steam with \(output)")
  } receiveValue: { value in
    print("receive value \(value)")
  }

// Stops the publisher after 5 seconds
RunLoop.main.schedule(after: .init(Date(timeIntervalSinceNow: 5))) {
  print("Cancelled Subscription!")
  subscription.cancel()
}
