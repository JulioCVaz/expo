/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "ABI46_0_0RCTScrollEvent.h"
#import <ABI46_0_0React/ABI46_0_0RCTAssert.h>

@implementation ABI46_0_0RCTScrollEvent {
  CGPoint _scrollViewContentOffset;
  UIEdgeInsets _scrollViewContentInset;
  CGSize _scrollViewContentSize;
  CGRect _scrollViewFrame;
  CGFloat _scrollViewZoomScale;
  NSDictionary *_userData;
  uint16_t _coalescingKey;
}

@synthesize viewTag = _viewTag;
@synthesize eventName = _eventName;

- (instancetype)initWithEventName:(NSString *)eventName
                         ABI46_0_0ReactTag:(NSNumber *)ABI46_0_0ReactTag
          scrollViewContentOffset:(CGPoint)scrollViewContentOffset
           scrollViewContentInset:(UIEdgeInsets)scrollViewContentInset
            scrollViewContentSize:(CGSize)scrollViewContentSize
                  scrollViewFrame:(CGRect)scrollViewFrame
              scrollViewZoomScale:(CGFloat)scrollViewZoomScale
                         userData:(NSDictionary *)userData
                    coalescingKey:(uint16_t)coalescingKey
{
  ABI46_0_0RCTAssertParam(ABI46_0_0ReactTag);

  if ((self = [super init])) {
    _eventName = [eventName copy];
    _viewTag = ABI46_0_0ReactTag;
    _scrollViewContentOffset = scrollViewContentOffset;
    _scrollViewContentInset = scrollViewContentInset;
    _scrollViewContentSize = scrollViewContentSize;
    _scrollViewFrame = scrollViewFrame;
    _scrollViewZoomScale = scrollViewZoomScale;
    _userData = userData;
    _coalescingKey = coalescingKey;
  }
  return self;
}

ABI46_0_0RCT_NOT_IMPLEMENTED(-(instancetype)init)

- (uint16_t)coalescingKey
{
  return _coalescingKey;
}

- (NSDictionary *)body
{
  NSDictionary *body = @{
    @"contentOffset" : @{@"x" : @(_scrollViewContentOffset.x), @"y" : @(_scrollViewContentOffset.y)},
    @"contentInset" : @{
      @"top" : @(_scrollViewContentInset.top),
      @"left" : @(_scrollViewContentInset.left),
      @"bottom" : @(_scrollViewContentInset.bottom),
      @"right" : @(_scrollViewContentInset.right)
    },
    @"contentSize" : @{@"width" : @(_scrollViewContentSize.width), @"height" : @(_scrollViewContentSize.height)},
    @"layoutMeasurement" : @{@"width" : @(_scrollViewFrame.size.width), @"height" : @(_scrollViewFrame.size.height)},
    @"zoomScale" : @(_scrollViewZoomScale ?: 1),
  };

  if (_userData) {
    NSMutableDictionary *mutableBody = [body mutableCopy];
    [mutableBody addEntriesFromDictionary:_userData];
    body = mutableBody;
  }

  return body;
}

- (BOOL)canCoalesce
{
  return YES;
}

- (ABI46_0_0RCTScrollEvent *)coalesceWithEvent:(ABI46_0_0RCTScrollEvent *)newEvent
{
  NSArray<NSDictionary *> *updatedChildFrames =
      [_userData[@"updatedChildFrames"] arrayByAddingObjectsFromArray:newEvent->_userData[@"updatedChildFrames"]];
  if (updatedChildFrames) {
    NSMutableDictionary *userData = [newEvent->_userData mutableCopy];
    userData[@"updatedChildFrames"] = updatedChildFrames;
    newEvent->_userData = userData;
  }

  return newEvent;
}

+ (NSString *)moduleDotMethod
{
  return @"ABI46_0_0RCTEventEmitter.receiveEvent";
}

- (NSArray *)arguments
{
  return @[ self.viewTag, ABI46_0_0RCTNormalizeInputEventName(self.eventName), [self body] ];
}

@end
