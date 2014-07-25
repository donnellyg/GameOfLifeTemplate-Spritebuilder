#import "Grid.h"
#import "Creature.h"

// these are variables that cannot be changed
static const int GRID_ROWS = 8;
static const int GRID_COLUMNS = 10;

@implementation Grid {
    NSMutableArray *_gridArray;
    float _cellWidth;
    float _cellHeight;
}

- (void)onEnter
{
    [super onEnter];
    
    [self setupGrid];
    
    // accept touches on the grid
    self.userInteractionEnabled = YES;
}

- (void)setupGrid
{
    // divide the grid's size by the number of columns/rows to figure out the right width and height of each cell
    _cellWidth = self.contentSize.width / GRID_COLUMNS;
    _cellHeight = self.contentSize.height / GRID_ROWS;
    
    float x = 0;
    float y = 0;
    
    // initialize the array as a blank NSMutableArray
    _gridArray = [NSMutableArray array];
    
    // initialize Creatures
    for (int i = 0; i < GRID_ROWS; i++) {
        // this is how you create two dimensional arrays in Objective-C. You put arrays into arrays.
        _gridArray[i] = [NSMutableArray array];
        x = 0;
        
        for (int j = 0; j < GRID_COLUMNS; j++) {
            Creature *creature = [[Creature alloc] initCreature];
            creature.anchorPoint = ccp(0, 0);
            creature.position = ccp(x, y);
            [self addChild:creature];
            
            // this is shorthand to access an array inside an array
            _gridArray[i][j] = creature;
            
            
            x+=_cellWidth;
        }
        
        y += _cellHeight;
    }
}

- (void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    
    CGPoint touchLocation = [touch locationInNode:self]; //get x,y coordinates of touch
    
    Creature *creature = [self creatureForTouchPosition:touchLocation];
    
    creature.isAlive = !creature.isAlive; //change state of living
    
    
}

- (Creature *)creatureForTouchPosition:(CGPoint)touchPosition {
    int y = touchPosition.y;
    int x = touchPosition.x;
    
    int rowTouched = y / _cellHeight;
    int colTouched = x / _cellWidth;
    
    return _gridArray[rowTouched][colTouched];
}


- (void) evolveStep {
    
    [self countNeighbors];
    [self updateCreatures];
    
    _generation++;
}


- (void) countNeighbors{
    for (int i = 0; i < GRID_ROWS; i++){
        
        for (int j = 0; j < GRID_COLUMNS; j++){
            Creature *creature = _gridArray[i][j];
            creature.livingNeighbors = 0;
            
            //iterate over surrounding creatures
            for (int x = (i - 1); x <= (i + 1); x++){
                for (int y = (j - 1); y <= (j + 1); y++){
                    if ([self isValidPositionForX:x andY:y]){
                        Creature *neighbor = _gridArray[x][y];
                        if (neighbor.isAlive) creature.livingNeighbors++;
                        NSLog(@"Neighbor Alive!");
                    }
                }
            }
            
        }
    }
    
}


- (void) updateCreatures{
    for (int i = 0; i < GRID_ROWS; i++){
        for (int j = 0; j < GRID_COLUMNS; j++){
            Creature *creature = _gridArray[i][j];
            int nn = creature.livingNeighbors;
            
            if (nn == 2 || nn == 3) {
                [creature setIsAlive:YES];
                NSLog(@"Creature Alive!");
            } else {
                [creature setIsAlive:NO];
                NSLog(@"Creature Dead");
            }
            
        }
    }
    
}




- (BOOL) isValidPositionForX:(int)x andY:(int)y{
    return (x > 0 && x < GRID_ROWS) && (y > 0 && y < GRID_COLUMNS);
}





@end