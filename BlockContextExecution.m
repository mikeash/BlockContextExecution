
#import "BlockContextExecution.h"


@implementation BXXBlockWrapper {
    int _dummy1;
    int _dummy2;
    void (*_invoke)(void);
    BXXContext _context;
    id _innerBlock;
}

static void DummyInvoke(void) {
    NSLog(@"You cannot call this block directly!");
    abort();
}

- (id)initWithContext: (BXXContext)context block: (id)block {
    if((self = [super init])) {
        _invoke = DummyInvoke;
        _context = context;
        _innerBlock = block;
    }
    return self;
}

- (void)bxx_runBlock: (void (^)(id tocall))runner {
    _context(^{
        runner(_innerBlock);
    });
}


@end

@implementation NSObject (ContextCarringBlockInvocation)

- (void)bxx_runBlock: (void (^)(id tocall))runner {
    runner(self);
}

@end

BXXContext BXXGCDQueueContext(dispatch_queue_t queue) {
    return ^(dispatch_block_t block) {
        dispatch_async(queue, block);
    };
}
