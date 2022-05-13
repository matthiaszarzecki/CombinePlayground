import UIKit
import Combine
import PlaygroundSupport

// Outputs 1 piece of data every second
// A publisher alone doesn't do anything, it needs a subscription
let subscription = Timer.publish(every: 1, on: .main, in: .common)
  .autoconnect()

  // Prints a log message for each event
  .print("streamPrint")

  // SINK: Attaches a subscriber with closure-based behavior
  // to a publisher that never fails.
  .sink(
    receiveCompletion: { output in
      // Called once, when the publisher was completed.
      print("finishes steam with \(output)")
    },
    receiveValue: { value in
      // Can be called multiple times, each time that a
      // new value was emitted by the publisher.
      print("receive value \(value)")
    }
  )

// Stops the publisher after 5 seconds
RunLoop.main.schedule(after: .init(Date(timeIntervalSinceNow: 5))) {
  print("Cancelled Subscription!")
  subscription.cancel()
}
