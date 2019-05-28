//
//  PDFDocument+Objects.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//

/**
 This extension contains all functions to modify the objects of a document
 */
public extension PDFDocument {

    // MARK: - PUBLIC FUNCS

    // MARK: - Layout

    /**
     Adds a empty space in the given container, between the previous and the next element

     - parameter container: Container where the space will be set, defaults to `PDFContainer.contentLeft`
     - parameter space: Space distance in points
     */
    func addSpace(_ container: PDFContainer = PDFContainer.contentLeft, space: CGFloat) {
        objects += [(container, PDFSpaceObject(space: space))]
    }

    // MARK: - Lines

    /**
     Adds a horizontal line spearator to the given container. The line starts at the left indentation and ends at the right indentation.
     Customize by adjusting parameter `style`.

     - parameter container: Container where the space will be set, defaults to `PDFContainer.contentLeft`
     - parameter style: Style of line
     */
    func addLineSeparator(_ container: PDFContainer = PDFContainer.contentLeft, style: PDFLineStyle) {
        objects += [(container, PDFLineSeparatorObject(style: style))]
    }

    // MARK: - Image

    /**
     Adds an image to the given container.

     - parameter container: Container where the space will be set, defaults to `PDFContainer.contentLeft`
     - parameter image: Image object
     */
    func addImage(_ container: PDFContainer = PDFContainer.contentLeft, image: PDFImage) {
        objects += [(container, PDFImageObject(image: image))]
    }

    /**
     Adds an image row to the given container.
     This image row will fill the full available width between left indentation and right indentation.

     - parameter container: Container where the space will be set, defaults to `PDFContainer.contentLeft`
     - parameter images: Array of images, from left to right
     - parameter spacing: Horizontal distance between images
     */
    func addImagesInRow(_ container: PDFContainer = PDFContainer.contentLeft, images: [PDFImage], spacing: CGFloat = 5.0) {
        objects += [(container, PDFImageRowObject(images: images, spacing: spacing))]
    }

    // MARK: - Text

    /**
     Shorthand function to add a String text to the given container

     - parameter container: Container where the space will be set, defaults to `PDFContainer.contentLeft`
     - parameter images: Array of images, from left to right
     - parameter spacing: Horizontal distance between images
     */
    func addText(_ container: PDFContainer = PDFContainer.contentLeft, text: String, lineSpacing: CGFloat = 1.0) {
        addText(container, textObject: PDFSimpleText(text: text, spacing: lineSpacing))
    }

    /**
     Adds an text object to the given container

     - parameter container: Container where the space will be set, defaults to `PDFContainer.contentLeft`
     - parameter textObject: Simple text object
     */
    func addText(_ container: PDFContainer = PDFContainer.contentLeft, textObject: PDFSimpleText) {
        objects += [(container, PDFAttributedTextObject(simpleText: textObject))]
    }

    /**
     Shorthand function to add a attributed String text to the given container

     - parameter container: Container where the space will be set, defaults to `PDFContainer.contentLeft`
     - parameter text: An attributed string
     */
    func addAttributedText(_ container: PDFContainer = PDFContainer.contentLeft, text: NSAttributedString) {
        addAttributedText(container, textObject: PDFAttributedText(text: text))
    }

    /**
     Adds an attributed text object to the given container

     - parameter container: Container where the space will be set, defaults to `PDFContainer.contentLeft`
     - parameter textObject: Attributed text object
     */
    func addAttributedText(_ container: PDFContainer = PDFContainer.contentLeft, textObject: PDFAttributedText) {
        objects += [(container, PDFAttributedTextObject(attributedText: textObject))]
    }

    /**
     Set font in given container. This text color will be used when adding a `PDFSimpleText`

     - parameter container: Container where the font will be set, defaults to `PDFContainer.contentLeft`
     - parameter font: Font of text
     */
    func setFont(_ container: PDFContainer = PDFContainer.contentLeft, font: UIFont) {
        objects += [(container, PDFFontObject(font: font))]
    }

    /**
     Reset text color in given container to default.

     - parameter container: Container whose text color will be reset, defaults to `PDFContainer.contentLeft`
     */
    func resetFont(_ container: PDFContainer = PDFContainer.contentLeft) {
        objects += [(container, PDFFontObject(font: UIFont.systemFont(ofSize: UIFont.systemFontSize)))]
    }

    /**
     Set text color in given container. This text color will be used when adding a `PDFSimpleText`

     - parameter container: Container where the text color will be set, defaults to `PDFContainer.contentLeft`
     - parameter color: Color of the text
     */
    func setTextColor(_ container: PDFContainer = PDFContainer.contentLeft, color: UIColor) {
        objects += [(container, PDFTextColorObject(color: color))]
    }

    /**
     Reset text color in given container to default.

     - parameter container: Container whose text color will be reset, defaults to `PDFContainer.contentLeft`
     */
    func resetTextColor(_ container: PDFContainer = PDFContainer.contentLeft) {
        objects += [(container, PDFTextColorObject(color: UIColor.black))]
    }

    // MARK: - Table

    /**
     Adds a table object to the document in the defined container
     */
    func addTable(_ container: PDFContainer = PDFContainer.contentLeft, table: PDFTable) {
        objects += [(container, PDFTableObject(table: table))]
    }

    // MARK: - List

    /**
     Adds a list object to the document in the defined container
     */
    func addList(_ container: PDFContainer = PDFContainer.contentLeft, list: PDFList) {
        objects += [(container, PDFListObject(list: list))]
    }

	// MARK: - Section

	/**
	Adds a section object to the document
	*/
    func addSection(_ section: PDFSection) {
		objects += [(.contentLeft, PDFSectionObject(section: section))]
	}

    // MARK: - Layout

    /**
     Change the indentation in a container, use the parameter `left` to define from which side.

     - parameter container: Container whose indentation should be changed, defaults to `PDFContainer.contentLeft`
     - parameter indent: Points from the side
     - parameter left: If `true` then the left side indentation is set, else the right indentation is set
     */
    func setIndentation(_ container: PDFContainer = PDFContainer.contentLeft, indent: CGFloat, left: Bool) {
        objects += [(container, PDFIndentationObject(indentation: indent, left: left))]
    }

    /**
     Change the absolute top offset in a container

     - parameter container: Container whose current absoilute offset should be changed, defaults to `PDFContainer.contentLeft`
     - parameter offset: Points from the top
     */
    func setAbsoluteOffset(_ container: PDFContainer = PDFContainer.contentLeft, offset: CGFloat) {
        objects += [(container, PDFOffsetObject(offset: offset))]
    }

    /**
     Creates a new page
     */
    func createNewPage() {
        objects += [(.contentLeft, PDFPageBreakObject())]
    }

    // MARK: - Column Wrapping

    /**
     Starts a column section with automatic wrapping
     */
    func enable(_ container: PDFContainer = PDFContainer.contentLeft, columns: Int) {
        assert(columns > 1, "A column wrap section must have more than one column")
        objects += [(container, PDFColumnWrapSectionObject(columns: columns, isDisable: false))]
    }

    /**
     Finishes a column section
     */
    func disableColumns(_ container: PDFContainer = PDFContainer.contentLeft) {
        objects += [(container, PDFColumnWrapSectionObject(columns: 0, isDisable: true))]
    }
}
