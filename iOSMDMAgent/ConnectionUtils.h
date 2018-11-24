//
//  ConnectionUtils.h
//  iOSMDMAgent


#import <Foundation/Foundation.h>
#import "SDKProtocol.h"

@interface ConnectionUtils : NSObject

@property(nonatomic, assign) id<SDKProtocol> delegate;

- (void)sendPushTokenToServer:(NSString *)udid pushToken:(NSString *)token;
- (void)sendLocationToServer:(NSString *)udid latitiude:(float)lat longitude:(float)longi;
- (void)sendUnenrollToServer;
- (void)sendOperationUpdateToServer:(NSString *)deviceId operationId:(NSString *)opId status:(NSString *)state;
- (void)enforceEffectivePolicy:(NSString *)deviceId;
- (void)authenticate:(NSString *)tenantDomain username:(NSString *)username password:(NSString *)password completion:(void (^)(BOOL success))completionBlock;
- (void)getLicense:(void (^)(BOOL success))completionBlock;
- (void)isEnrolled:(void (^)(BOOL success))completionBlock;

@end
