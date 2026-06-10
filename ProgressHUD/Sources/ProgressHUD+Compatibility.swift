//
// Copyright (c) 2023 Related Code - https://relatedcode.com
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit

// MARK: - Semantic Colors
extension UIColor {

	// UIColor.label (iOS 13+) - falls back to black.
	static var compatLabel: UIColor {
		if #available(iOS 13.0, *) {
			return .label
		}
		return .black
	}

	// UIColor.secondaryLabel (iOS 13+) - falls back to 60% black (approximates the light-mode value).
	static var compatSecondaryLabel: UIColor {
		if #available(iOS 13.0, *) {
			return .secondaryLabel
		}
		return UIColor(white: 0.0, alpha: 0.6)
	}

	// UIColor.systemBackground (iOS 13+) - falls back to white.
	static var compatSystemBackground: UIColor {
		if #available(iOS 13.0, *) {
			return .systemBackground
		}
		return .white
	}
}

// MARK: - Activity Indicator Style
extension UIActivityIndicatorView.Style {

	// .large (iOS 13+) - falls back to .whiteLarge.
	static var compatLarge: UIActivityIndicatorView.Style {
		if #available(iOS 13.0, *) {
			return .large
		}
		return .whiteLarge
	}
}

// MARK: - Images
extension UIImage {

	// UIImage(systemName:) (iOS 13+) - returns nil on iOS 12 (SF Symbols are unavailable there).
	static func compatSymbol(_ name: String) -> UIImage? {
		if #available(iOS 13.0, *) {
			return UIImage(systemName: name)
		}
		return nil
	}

	// UIImage.checkmark (iOS 13+) - falls back to a drawn checkmark.
	static var compatCheckmark: UIImage {
		if #available(iOS 13.0, *) {
			return .checkmark
		}
		return drawnCheckmark()
	}

	// UIImage.remove (iOS 13+) - falls back to a drawn cross.
	static var compatRemove: UIImage {
		if #available(iOS 13.0, *) {
			return .remove
		}
		return drawnCross()
	}

	// withTintColor(_:renderingMode: .alwaysOriginal) (iOS 13+) - falls back to manual source-in tinting.
	func compatTinted(_ color: UIColor) -> UIImage {
		if #available(iOS 13.0, *) {
			return withTintColor(color, renderingMode: .alwaysOriginal)
		}
		let bounds = CGRect(origin: .zero, size: size)
		let renderer = UIGraphicsImageRenderer(size: size)
		let tinted = renderer.image { context in
			draw(in: bounds)
			context.cgContext.setBlendMode(.sourceIn)
			color.setFill()
			context.cgContext.fill(bounds)
		}
		return tinted.withRenderingMode(.alwaysOriginal)
	}

	private static func drawnCheckmark() -> UIImage {
		let size = CGSize(width: 26, height: 26)
		let renderer = UIGraphicsImageRenderer(size: size)
		return renderer.image { _ in
			let path = UIBezierPath()
			path.move(to: CGPoint(x: 5, y: 14))
			path.addLine(to: CGPoint(x: 11, y: 20))
			path.addLine(to: CGPoint(x: 21, y: 6))
			path.lineWidth = 2.5
			path.lineCapStyle = .round
			path.lineJoinStyle = .round
			UIColor.black.setStroke()
			path.stroke()
		}
	}

	private static func drawnCross() -> UIImage {
		let size = CGSize(width: 26, height: 26)
		let renderer = UIGraphicsImageRenderer(size: size)
		return renderer.image { _ in
			let path = UIBezierPath()
			path.move(to: CGPoint(x: 6, y: 6))
			path.addLine(to: CGPoint(x: 20, y: 20))
			path.move(to: CGPoint(x: 20, y: 6))
			path.addLine(to: CGPoint(x: 6, y: 20))
			path.lineWidth = 2.5
			path.lineCapStyle = .round
			UIColor.black.setStroke()
			path.stroke()
		}
	}
}
