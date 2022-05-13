import UIKit
import Combine
import PlaygroundSupport

// Outputs 1 piece of data every second
// A publisher alone doesn't do anything, it needs a subscription
var subscription: Cancellable? = Timer.publish(every: 1, on: .main, in: .common)
  // automatically connects to its upstream connectable publisher.
  // Certain publishers, like Timer.TimerPublisher, require a connection first.
  .autoconnect()

  // Prints a log message for each event
  .print("streamPrint")

  // Slows down rate of publishing. When e.g. the publisher gives out a value
  // every 0.1 seconds, less data passes by here
  .throttle(for: .seconds(1), scheduler: .main, latest: true)

  // Checks incoming data and can adapt it
  .scan(
    0,
    { (count, _) in
      return count + 0
    }
  )

  // Filters the incoming data so that only data passing the condition
  // is passing, in this case everything above 5 and below 15
  .filter(
    { $0 > 5 && $0 < 15}
  )

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
  
  //subscription.cancel()
  subscription = nil
}
