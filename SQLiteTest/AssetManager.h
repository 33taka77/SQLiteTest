//
//  AssetManager.h
//  Photos
//
//  Created by Aizawa Takashi on 2014/03/10.
//  Copyright (c) 2014年 相澤 隆志. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@protocol AssetLibraryDelegate

- (void)updateGroupDataGroupURL:(NSURL*)groupUrl;
- (void)updateItemDataItemURL:(NSURL*)url groupURL:(NSURL*)groupUrl;

@end


@interface AssetManager : NSObject

@property id < AssetLibraryDelegate > delegate;

+ (AssetManager*)sharedAssetManager;

- (void)setAssetManagerModeIsHoldItemData:(BOOL)isHold;
- (UIImage*)getThumbnail:(NSURL*)url;
- (ALAsset*)getAssetByURL:(NSURL*)url;
- (void)enumeAssetItems;
- (UIImage*)getFullImage:(NSURL*)url;
- (UIImage*)getFullScreenImage:(NSURL*)url;
- (NSArray*)getGroupNames;
- (NSString*)getGroupNameByURL:(NSURL*)url;
- (NSInteger)getCountOfImagesInGroup:(NSString*)name;
- (NSInteger)getCountOfImagesInGroupByURL:(NSURL*)url;
- (NSDate*)getCaptureDateByURL:(NSURL*)url;
- (UIImage*)getThumbnailAspect:(NSURL *)url;
- (NSDictionary*)getMetaDataByURL:(NSURL*)url;

@end
