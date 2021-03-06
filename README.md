FacebookMenuButton
==================

My shot at recreating Facebook Paper's hamburger menu button. 
Keywords: iOS, objective-c, objc, Xcode, paper, facebook, menu, hamburger, button.

## Requirements
 - You'll need to have the QuartzCore library imported into your project.

## Demo
 - See the FacebookMenuButtonExample project in the repo. It has an example of
	 a button added through IB as well as one created in code.

![](./demo.gif)

## Usage
 1. Import the button into your view controller: `#import "FacebookMenuButton.h"`
 2. Create and add an instance of the button (you can also do this in IB):

		FacebookMenuButton *menuButton = [[FacebookMenuButton alloc] 
			initWithFrame:CGRectMake(0, 0, 44, 44)];
		menuButton.center = self.view.center;
		[self.view addSubview:menuButton];

 3. Add a target for the button when pressed, and set the button as selected
		when you want the animation to fire:

		[menuButton addTarget:self action:@selector(menuSelected:) 
			forControlEvents:UIControlEventTouchUpInside];

		...

		- (IBAction)menuSelected:(UIButton *)sender {
			sender.selected = !sender.selected;
		}

 4. That's it! You're done. Bonus points for customizing your button with the
		following properties:

		/** Color for the menu bars */
		@property (nonatomic, strong) UIColor *barTint;

		/* Width of the menu bars */
		@property (nonatomic, assign) NSInteger barWidth;

		/* Height or thickness of the menu bars */
		@property (nonatomic, assign) NSInteger barHeight;

		/* Space between the menu bars */
		@property (nonatomic, assign) NSInteger barSpacing;

		/* Duration of the animation when selected */
		@property (nonatomic, assign) NSTimeInterval animationDuration;


## Notes
 - If you're using this in Interface Builder (IB), you can drag a UIButton and
	 simply set its Custom Class to the Facebook Button. However, you'll also want
	 to set the type to `Custom` instead of the default `System` or you'll get an
	 annoying blue highlight when the button is selected.

### Inspiration
From Daniel Strunk's HTML5/CSS3 version of the animation: http://dstrunk.com/emulating-facebook-papers-menu-animation/

### License
MIT
