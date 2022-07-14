import Foundation
import UIKit

public class GameGestureRecognizer: UIGestureRecognizer {
    private let eventBus: EventBus
    private let maximumScalePreviousTouchTime: Double = 0.1
    private var touchPoints: [UITouch: CGPoint] = [:]
    private var initialTouchPoints: [UITouch: CGPoint] = [:]
    private var initialScale: CGFloat = 1.0
    private var previousDragTimes: [UITouch: [(TimeInterval, CGPoint)]] = [:]
    private var previousScaleTimes: [(TimeInterval, CGFloat)] = []
    private var previousVelocityTimeInterval: TimeInterval? = nil
    
    public var translation: CGSize = .zero
    public var scale: CGFloat = 1.0
    public var predictedExtraTranslation: CGSize = .zero
    public var predictedExtraScale: CGFloat = 1.0
    
    public init(target: Any?, action: Selector?, eventBus: EventBus) {
        self.eventBus = eventBus
        super.init(target: target, action: action)
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        state = .began

        predictedExtraScale = 1.0
        
        touches.forEach { touch in
            if touchPoints[touch] == nil {
                if touchPoints.count < 2 {
                    touchPoints[touch] = touch.location(in: self.view)
                    initialTouchPoints[touch] = touch.location(in: self.view)
                    previousDragTimes[touch] = [(touch.timestamp, touch.location(in: self.view))]
                } else {
                    self.ignore(touch, for: event)

                }
            }
        }
    }
    
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        
        var offset: CGSize = .zero
        
        
        touches.enumerated().forEach { index, touch in
            
            let newPoint = touch.location(in: self.view)
            let previousPoint = touch.previousLocation(in: self.view)
            
            touchPoints[touch] = newPoint
            
            if previousDragTimes[touch] != nil {
                if previousDragTimes[touch]!.count >= 3 {
                    previousDragTimes[touch]!.removeFirst()
                }
                previousDragTimes[touch]!.append((touch.timestamp, touch.location(in: self.view)))
            }
            
            offset.width += newPoint.x - previousPoint.x
            offset.height += newPoint.y - previousPoint.y
        }
        state = .changed

        super.touchesMoved(touches, with: event)

        
        if touchPoints.count == 2 {
            // Calculate scale
            
            // Calculate initial magnitude
            var initialWidth: CGFloat = 0
            var initialHeight: CGFloat = 0
            for (_, value) in initialTouchPoints {
                initialWidth = -initialWidth - value.x
                initialHeight = -initialHeight - value.y
            }
            
            let initialMagnitude = sqrt(initialWidth * initialWidth + initialHeight * initialHeight)
            
            var finalWidth: CGFloat = 0
            var finalHeight: CGFloat = 0
            for (_, value) in touchPoints {
                finalWidth = -finalWidth - value.x
                finalHeight = -finalHeight - value.y
            }
            
            let finalMagnitude = sqrt(finalWidth * finalWidth + finalHeight * finalHeight)

            scale = finalMagnitude * initialScale / initialMagnitude
            
            if previousScaleTimes.count >= 3 {
                previousScaleTimes.removeFirst()
            }
            previousScaleTimes.append((event.timestamp, scale))

        } else {
            touchPoints.forEach { touch, point in
                initialTouchPoints[touch] = point
            }
        }
        
        
        
        translation.width += offset.width / CGFloat(touchPoints.count)
        translation.height += offset.height / CGFloat(touchPoints.count)
    }
    
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        // Handle single tap
        if previousDragTimes.count == 1 && previousDragTimes.values.first?.count == 1 {
            if let tapLocation = touchPoints.values.first {
                eventBus.tap(recognizerLocation: tapLocation)
                
                super.touchesEnded(touches, with: event)
                self.state = .ended
                return
            }
        }
        
        touches.forEach { touch in
            touchPoints[touch] = nil
            initialTouchPoints[touch] = nil
        }
        
        initialScale = scale
        
        touchPoints.forEach { touch, point in
            initialTouchPoints[touch] = point
        }
        
        var predictedExtraTranslation = CGSize.zero
        
        for touch in touches {
            
            
            
            if var previousDragTimesArray = previousDragTimes[touch] {
                
                previousDragTimesArray.append((touch.timestamp, touch.location(in: self.view)))
                
                var translationX = 0.0
                var translationY = 0.0
                var totalTime = 0.0
                
                for i in 1..<previousDragTimesArray.count {
                    let currentDragTime = previousDragTimesArray[i]
                    let previousDragTime = previousDragTimesArray[i - 1]
                    
                    
                    translationX += (currentDragTime.1.x - previousDragTime.1.x)
                    translationY += (currentDragTime.1.y - previousDragTime.1.y)
                    
                    totalTime += currentDragTime.0 - previousDragTime.0
                    
                }
                
                
                
                
                
                
                
                //                let translationX = touch.location(in: self.view).x - touch.previousLocation(in: self.view).x
                //                let translationY = touch.location(in: self.view).y - touch.previousLocation(in: self.view).y
                
                let velocityScale = 2.5
                
                predictedExtraTranslation.width += ((translationX / totalTime) / velocityScale) / CGFloat(touches.count)
                predictedExtraTranslation.height += ((translationY / totalTime) / velocityScale) / CGFloat(touches.count)
                
            }
        }
        
        if touchPoints.count == 0 {
            if let previousVelocityTimeInterval = previousVelocityTimeInterval {
                // If the previous touch ended less than .35 seconds ago, include it in the final velocity
                if event.timestamp - previousVelocityTimeInterval < maximumScalePreviousTouchTime {
                    self.predictedExtraTranslation.width = self.predictedExtraTranslation.width / 2 + predictedExtraTranslation.width / 2
                    self.predictedExtraTranslation.height = self.predictedExtraTranslation.height / 2 + predictedExtraTranslation.height / 2

                } else {
                    self.predictedExtraTranslation = predictedExtraTranslation
                }
                
            } else {
                self.predictedExtraTranslation = predictedExtraTranslation
            }
            
            var scaleDiff = 0.0
            var totalTime = 0.0
            
            // print("\(event.timestamp - (previousVelocityTimeInterval ?? event.timestamp))")
            
            if previousScaleTimes.count > 1 && (touches.count > 1 || event.timestamp - (previousVelocityTimeInterval ?? event.timestamp) < maximumScalePreviousTouchTime) {
                for i in 1..<previousScaleTimes.count {
                    let currentScaleTime = previousScaleTimes[i]
                    let previousScaleTime = previousScaleTimes[i - 1]
                    
                    scaleDiff += currentScaleTime.1 - previousScaleTime.1
                    
                    totalTime += currentScaleTime.0 - previousScaleTime.0
                }
                
                predictedExtraScale = scaleDiff / totalTime / 10.0 + 1
                
            }

            // Cancel pan velocity if zoom velocity is high enough
            if predictedExtraScale < 0.7 || predictedExtraScale > 1.5  {
                self.predictedExtraTranslation = .zero
            }
            
            
            // Cancel pan velocity if pan velocity is not high enough
            let magnitude = sqrt(self.predictedExtraTranslation.width * self.predictedExtraTranslation.width + self.predictedExtraTranslation.height * self.predictedExtraTranslation.height)
            if magnitude < 200 {
                self.predictedExtraTranslation = .zero
            }
            
            super.touchesEnded(touches, with: event)

            self.state = .ended
        } else {
            self.predictedExtraTranslation = predictedExtraTranslation
            self.previousVelocityTimeInterval = event.timestamp
        }
        

    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesCancelled(touches, with: event)
    }
    
    public override func reset() {
        super.reset()
        
        self.translation = .zero
        self.scale = 1.0
        self.predictedExtraScale = 1.0
        
        self.touchPoints = [:]
        self.initialTouchPoints = [:]
        
        self.initialScale = 1.0

        self.previousDragTimes = [:]
        self.previousScaleTimes = []
        
        self.previousVelocityTimeInterval = nil
        
        self.predictedExtraTranslation = .zero
    }
}
