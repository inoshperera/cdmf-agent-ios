//
//  URLUtils.h
//  iOSMDMAgent
//


#import <Foundation/Foundation.h>

@interface URLUtils : NSObject

extern float const HTTP_REQUEST_TIME;
extern int HTTP_OK;
extern int HTTP_CREATED;
extern int HTTP_BAD_REQUEST;
extern NSString *const ENDPOINT_FILE_NAME;
extern NSString *const EXTENSION;
extern NSString *const TOKEN_PUBLISH_URI;
extern NSString *const ENROLLMENT_URI;
extern NSString *const SERVER_URL;
extern NSString *const CONTEXT_URI;
extern NSString *const TOKEN;
extern NSString *const GET;
extern NSString *const POST;
extern NSString *const PUT;
extern NSString *const ACCEPT;
extern NSString *const CONTENT_TYPE;
extern NSString *const APPLICATION_JSON;
extern NSString *const LATITIUDE;
extern NSString *const LONGITUDE;
extern NSString *const UNENROLLMENT_PATH;
extern NSString *const AUTHORIZATION_BEARER;
extern NSString *const AUTHORIZATION_BASIC;
extern NSString *const AUTHORIZATION;
extern NSString *const REFRESH_TOKEN_URI;
extern NSString *const REFRESH_TOKEN_LABEL;
extern NSString *const GRANT_TYPE;
extern NSString *const GRANT_TYPE_VALUE;
extern NSString *const FORM_ENCODED;
extern NSString *const OPERATION_URI;
extern NSString *const OPERATION_ID_RESPOSNE;
extern NSString *const STATUS;
extern int OAUTH_FAIL_CODE;
extern NSString *const ENROLLMENT_URL;
extern NSString *const EFFECTIVE_POLICY_PATH;
extern NSString *const TENANT_NAME;
extern NSString *const USERNAME;
extern NSString *const PASSWORD;
extern NSString *const AGENT_BASED_ENROLLMENT;
extern NSString *const CA_DOWNLOAD_PATH;
extern NSString *const AUTH_PATH;
extern NSString *const LICENSE_PATH;
extern NSString *const ENROLL_PATH;
extern NSString *const IS_ENROLLED_PATH;
extern NSString *const MOBICONFIG_PATH;
extern NSString *const AUTO_ENROLLMENT;
extern NSString *const AUTO_ENROLLMENT_STATUS_PATH;
extern NSString *const AUTO_ENROLLMENT_COMPLETED;

+ (void)saveServerURL:(NSString *)serverURL;
+ (NSString *)getServerURL;
+ (NSString *)getEnrollmentURL;
+ (NSString *)getContextURL;
+ (NSDictionary *)readEndpoints;
+ (NSString *)getTokenPublishURL;
+ (NSString *)getLocationPublishURL;
+ (NSString *)getUnenrollURL;
+ (NSString *)getRefreshTokenURL;
+ (NSString *)getOperationURL;
+ (void)saveEnrollmentURL:(NSString *)enrollURL;
+ (NSString *)getSavedEnrollmentURL;
+ (NSString *)getEnrollmentURLFromPlist;
+ (NSString *)getServerURLFromPlist;
+ (NSString *)getEffectivePolicyURL;
+ (NSString *)getTokenRefreshURL;
+ (NSString *)getEnrollmentType;
+ (NSString *)getCaDownloadURL;
+ (NSString *)getAuthenticationURL;
+ (NSString *)getLicenseURL;
+ (NSString *)getEnrollURL:(NSString *)tenantDomain username:(NSString *)token;
+ (NSString *)getIsEnrolledURL;

@end
