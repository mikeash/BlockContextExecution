// clang -framework Foundation -fobjc-arc BlockContextExecution.m main.m

#import "BlockContextExecution.h"

int main(int argc, char **argv) {
    @autoreleasepool {
        BXXContext context = ^(dispatch_block_t block) {
            NSLog(@"Context was invoked");
            block();
        };
        
        BXX_WRAPTYPE(void (^)(int)) block = BXX_WRAP(context, ^(int x) {
            NSLog(@"Got %d", x);
        });
        
        BXX_CALL(block, block(42));
        // does not compile
        //block(42);
    }
}
