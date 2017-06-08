//
//  UNTCombinedChartView.swift
//  UniTrader
//
//  Created by Pavlo Shestak on 10/3/16.
//  Copyright © 2016 unitrader. All rights reserved.
//


// YOU MAY MODIFY THIS FILE IT'S NOT A PART OF PODS! 

import UIKit

public class UNTCombinedChartView: CombinedChartView {
    
    override public var rightAxis: UNTChartYAxis { return _rightAxis as! UNTChartYAxis }
    override public var xAxis: UNTChartXAxis { return _xAxis as! UNTChartXAxis }
//    public var rightAxisRenderer: UNTChartYAxisRenderer { return _rightYAxisRenderer as! UNTChartYAxisRenderer }
    public var highlightRenderer: UNTChartHighlightRenderer!
//
//    internal var _panToHighlightGestureRecognizer: NSUIPanGestureRecognizer!
//    
    override public var data: ChartData? {
        didSet {
            self.lastHighlighted = nil
            self.highlightModeEnabled = false
            self.highlighter = UNTEmptySpaceAllowedHighlighter(chart: self, barDataProvider: self)
        }
    }
    
    public var highlightModeEnabled = false {
        didSet {
            self.dragEnabled = !self.highlightModeEnabled
            self.highlightPerTapEnabled = self.highlightModeEnabled
            
            if !self.highlightModeEnabled {
                self.highlightValue(nil, callDelegate: true)
            }
            else {
                if self.lastHighlighted == nil {
                    self.lastHighlighted = getHighlightByTouchPoint(self.center)
                }
                self.highlightValue(self.lastHighlighted, callDelegate: true)
            }
        }
    }

    public override func initialize() {
        super.initialize()
        
        _rightAxis = UNTChartYAxis(position: .right)
        _xAxis = UNTChartXAxis()
        _rightYAxisRenderer = UNTChartYAxisRenderer(viewPortHandler: _viewPortHandler, yAxis: _rightAxis, transformer: _rightAxisTransformer)
        _xAxisRenderer = UNTChartXAxisRenderer(viewPortHandler: _viewPortHandler, xAxis: _xAxis, transformer: _leftAxisTransformer)
        
        let datesProvider = UNTChartXAxisDatesProvider()
        datesProvider.chartDataProvider = self
        _xAxis.valueFormatter = datesProvider
//        
//        _panToHighlightGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(UNTCombinedChartView.panHighlightGestureRecognized(_:)))
//        _panToHighlightGestureRecognizer.delegate = self
//        self.addGestureRecognizer(_panToHighlightGestureRecognizer)
//        
        self.highlightRenderer = UNTChartHighlightRenderer(dataProvider: self, animator: _animator, viewPortHandler:_viewPortHandler)
        self.highlighter = UNTEmptySpaceAllowedHighlighter(chart: self, barDataProvider: self)
    }

    public override func notifyDataSetChanged() {
        super.notifyDataSetChanged()
        
        guard let xAxisRenderer = _xAxisRenderer as? UNTChartXAxisRenderer else { return }
        guard let data = self.data else { return }
        xAxisRenderer.axisLabelsAnchorX = data.axisLabelsAnchorX
    }
//
//    public override var highestVisibleXIndex: Int {
//        // For some reason the index might be negative when data is changed
//        return max(super.highestVisibleXIndex , 0)
//    }
//    
//    internal override func calcModulus() {
//        // Trying to avoid a regular charts crash
//        if (_viewPortHandler.touchMatrix.a != 0.0) {
//            super.calcModulus()
//        }
//    }
//    
    override public func highlightValue(_ highlight: Highlight?, callDelegate: Bool)
    {
        // Overriding the default implementtion to allow highlighting empty space, not just values
        var entry: ChartDataEntry?
        let h = highlight
        
        if (h == nil)
        {
            _indicesToHighlight.removeAll(keepingCapacity: false)
        }
        else
        {
            _indicesToHighlight = [h!]
        }
        
        if (callDelegate && delegate != nil)
        {
            if (h == nil)
            {
                delegate!.chartValueNothingSelected?(self)
            }
            else
            {
                entry = _data?.entryForHighlight(h!) ?? ChartDataEntry(x: h!.x, y: h!.y)
                // notify the listener
                delegate!.chartValueSelected?(self, entry: entry!, highlight: h!)
            }
        }
        
        setNeedsDisplay()
    }
    
    override public func valuesToHighlight() -> Bool
    {
        // Disable the standart highlighting
        return false
    }

    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let optionalContext = NSUIGraphicsGetCurrentContext()
        guard let context = optionalContext else { return }
        
        if _indicesToHighlight.count != 0 {
            self.highlightRenderer.drawHighlighted(context: context, indices: _indicesToHighlight)
        }
    }
//
//    private var pointWherePanBegan = CGPointZero
//    private var highlightWhenPanBegan: ChartHighlight?
//    
//    @objc private func panHighlightGestureRecognized(recognizer: NSUIPanGestureRecognizer) {
//        if (recognizer.state == NSUIGestureRecognizerState.Began) {
//            
//            self.pointWherePanBegan = recognizer.locationInView(self)
//            self.highlightWhenPanBegan = self.lastHighlighted
//        }
//        else if (recognizer.state == NSUIGestureRecognizerState.Changed) {
//            
//            let pointToHighlight = self.pointToHighlightForPanPosition(recognizer.locationInView(self))
//            
//            let h = getHighlightByTouchPoint(pointToHighlight)
//            
//            let lastHighlighted = self.lastHighlighted
//            
//            if ((h === nil && lastHighlighted !== nil) ||
//                (h !== nil && lastHighlighted === nil) ||
//                (h !== nil && lastHighlighted !== nil && !h!.isEqual(lastHighlighted)))
//            {
//                self.lastHighlighted = h
//                self.highlightValue(highlight: h, callDelegate: true)
//            }
//        }
//    }
//    
//    private func pointToHighlightForPanPosition(panPosition: CGPoint) -> CGPoint {
//        var lastHighlightPoint = CGPoint(x: CGFloat(self.highlightWhenPanBegan!.xIndex), y: CGFloat(self.highlightWhenPanBegan!.value))
//        self.getTransformer(.Right).pointValueToPixel(&lastHighlightPoint)
//        
//        let currentPanPoint = panPosition
//        let deltaX = currentPanPoint.x - self.pointWherePanBegan.x
//        let deltaY = currentPanPoint.y - self.pointWherePanBegan.y
//        let newX = min(max(lastHighlightPoint.x + deltaX, self.viewPortHandler.contentLeft), self.viewPortHandler.contentRight)
//        let newY = min(max(lastHighlightPoint.y + deltaY, self.viewPortHandler.contentTop), self.viewPortHandler.contentBottom)
//        let newPoint = CGPoint(x: newX, y: newY)
//        
//        return newPoint
//    }
//    
//    public override func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool
//    {
//        if gestureRecognizer == _panToHighlightGestureRecognizer {
//            return self.highlightModeEnabled
//        }
//        else {
//            return super.gestureRecognizerShouldBegin(gestureRecognizer)
//        }
//    }
//    
//    public override func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        if (gestureRecognizer == _panToHighlightGestureRecognizer) || (otherGestureRecognizer == _panToHighlightGestureRecognizer) {
//            return false
//        }
//        else {
//            return super.gestureRecognizerShouldBegin(gestureRecognizer)
//        }
//    }

}
