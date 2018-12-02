//
//  URLUtils.m
//  iOSMDMAgent


#import "URLUtils.h"
#import <UIKit/UIKit.h>

@implementation URLUtils

float const HTTP_REQUEST_TIME = 60.0f;
int HTTP_OK = 200;
int HTTP_CREATED = 201;
int OAUTH_FAIL_CODE = 401;
int HTTP_BAD_REQUEST = 400;
NSString *const ENDPOINT_FILE_NAME = @"Endpoints";
NSString *const EXTENSION = @"plist";
NSString *const TOKEN_PUBLISH_URI = @"TOKEN_PUBLISH_URI";
NSString *const ENROLLMENT_URI = @"ENROLLMENT_URI";
NSString *const OPERATION_URI = @"OPERATION_URI";
NSString *const LOCATION_PUBLISH_URI = @"LOCATION_PUBLISH_URI";
NSString *const SERVER_URL = @"SERVER_URL";
NSString *const CONTEXT_URI = @"SERVER_CONTEXT";
NSString *const API_PORT = @"API_PORT";
NSString *const ENROLMENT_PORT = @"ENROLMENT_PORT";
NSString *const TOKEN = @"token";
NSString *const GET = @"GET";
NSString *const POST = @"POST";
NSString *const PUT = @"PUT";
NSString *const ACCEPT = @"Accept";
NSString *const CONTENT_TYPE = @"Content-Type";
NSString *const APPLICATION_JSON = @"application/json";
NSString *const LATITIUDE = @"latitude";
NSString *const LONGITUDE = @"longitude";
NSString *const UNENROLLMENT_PATH = @"UNENROLLMENT_PATH";
NSString *const AUTHORIZATION_BASIC = @" Basic ";
NSString *const AUTHORIZATION_BEARER = @" Bearer ";
NSString *const AUTHORIZATION = @"Authorization";
NSString *const REFRESH_TOKEN_URI =@"REFRESH_TOKEN_URI";
NSString *const REFRESH_TOKEN_LABEL = @"refresh_token";
NSString *const GRANT_TYPE = @"grant_type";
NSString *const GRANT_TYPE_VALUE = @"refresh_token";
NSString *const FORM_ENCODED = @"application/x-www-form-urlencoded";
NSString *const OPERATION_ID_RESPOSNE = @"operationId";
NSString *const STATUS = @"status";
NSString *const ENROLLMENT_URL = @"ENROLLMENT_URL";
NSString *const EFFECTIVE_POLICY_PATH = @"EFFECTIVE_POLICY_PATH";
NSString *const TOKEN_REFRESH_URI = @"TOKEN_REFRESH_URI";
NSString *const TENANT_NAME = @"tenantDomain";
NSString *const USERNAME = @"username";
NSString *const PASSWORD = @"password";
NSString *const AGENT_BASED_ENROLLMENT = @"AGENT_BASED_ENROLLMENT";
NSString *const CA_DOWNLOAD_PATH = @"CA_DOWNLOAD_PATH";
NSString *const AUTH_PATH = @"AUTH_PATH";
NSString *const LICENSE_PATH = @"LICENSE_PATH";
NSString *const ENROLL_PATH = @"ENROLL_PATH";
NSString *const IS_ENROLLED_PATH = @"IS_ENROLLED_PATH";
NSString *const MOBICONFIG_PATH = @"MOBICONFIG_PATH";
NSString *const AUTO_ENROLLMENT = @"AUTO_ENROLLMENT";
NSString *const AUTO_ENROLLMENT_STATUS_PATH = @"AUTO_ENROLLMENT_STATUS_PATH";
NSString *const AUTO_ENROLLMENT_COMPLETED = @"AUTO_ENROLLMENT_COMPLETED";


+ (NSDictionary *)readEndpoints {
    NSString* plistPath = [[NSBundle mainBundle] pathForResource:ENDPOINT_FILE_NAME ofType:EXTENSION];
    return [NSDictionary dictionaryWithContentsOfFile:plistPath];
}

+ (NSString *)getServerURL {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:SERVER_URL];
}

+ (NSString *)getContextURL {
    return [[URLUtils readEndpoints] objectForKey:CONTEXT_URI];
}

+ (NSString *)getAPIPort {
    return [[URLUtils readEndpoints] objectForKey:API_PORT];
}

+ (NSString *)getEnrollmentURLFromPlist {
    return [[URLUtils readEndpoints] objectForKey:ENROLLMENT_URL];
}

+ (NSString *)getEnrollmentType {
    return [[URLUtils readEndpoints] objectForKey:AGENT_BASED_ENROLLMENT];
}

+ (NSString *)getServerURLFromPlist {
    return [[URLUtils readEndpoints] objectForKey:SERVER_URL];
}

+ (NSString *)getEnrolmentPort {
    return [[URLUtils readEndpoints] objectForKey:ENROLMENT_PORT];
}

+ (NSString *)getSavedEnrollmentURL {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:ENROLLMENT_URL];
}

+ (void)saveEnrollmentURL:(NSString *)enrollURL {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:enrollURL forKey:ENROLLMENT_URL];
    [userDefaults synchronize];
}

+ (void)saveServerURL:(NSString *)serverURL {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:serverURL forKey:SERVER_URL];
    [userDefaults synchronize];
}

+ (NSString *)getTokenPublishURL {
    return [NSString stringWithFormat:@"%@:%@%@%@", [URLUtils getServerURL], [URLUtils getAPIPort], [URLUtils getContextURL], [[URLUtils readEndpoints] objectForKey:TOKEN_PUBLISH_URI]];
}

+ (NSString *)getLocationPublishURL {
    return [NSString stringWithFormat:@"%@:%@%@%@", [URLUtils getServerURL], [URLUtils getAPIPort], [URLUtils getContextURL], [[URLUtils readEndpoints] objectForKey:LOCATION_PUBLISH_URI]];
}

+ (NSString *)getOperationURL {
    return [NSString stringWithFormat:@"%@:%@%@%@", [URLUtils getServerURL], [URLUtils getAPIPort], [URLUtils getContextURL], [[URLUtils readEndpoints] objectForKey:OPERATION_URI]];
}

+ (NSString *)getUnenrollURL {
    return [NSString stringWithFormat:@"%@:%@%@%@", [URLUtils getServerURL], [URLUtils getAPIPort], [URLUtils getContextURL], [[URLUtils readEndpoints] objectForKey:UNENROLLMENT_PATH]];
}

+ (NSString *)getRefreshTokenURL{
    return [NSString stringWithFormat:@"%@:%@%@", [URLUtils getServerURL], [URLUtils getAPIPort], [[URLUtils readEndpoints] objectForKey:REFRESH_TOKEN_URI]];
}

+ (NSString *)getEnrollmentURL {
    return [NSString stringWithFormat:@"%@:%@%@", [URLUtils getSavedEnrollmentURL], [URLUtils getEnrolmentPort], [[URLUtils readEndpoints] objectForKey:ENROLLMENT_URI]];
}

+ (NSString *)getCaDownloadURL {
    return [NSString stringWithFormat:@"%@:%@%@", [URLUtils getSavedEnrollmentURL], [URLUtils getEnrolmentPort], [[URLUtils readEndpoints] objectForKey:CA_DOWNLOAD_PATH]];
}

+ (NSString *)getTokenRefreshURL {
    return [NSString stringWithFormat:@"%@:%@%@", [URLUtils getSavedEnrollmentURL], [URLUtils getEnrolmentPort], [[URLUtils readEndpoints] objectForKey:TOKEN_REFRESH_URI]];
}

+ (NSString *)getEffectivePolicyURL {
    return [NSString stringWithFormat:@"%@:%@%@%@", [URLUtils getServerURL], [URLUtils getAPIPort], [URLUtils getContextURL], [[URLUtils readEndpoints] objectForKey:EFFECTIVE_POLICY_PATH]];
}

+ (NSString *)getAuthenticationURL {
    return [NSString stringWithFormat:@"%@:%@%@", [URLUtils getSavedEnrollmentURL], [URLUtils getEnrolmentPort], [[URLUtils readEndpoints] objectForKey:AUTH_PATH]];
}

+ (NSString *)getLicenseURL {
    return [NSString stringWithFormat:@"%@:%@%@", [URLUtils getSavedEnrollmentURL], [URLUtils getEnrolmentPort], [[URLUtils readEndpoints] objectForKey:LICENSE_PATH]];
}

+ (NSString *)getEnrollURL:(NSString *)tenantDomain username:(NSString *)token {
    NSArray *osVersion = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    if ([[osVersion objectAtIndex:0] intValue] >= 10) {
        return [NSString stringWithFormat:@"%@:%@%@?tenantdomain=%@&token=%@&higer=true", [URLUtils getSavedEnrollmentURL], [URLUtils getEnrolmentPort], [[URLUtils readEndpoints] objectForKey:MOBICONFIG_PATH], tenantDomain, token];
    }
    return [NSString stringWithFormat:@"%@:%@%@?tenantdomain=%@&token=%@", [URLUtils getSavedEnrollmentURL], [URLUtils getEnrolmentPort], [[URLUtils readEndpoints] objectForKey:MOBICONFIG_PATH], tenantDomain, token];
}

+ (NSString *)getIsEnrolledURL {
    return [NSString stringWithFormat:@"%@:%@%@%@", [URLUtils getSavedEnrollmentURL], [URLUtils getEnrolmentPort],[URLUtils getContextURL], [[URLUtils readEndpoints] objectForKey:IS_ENROLLED_PATH]];
}

@end
