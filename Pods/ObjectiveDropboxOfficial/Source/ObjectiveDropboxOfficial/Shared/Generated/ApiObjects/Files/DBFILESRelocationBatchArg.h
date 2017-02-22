///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBFILESRelocationBatchArg;
@class DBFILESRelocationPath;

#pragma mark - API Object

///
/// The `RelocationBatchArg` struct.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBFILESRelocationBatchArg : NSObject <DBSerializable>

#pragma mark - Instance fields

/// List of entries to be moved or copied. Each entry is RelocationPath.
@property (nonatomic, readonly) NSArray<DBFILESRelocationPath *> * _Nonnull entries;

/// If true, `dCopyBatch` will copy contents in shared folder, otherwise
/// `cantCopySharedFolder` in `DBFILESRelocationError` will be returned if
/// `fromPath` in `DBFILESRelocationPath` contains shared folder.  This field is
/// always true for `moveBatch`.
@property (nonatomic, readonly) NSNumber * _Nonnull allowSharedFolder;

/// If there's a conflict with any file, have the Dropbox server try to
/// autorename that file to avoid the conflict.
@property (nonatomic, readonly) NSNumber * _Nonnull autorename;

#pragma mark - Constructors

///
/// Full constructor for the struct (exposes all instance variables).
///
/// @param entries List of entries to be moved or copied. Each entry is
/// RelocationPath.
/// @param allowSharedFolder If true, `dCopyBatch` will copy contents in shared
/// folder, otherwise `cantCopySharedFolder` in `DBFILESRelocationError` will be
/// returned if `fromPath` in `DBFILESRelocationPath` contains shared folder.
/// This field is always true for `moveBatch`.
/// @param autorename If there's a conflict with any file, have the Dropbox
/// server try to autorename that file to avoid the conflict.
///
/// @return An initialized instance.
///
- (nonnull instancetype)initWithEntries:(NSArray<DBFILESRelocationPath *> * _Nonnull)entries
                      allowSharedFolder:(NSNumber * _Nullable)allowSharedFolder
                             autorename:(NSNumber * _Nullable)autorename;

///
/// Convenience constructor (exposes only non-nullable instance variables with
/// no default value).
///
/// @param entries List of entries to be moved or copied. Each entry is
/// RelocationPath.
///
/// @return An initialized instance.
///
- (nonnull instancetype)initWithEntries:(NSArray<DBFILESRelocationPath *> * _Nonnull)entries;

@end

#pragma mark - Serializer Object

///
/// The serialization class for the `RelocationBatchArg` struct.
///
@interface DBFILESRelocationBatchArgSerializer : NSObject

///
/// Serializes `DBFILESRelocationBatchArg` instances.
///
/// @param instance An instance of the `DBFILESRelocationBatchArg` API object.
///
/// @return A json-compatible dictionary representation of the
/// `DBFILESRelocationBatchArg` API object.
///
+ (NSDictionary * _Nonnull)serialize:(DBFILESRelocationBatchArg * _Nonnull)instance;

///
/// Deserializes `DBFILESRelocationBatchArg` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBFILESRelocationBatchArg` API object.
///
/// @return An instantiation of the `DBFILESRelocationBatchArg` object.
///
+ (DBFILESRelocationBatchArg * _Nonnull)deserialize:(NSDictionary * _Nonnull)dict;

@end
