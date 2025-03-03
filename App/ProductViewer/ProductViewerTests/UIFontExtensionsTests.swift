//
//  UIFontExtensionsTests.swift
//  ProductViewerTests
//
//  Created by Thejus G on 02/03/25.
//  Copyright © 2025 Target. All rights reserved.
//

import XCTest
import UIKit
@testable import ProductViewer

class UIFontExtensionTests: XCTestCase {
    
    func testSmallFont() {
        assertFont(UIFont.small, expectedFontName: "Helvetica", expectedSize: 12.0)
    }
    
    func testMediumFont() {
        assertFont(UIFont.medium, expectedFontName: "Helvetica", expectedSize: 14.0)
    }
    
    func testLargeBoldFont() {
        assertFont(UIFont.largeBold, expectedFontName: "Helvetica-Bold", expectedSize: 21.0)
    }
    
    func testDetailsTitleFont() {
        assertFont(UIFont.Details.title, expectedFontName: "Helvetica", expectedSize: 18.0)
    }
    
    func testDetailsEmphasisFont() {
        assertFont(UIFont.Details.emphasis, expectedFontName: "Helvetica-Bold", expectedSize: 18.0)
    }
    
    func testDetailsCopy2Font() {
        assertFont(UIFont.Details.copy2, expectedFontName: "Helvetica", expectedSize: 16.0)
    }
    
    // Helper function to check font properties
    private func assertFont(_ font: UIFont, expectedFontName: String, expectedSize: CGFloat) {
        let actualFontName = font.fontName

        if actualFontName != expectedFontName {
            XCTFail("Expected font \(expectedFontName), but got \(actualFontName). Falling back to system font.")
        }

        XCTAssertEqual(font.pointSize, expectedSize, accuracy: 0.1, "Font size mismatch")
    }
}
