//
//  UIColorExtensionsTests.swift
//  ProductViewerTests
//
//  Created by Thejus G on 02/03/25.
//  Copyright © 2025 Target. All rights reserved.
//

import XCTest
import UIKit
@testable import ProductViewer

class UIColorExtensionsTests: XCTestCase {
    
    func testUIColorHexInitialization() {
        let color = UIColor(hex: 0xFF5733) // Hex: #FF5733
        assertColorComponents(color, expectedRed: 1.0, expectedGreen: 87.0 / 255, expectedBlue: 51.0 / 255, expectedAlpha: 1.0)
    }
    
    func testCustomColors() {
        assertColorComponents(UIColor.grayDarkest, expectedHex: 0x333333)
        assertColorComponents(UIColor.grayMedium, expectedHex: 0x888888)
        assertColorComponents(UIColor.targetRed, expectedHex: 0xCC0000)
        assertColorComponents(UIColor.targetTextGreen, expectedHex: 0x008300)
        assertColorComponents(UIColor.textLightGray, expectedHex: 0x666666)
        assertColorComponents(UIColor.thinBorderGray, expectedHex: 0xD6D6D6)
        assertColorComponents(UIColor.background, expectedHex: 0xF7F7F7)
        assertColorComponents(UIColor.darkRed, expectedHex: 0xAA0000)
    }

    // Helper function to assert color components
    private func assertColorComponents(_ color: UIColor, expectedRed: CGFloat, expectedGreen: CGFloat, expectedBlue: CGFloat, expectedAlpha: CGFloat) {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        XCTAssertTrue(color.getRed(&r, green: &g, blue: &b, alpha: &a))
        XCTAssertEqual(r, expectedRed, accuracy: 0.01)
        XCTAssertEqual(g, expectedGreen, accuracy: 0.01)
        XCTAssertEqual(b, expectedBlue, accuracy: 0.01)
        XCTAssertEqual(a, expectedAlpha, accuracy: 0.01)
    }

    // Helper function to test UIColor from hex
    private func assertColorComponents(_ color: UIColor, expectedHex: Int) {
        let expectedRed = CGFloat((expectedHex >> 16) & 0xff) / 255
        let expectedGreen = CGFloat((expectedHex >> 08) & 0xff) / 255
        let expectedBlue = CGFloat((expectedHex >> 00) & 0xff) / 255
        assertColorComponents(color, expectedRed: expectedRed, expectedGreen: expectedGreen, expectedBlue: expectedBlue, expectedAlpha: 1.0)
    }
}
