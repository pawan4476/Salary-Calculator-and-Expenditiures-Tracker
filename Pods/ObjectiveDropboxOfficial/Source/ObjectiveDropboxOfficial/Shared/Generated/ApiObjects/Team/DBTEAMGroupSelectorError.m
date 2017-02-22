///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import "DBStoneSerializers.h"
#import "DBStoneValidators.h"
#import "DBTEAMGroupSelectorError.h"

#pragma mark - API Object

@implementation DBTEAMGroupSelectorError

#pragma mark - Constructors

- (instancetype)initWithGroupNotFound {
  self = [super init];
  if (self) {
    _tag = DBTEAMGroupSelectorErrorGroupNotFound;
  }
  return self;
}

- (instancetype)initWithOther {
  self = [super init];
  if (self) {
    _tag = DBTEAMGroupSelectorErrorOther;
  }
  return self;
}

#pragma mark - Instance field accessors

#pragma mark - Tag state methods

- (BOOL)isGroupNotFound {
  return _tag == DBTEAMGroupSelectorErrorGroupNotFound;
}

- (BOOL)isOther {
  return _tag == DBTEAMGroupSelectorErrorOther;
}

- (NSString *)tagName {
  switch (_tag) {
  case DBTEAMGroupSelectorErrorGroupNotFound:
    return @"DBTEAMGroupSelectorErrorGroupNotFound";
  case DBTEAMGroupSelectorErrorOther:
    return @"DBTEAMGroupSelectorErrorOther";
  }

  @throw([NSException exceptionWithName:@"InvalidTag" reason:@"Tag has an unknown value." userInfo:nil]);
}

#pragma mark - Serialization methods

+ (NSDictionary *)serialize:(id)instance {
  return [DBTEAMGroupSelectorErrorSerializer serialize:instance];
}

+ (id)deserialize:(NSDictionary *)dict {
  return [DBTEAMGroupSelectorErrorSerializer deserialize:dict];
}

#pragma mark - Description method

- (NSString *)description {
  return [[DBTEAMGroupSelectorErrorSerializer serialize:self] description];
}

@end

#pragma mark - Serializer Object

@implementation DBTEAMGroupSelectorErrorSerializer

+ (NSDictionary *)serialize:(DBTEAMGroupSelectorError *)valueObj {
  NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];

  if ([valueObj isGroupNotFound]) {
    jsonDict[@".tag"] = @"group_not_found";
  } else if ([valueObj isOther]) {
    jsonDict[@".tag"] = @"other";
  } else {
    @throw([NSException exceptionWithName:@"InvalidTag"
                                   reason:@"Object not properly initialized. Tag has an unknown value."
                                 userInfo:nil]);
  }

  return jsonDict;
}

+ (DBTEAMGroupSelectorError *)deserialize:(NSDictionary *)valueDict {
  NSString *tag = valueDict[@".tag"];

  if ([tag isEqualToString:@"group_not_found"]) {
    return [[DBTEAMGroupSelectorError alloc] initWithGroupNotFound];
  } else if ([tag isEqualToString:@"other"]) {
    return [[DBTEAMGroupSelectorError alloc] initWithOther];
  }

  @throw([NSException
      exceptionWithName:@"InvalidTag"
                 reason:[NSString stringWithFormat:@"Tag has an invalid value: \"%@\".", valueDict[@".tag"]]
               userInfo:nil]);
}

@end
