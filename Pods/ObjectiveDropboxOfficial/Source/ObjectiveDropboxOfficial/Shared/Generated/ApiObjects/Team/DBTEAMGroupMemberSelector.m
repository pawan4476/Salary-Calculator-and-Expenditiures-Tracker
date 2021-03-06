///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import "DBStoneSerializers.h"
#import "DBStoneValidators.h"
#import "DBTEAMGroupMemberSelector.h"
#import "DBTEAMGroupSelector.h"
#import "DBTEAMUserSelectorArg.h"

#pragma mark - API Object

@implementation DBTEAMGroupMemberSelector

#pragma mark - Constructors

- (instancetype)initWithGroup:(DBTEAMGroupSelector *)group user:(DBTEAMUserSelectorArg *)user {

  self = [super init];
  if (self) {
    _group = group;
    _user = user;
  }
  return self;
}

#pragma mark - Serialization methods

+ (NSDictionary *)serialize:(id)instance {
  return [DBTEAMGroupMemberSelectorSerializer serialize:instance];
}

+ (id)deserialize:(NSDictionary *)dict {
  return [DBTEAMGroupMemberSelectorSerializer deserialize:dict];
}

#pragma mark - Description method

- (NSString *)description {
  return [[DBTEAMGroupMemberSelectorSerializer serialize:self] description];
}

@end

#pragma mark - Serializer Object

@implementation DBTEAMGroupMemberSelectorSerializer

+ (NSDictionary *)serialize:(DBTEAMGroupMemberSelector *)valueObj {
  NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];

  jsonDict[@"group"] = [DBTEAMGroupSelectorSerializer serialize:valueObj.group];
  jsonDict[@"user"] = [DBTEAMUserSelectorArgSerializer serialize:valueObj.user];

  return jsonDict;
}

+ (DBTEAMGroupMemberSelector *)deserialize:(NSDictionary *)valueDict {
  DBTEAMGroupSelector *group = [DBTEAMGroupSelectorSerializer deserialize:valueDict[@"group"]];
  DBTEAMUserSelectorArg *user = [DBTEAMUserSelectorArgSerializer deserialize:valueDict[@"user"]];

  return [[DBTEAMGroupMemberSelector alloc] initWithGroup:group user:user];
}

@end
