///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBTEAMMembersSuspendError;

#pragma mark - API Object

///
/// The `MembersSuspendError` union.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBTEAMMembersSuspendError : NSObject <DBSerializable>

#pragma mark - Instance fields

/// The `DBTEAMMembersSuspendErrorTag` enum type represents the possible tag
/// states with which the `DBTEAMMembersSuspendError` union can exist.
typedef NS_ENUM(NSInteger, DBTEAMMembersSuspendErrorTag) {
  /// No matching user found. The provided team_member_id, email, or
  /// external_id does not exist on this team.
  DBTEAMMembersSuspendErrorUserNotFound,

  /// The user is not a member of the team.
  DBTEAMMembersSuspendErrorUserNotInTeam,

  /// (no description).
  DBTEAMMembersSuspendErrorOther,

  /// The user is not active, so it cannot be suspended.
  DBTEAMMembersSuspendErrorSuspendInactiveUser,

  /// The user is the last admin of the team, so it cannot be suspended.
  DBTEAMMembersSuspendErrorSuspendLastAdmin,

  /// Team is full. The organization has no available licenses.
  DBTEAMMembersSuspendErrorTeamLicenseLimit,

};

/// Represents the union's current tag state.
@property (nonatomic, readonly) DBTEAMMembersSuspendErrorTag tag;

#pragma mark - Constructors

///
/// Initializes union class with tag state of "user_not_found".
///
/// Description of the "user_not_found" tag state: No matching user found. The
/// provided team_member_id, email, or external_id does not exist on this team.
///
/// @return An initialized instance.
///
- (nonnull instancetype)initWithUserNotFound;

///
/// Initializes union class with tag state of "user_not_in_team".
///
/// Description of the "user_not_in_team" tag state: The user is not a member of
/// the team.
///
/// @return An initialized instance.
///
- (nonnull instancetype)initWithUserNotInTeam;

///
/// Initializes union class with tag state of "other".
///
/// @return An initialized instance.
///
- (nonnull instancetype)initWithOther;

///
/// Initializes union class with tag state of "suspend_inactive_user".
///
/// Description of the "suspend_inactive_user" tag state: The user is not
/// active, so it cannot be suspended.
///
/// @return An initialized instance.
///
- (nonnull instancetype)initWithSuspendInactiveUser;

///
/// Initializes union class with tag state of "suspend_last_admin".
///
/// Description of the "suspend_last_admin" tag state: The user is the last
/// admin of the team, so it cannot be suspended.
///
/// @return An initialized instance.
///
- (nonnull instancetype)initWithSuspendLastAdmin;

///
/// Initializes union class with tag state of "team_license_limit".
///
/// Description of the "team_license_limit" tag state: Team is full. The
/// organization has no available licenses.
///
/// @return An initialized instance.
///
- (nonnull instancetype)initWithTeamLicenseLimit;

#pragma mark - Tag state methods

///
/// Retrieves whether the union's current tag state has value "user_not_found".
///
/// @return Whether the union's current tag state has value "user_not_found".
///
- (BOOL)isUserNotFound;

///
/// Retrieves whether the union's current tag state has value
/// "user_not_in_team".
///
/// @return Whether the union's current tag state has value "user_not_in_team".
///
- (BOOL)isUserNotInTeam;

///
/// Retrieves whether the union's current tag state has value "other".
///
/// @return Whether the union's current tag state has value "other".
///
- (BOOL)isOther;

///
/// Retrieves whether the union's current tag state has value
/// "suspend_inactive_user".
///
/// @return Whether the union's current tag state has value
/// "suspend_inactive_user".
///
- (BOOL)isSuspendInactiveUser;

///
/// Retrieves whether the union's current tag state has value
/// "suspend_last_admin".
///
/// @return Whether the union's current tag state has value
/// "suspend_last_admin".
///
- (BOOL)isSuspendLastAdmin;

///
/// Retrieves whether the union's current tag state has value
/// "team_license_limit".
///
/// @return Whether the union's current tag state has value
/// "team_license_limit".
///
- (BOOL)isTeamLicenseLimit;

///
/// Retrieves string value of union's current tag state.
///
/// @return A human-readable string representing the union's current tag state.
///
- (NSString * _Nonnull)tagName;

@end

#pragma mark - Serializer Object

///
/// The serialization class for the `DBTEAMMembersSuspendError` union.
///
@interface DBTEAMMembersSuspendErrorSerializer : NSObject

///
/// Serializes `DBTEAMMembersSuspendError` instances.
///
/// @param instance An instance of the `DBTEAMMembersSuspendError` API object.
///
/// @return A json-compatible dictionary representation of the
/// `DBTEAMMembersSuspendError` API object.
///
+ (NSDictionary * _Nonnull)serialize:(DBTEAMMembersSuspendError * _Nonnull)instance;

///
/// Deserializes `DBTEAMMembersSuspendError` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBTEAMMembersSuspendError` API object.
///
/// @return An instantiation of the `DBTEAMMembersSuspendError` object.
///
+ (DBTEAMMembersSuspendError * _Nonnull)deserialize:(NSDictionary * _Nonnull)dict;

@end
