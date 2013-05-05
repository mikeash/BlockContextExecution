
#import <Foundation/Foundation.h>


typedef void (^BXXContext)(dispatch_block_t block);


@interface BXXBlockWrapper : NSObject

- (id)initWithContext: (BXXContext)context block: (id)block;

@end


@interface NSObject (BXXBlockExecution)

- (void)bxx_runBlock: (void (^)(id tocall))runner;

@end

BXXContext BXXGCDQueueContext(dispatch_queue_t queue);


struct BXXCannotCallWrappedTypesDirectly {};


#define BXX_WRAPTYPE(type) __typeof__(^(struct BXXCannotCallWrappedTypesDirectly mustUseUNWRAPTYPE){ return (type)nil; })
#define BXX_UNWRAPTYPE(type) __typeof__(((type)nil)((struct BXXCannotCallWrappedTypesDirectly){}))


#define BXX_WRAP(context, ...) (BXX_WRAPTYPE(__typeof__(__VA_ARGS__)))[[BXXBlockWrapper alloc] initWithContext: (context) block: (__VA_ARGS__)]

#define BXX_CALL(blockobj, callercode) [(blockobj) bxx_runBlock: ^(BXX_UNWRAPTYPE(__typeof__(blockobj)) block) { callercode; }]



