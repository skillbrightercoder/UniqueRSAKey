//
//  ViewController.m
//  RSA
//
//  Created by Reejo Samuel on 2/17/14.
//  Copyright (c) 2014 Clapp Inc. All rights reserved.
//

#import "ViewController.h"
#import "RSA.h"

@interface ViewController () {
    BOOL java;
    RSA *rsa;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    java = NO;
    
    rsa = [RSA sharedInstance];
    [rsa setIdentifierForPublicKey:@"com.reejosamuel.publicKey"
                        privateKey:@"com.reejosamuel.privateKey"
                   serverPublicKey:@"com.reejosamuel.serverPublicKey"];
    
    _mobilePublicKeyField.text = [rsa getPublicKeyAsBase64];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

-(void)dismissKeyboard {
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)generateKeys:(id)sender {
    
    
    [rsa generateRSAKeyPair:^{
        
        _mobilePublicKeyField.text = [rsa getPublicKeyAsBase64];
        NSLog(@"Public Key :\n-----BEGIN RSA PUBLIC KEY-----\n%@\n-----END RSA PUBLIC KEY-----", _mobilePublicKeyField.text);
        NSLog(@"private Key :\n-----BEGIN RSA PRIVATE KEY-----\n%@\n-----END RSA PRIVATE KEY-----", [rsa getPrivateKeyAsBase64]);
    }];
}

- (IBAction)decryptMessage:(id)sender {
    
    _forMobileMessageField.text = [rsa decryptUsingPrivateKeyWithData:[[NSData alloc] initWithBase64EncodedString:_forServerMessageField.text options:0]];
}

- (IBAction)encryptMessage:(id)sender {
    
    _forServerMessageField.text = [rsa encryptUsingPublicKeyWithData:[_messageToEncrypt.text dataUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"message to encrypt :%@", _forServerMessageField.text);

}

- (IBAction)setJavaSwitch:(id)sender {
    if([sender isOn]){
        java = YES;
        NSLog(@"java on");
    } else {
        java = NO;
    }
}

- (IBAction)setServerKey:(id)sender {
    
    if (java) {
//        NSLog(@"Java publickey being set: %@", _serverPublicKeyField.text);
        [rsa setPublicKeyFromJavaServer:_serverPublicKeyField.text];
        _forServerMessageField.text = [rsa getServerPublicKey];
    } else {
        [rsa setPublicKey:_serverPublicKeyField.text];
    }
}
@end
