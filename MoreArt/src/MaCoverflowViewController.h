
#import <UIKit/UIKit.h>
#import "TapkuLibrary.h"




@interface MaCoverflowViewController : UIViewController <TKCoverflowViewDelegate,TKCoverflowViewDataSource,UIScrollViewDelegate> {
	
	TKCoverflowView *coverflow; 
	NSMutableArray *covers; // album covers images
	BOOL collapsed;
	
}

@property (retain,nonatomic) TKCoverflowView *coverflow; 
@property (retain,nonatomic) NSMutableArray *covers;

@end

