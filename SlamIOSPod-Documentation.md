#  SlamIOSPod Documentation

##  Introduction

Target/Actions, Delegates, Data Sources and even Subclassing are all traditional elements under Objected Oriented programming for iOS & Mac OS.  While they will never be replaced, there are times when such patterns are cumbersome and time-consuming. An alternative methodology is to use Closures to change or expand the functionality of elements. 

Slam is a user interface Framework for iOS/Mac that provides basic views that follow this pattern. The majority of the Classes in the Slam Framework are subclasses for classic iOS user interface elements, modified to support closures.  For example, SlamButton is a subclass of UIButton, that invokes it's property closure pressActionBlock when the button is pressed, instead of executing a target action. Similarly, the button's visible and enabled states are updated using closures that return Boolean flags to indicate their states (visibleDataSource and enableDataSource). 

## Usage

The majority of the Slam Framework consist of subclasses of common iOS user interface elements. Each new subclass has been modified to use closure to either describe the configuration of the element or use closure to provide functionality when the user interacts with the element. Developer should add the element to their Storyboard file using Interface Builder (IB), configuring them appropriately (position, constraints, Inspectable properties).  No links to IBOutlet, Target/Actions, Delegate or Data Sources need to be wired within IB. 

All Slam Views support the SlamViewProtocol which means they contain a inspectable Reference string as a way to uniquely identify the element.  All Slam classes have a variation of the findXXElemnet(with:) function, that will take a String, and returns the item with that Reference name. Using these Find functions, the element closure can be configured (usually during an View Controllers viewDidLoad() function).

## Updating UI

Slam supports two different ways to change the appearance of a view element. 

All views have the fillUI() method that fills in its appearance when the updateUI() method is invoked.  This appearance includes, but is not limited to visibility, enable/disabled, visible text of view or state of view (ex: checked).  The fillUI() function should never be invoked directly, instead the updateUI() function should be used.  Note that the updateUI() method will invoke fillUI() for the element, as well as invoke updateUI() for all its subviews.  Thus updateUI() is recursive as it walks the user interface tree.

A few view elements require a more specific method to completely update their appearance.  Usually, these views have some internal,  memory-intensive, data model. While the updateUI() function will still update their visibility and other states, a reloadUI() method reset any internal data that affects the appearance of the element.  The reloadUI() function should never be called directly. Instead, the resetUI() method should be called. Again, it will reload the view and any subviews. The best example of an element that would require this level of reset is a Table View.  updateUI() call could change the visibility of the table, but only a resetUI() method is needed if the number of items, or their text, in the table needs to change.

## Protocols

The Slam Framework defines a number of protocols to provide support for common View types/functions.  Only the SlamViewProtocol is required of all Slam elements, the rest is optional.

### SlamViewProtocol

This protocol defines two required properties and one required fucntion.  The property Reference (a string) uniquely identifies the element on the View Controller, while the visibleDataSource property has a closure that calculates when the item is hidden or not. The function fillUI() uses class specific closure properties to fill in the current appearance of the view. This function should never be called directly in the code. Instead, the updateUI() function should be used instead.

### SlamResetProtocol

This Protocol is for larger data sources View, that needs a reset ability.  Some classes require a more specific call to update its current configuration.  The SlamResetProtocol is for views that require some style of reload to update their appearance (ex: Table View).  Like fillUI(), the reloadUI() function should never be invoked directly. Instead, the resetUI() function should be used.

### SlamControlProtocol

UIControls should all support the SlamViewProtocol. This protocol has one property, the enableDataSource closure. The closure is used by updateUI() to decide to enable or disable the control.

### SlamInteractiveProtocol

Some View elements require an optional action to be associated with interacting with it. Buttons are the perfect example of this. SlamInteractiveProtocol is for Views that need this type of configurable Interaction.

The pressActionBlock property contains an optional closure to invoke when the user interacts with the element (ex: Button is pressed). Alternatively, the task & param properties contain the name of a SlamTask, and an optional parameter for the task.  Lastly, when the autoUI property is true, interacting with the element will cause an updateUI() method to be invoked for the view controller the element is on.

SlamInteractiveProtocol has an extension that provides the pressAction() function. It uses the required properties to invoke the correct action.

## Elements

###SlamView

This class is one of the few Views in the Framework designed to be subclassed.  It provides a basis for any custom subclasses that support the SlamViewProtocol protocol.  

The property Reference (a string) uniquely identifies the element on the View Controller, while the visibleDataSource property has a closure that calculates when the item is hidden or not.

The function fillUI() uses class specific closure properties to fill in the current appearance of the view. This function should never be called directly in the code. Instead, the updateUI() function should be used instead.

### SlamActivityIndicatorView

This class provides a closure version of the standard UIActivityIndicatorView.  The animatingDataSource property calculates if the Activity Indicator should be animating (spinning) or not.

### SlamButton

This class provides a closure based Button view. It supports the SlamViewProtocol, SlamControlProtocol, and SlamInteractiveProtocol (with appropriate properties and functions).

The textDataSource property contains a closure that provides the name of the button to display.

### SlamLabel

This class provides a closure based Label view. It only supports the SlamViewProtocol (with appropriate properties and functions).

The textDataSource property contains a closure that provides the name of the button to display.

### SlamPageControl

This class provides a closure based Pag Control view. It supports the SlamViewProtocol, SlamControlProtocol, and SlamInteractiveProtocol (with appropriate properties and functions).

The currentPageDataSource property contains a closure that calculates the current page (zero count), while the maxPageDataSource property has a closure for the max number of pages.  Either field can be nil, and the values are set directly.

### SlamProgressView

This class provides a closure based Progress view. It only supports the SlamViewProtocol (with appropriate properties and functions).

The progresDataSource property contains a closure that calculates the current progress (defined as a value from 0.0 to 1.0).  This fields can be nil, and the values can be set directly.

### SlamSegmentedControl

This class provides a closure based Segmented Control view. It supports the SlamViewProtocol, SlamControlProtocol, and SlamInteractiveProtocol (with appropriate properties and functions).

The currentSegmentDataSource property contains a closure that calculates the selected segment (zero-count), while the labelArrayDataSource property has a closure that returns an array of strings. These strings are used for the number of items in the segment, and their labels.

### SlamSingleItemTableView

This class provides a closure based Switch view. It supports SlamViewProtocol and SlamResetProtocol (with appropriate properties and functions). Note that as a View that supports SlamResetProtocol, a reloadUI() method must be invoked to update the data (cells) stored in the view.

SlamSingleItemTableView is one of the more complex Views of the Framework, appropriate since Table Views are complex views. This subclass of UITableView is for a single section, text only TableViews, where at most one item can be selected (the most common use of Table Views).

The class supports a number of optional ways to fill the cells in the view.  The property staticListLabels has an array of strings that will be simply used by the cell. Alternatively, the closure property selectedDataSource calculates an array of strings that will be simply used by the cell. The third option is to use the itemsForDataSource and the stringForItemDataSource closures, that will return the number of cells and the text for each cell.  Any of these options can be used, but not more than one at a time.

The variable currentSelection contains an optional int. It returns the currently selected row (nil being none), while setting it, will set the currently selected cell (nil meaning no selected cells). The Int value is zero-based. When the inspectable selectUI property is set, changing the selected row causes an update of the entire view controller. The deselectAll(animated:) function deselects any currently selected cell.  The fetchLabel(position:) function returns the text of the given cell. Lastly, the selectEventBlock closure is invoked when the selection changes.

### SlamStepper

This class provides a closure based Stepper view. It supports the SlamViewProtocol, SlamControlProtocol, and SlamInteractiveProtocol (with appropriate properties and functions).

This view has three additional closure properties: minValueDataSource, maxValueDataSource & valueDataSource. The min & max values calculate the minimum and maximum value (inclusive) allowed in the stepper, while the value closure calculates the current value. That value will be trimmed to fit within the range.

### SlamSwitch

This class provides a closure based Switch view. It supports the SlamViewProtocol, SlamControlProtocol, and SlamInteractiveProtocol (with appropriate properties and functions).

The single closure switchDataSource returns Boolean to indicate the state of the Switch, on or off.

### SlamTextField

This class provides a closure based Stepper view. It supports the SlamViewProtocol, and SlamControlProtocol (with appropriate properties and functions).

### SlamTextView

This class provides a closure based Switch view. It supports SlamViewProtocol and SlamResetProtocol (with appropriate properties and functions). Note that as a View that supports SlamResetProtocol, a reloadUI() method must be invoked to update the data (text) stored in the view.

This class has two optional closure properties. The property textDataSource calculates the current text to display in the text view.  The property textFileDataSource returns a file name, that will be loaded into the text view (if it exists).  One or the other or neither of these options can be used, but not both at once.

### SlamWebView

This class provides a closure based Switch view. It supports the SlamViewProtocol (with appropriate properties and functions).

This class has a number of new properties & closures.  The properties currentURL & currentTitle return their respective values.  The urlEventBlock event closure is invoked when the website URL has changed, while the titleEventBlock event closure is invoked when the title changes. The showSite(address:) function will try to load a webpage address, while the showFile(path:suffix:) method loads a local file.  The showFragment(html:) method load the given string as if it was HTML. FInally, clearSite() method sets the webpage to blank


## Tasks

Task structure to invoke actions.

A task is a named global action that can be invoked from almost any location within a program. Software developers can use the SlamTask class call addTask(name:action:) to register a closure with a given name. The runTask(name:param:) class call invokes the closure with the name (param contains an optional string to pass to the closure).

A common pattern is to use register a task (like pop modal view controller), which will be invoked when the user clicks on a SlamButton. All SlamButton's has an optional task name & an optional task param property.  When the user clicks on a button, the SlamButton code looks at its properties. If they are not empty, the system invokes SlamTask's runTask(name:param:) function.  Multiple buttons can use the same task, using different params (or the same).

Initially there are several pre-defined tasks, common to iOS development, that are loaded into the list.  These include:

"pop" - Dismiss Topmost modal view controller.
"push" - Load the view controller from the storyboard with the name passed in param, and display it on the top
"url" - Given the address passed in param, open the default browser (usually Safari) and go to that page.

Thus Tasks are an excellent way to divide an action from the element that invokes it.

## Future

The Slam Framework is a work in progress as additional user interface elements are added, and existing ones are extended.  The following are plan future expansions.

### SlamTextField

Addition event-style closure will be added to handle editing action.

### SlamPickerView

A closure based UIPickerView will be added, as well as a UIDatePicker.

### Additional SlamTableViews

Additional classes to support different instance of UITableView

### SlamCollectionView

Additional classes to support different instance of UICollectionView

