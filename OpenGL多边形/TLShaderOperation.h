//
//  TLShaderOperation.h
//  OpenGL多边形
//
//  Created by tongle on 2017/8/22.
//  Copyright © 2017年 tong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

@interface TLShaderOperation : NSObject
+ (GLuint)compileShader:(NSString*)shaderName withType:(GLenum)shaderType;

+ (GLuint)compileShaders:(NSString *)shaderVertex shaderFragment:(NSString *)shaderFragment;



@end
