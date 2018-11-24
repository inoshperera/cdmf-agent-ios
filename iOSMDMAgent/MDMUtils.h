//
//  MDMUtils.h
//  iOSMDMAgent
//

#import <Foundation/Foundation.h>

@interface MDMUtils : NSObject

extern int LOCATION_DISTANCE_FILTER;
extern NSString *const UDID;
extern NSString *const APS;
extern NSString *const EXTRA;
extern NSString *const OPERATION;
extern NSString *const SOUND_FILE_NAME;
extern NSString *const SOUND_FILE_EXTENSION;
extern NSString *const ENCLOSING_TAGS;
extern NSString *const TOKEN_KEYCHAIN;
extern NSString *const CLIENT_DETAILS_KEYCHAIN;
extern NSString *const ENROLL_STATUS;
extern NSString *const ENROLLED;
extern NSString *const UNENROLLED;
extern NSString *const OPERATION_ID;
extern NSString *const LOCATION_OPERATION_ID;
extern NSString *const ACCESS_TOKEN;
extern NSString *const REFRESH_TOKEN;
extern NSString *const CLIENT_CREDENTIALS;
extern NSString *const CHALLANGE_TOKEN;
extern NSString *const LICENSE_TEXT;

extern NSString *const TENANT_DOMAIN;
extern NSString *const LOCATION_UPDATED_TIME;


+ (void)saveDeviceUDID:(NSString *)udid;
+ (NSString *)getDeviceUDID;
+ (NSString *) getEnrollStatus;
+ (void) setEnrollStatus: (NSString *)value;
+ (NSString *) getLocationOperationId;
+ (void) setLocationOperationId: (NSString *)value;
+ (void)savePreferance:(NSString *)key value:(NSString *)val;
+ (NSString *)getPreferance:(NSString *)key;
+ (void)setAccessToken:(NSString *)accessToken;
+ (void)setRefreshToken:(NSString *)refreshToken;
+ (NSString *)getAccessToken;
+ (NSString *)getRefreshToken;
+ (void)setClientCredentials:(NSString *)clientCredentials;
+ (NSString *)getClientCredentials;
+ (void)setTenantDomain:(NSString *)tenantDomain;
+ (NSString *)getTenantDomain;
+ (void)setLocationUpdatedTime;
+ (NSString *)getLocationUpdatedTime;

@end
