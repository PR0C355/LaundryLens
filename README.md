# LaundryLens

LaundryLens is a simple Swift application for determining the meaning of the various icons found on the laundry labels of various clothing items. This is achieved through the Swift CoreML and Vision libraries, combined with a specially trained YOLOv11 model.

The model is built upon the existing YOLOv11 detection model, trained with [this labeled dataset on Roboflow](https://universe.roboflow.com/test-ah8ju/washinglablerecognition-0yaja).

Using it is as simple as taking a new photo or selecting an existing one. The app will then create a popup with the meaning of the identified labels. This popup can be dismissed to return to the main page, where the user can see the bounding boxes for each of these items, and either run the model again, or select a new image.

With just a snapshot, users can quickly access detailed washing instructions, making laundry a breeze. Perfect for busy individuals seeking an effortless laundry experience.

## To build the app on your iOS devices
* Download this repository
* Open LaundryLens.xcodeproj with Xcode by double clicking on it
* Connect your iPhone or iPad
* Click the Build ▶️ or press Command R
* Allow camera or photo album access if it's the first time you tap the 📸 button on the top