//
//  TLShaderOperation.m
//  OpenGL多边形
//
//  Created by tongle on 2017/8/22.
//  Copyright © 2017年 tong. All rights reserved.
//

#import "TLShaderOperation.h"

@implementation TLShaderOperation

+ (GLuint)compileShader:(NSString*)shaderName withType:(GLenum)shaderType {
    // 1 查找shader文件
    NSString* shaderPath = [[NSBundle mainBundle] pathForResource:shaderName ofType:@"glsl"];
    NSError* error;
    NSString* shaderString = [NSString stringWithContentsOfFile:shaderPath encoding:NSUTF8StringEncoding error:&error];
    if (!shaderString) {
        NSLog(@"Error loading shader: %@", error.localizedDescription);
        exit(1);
    }
    
    // 2 创建一个代表shader的OpenGL对象, 指定vertex或fragment shader
    GLuint shaderHandle = glCreateShader(shaderType);
    
    // 3 获取shader的source
    const char* shaderStringUTF8 = [shaderString UTF8String];
    int shaderStringLength = (int)[shaderString length];
    glShaderSource(shaderHandle, 1, &shaderStringUTF8, &shaderStringLength);
    
    // 4 编译shader
    glCompileShader(shaderHandle);
    
    // 5 查询shader对象的信息
    GLint compileSuccess;
    glGetShaderiv(shaderHandle, GL_COMPILE_STATUS, &compileSuccess);
    if (compileSuccess == GL_FALSE) {
        GLchar messages[256];
        glGetShaderInfoLog(shaderHandle, sizeof(messages), 0, &messages[0]);
        NSString *messageString = [NSString stringWithUTF8String:messages];
        NSLog(@"%@", messageString);
        exit(1);
    }
    
    return shaderHandle;
}

+ (GLuint)compileShaders:(NSString *)shaderVertex shaderFragment:(NSString *)shaderFragment {
    // 1 vertex和fragment两个shader都要编译
    GLuint vertexShader =   [TLShaderOperation compileShader:shaderVertex withType:GL_VERTEX_SHADER];
    GLuint fragmentShader = [TLShaderOperation compileShader:shaderFragment withType:GL_FRAGMENT_SHADER];
    
    // 2 连接vertex和fragment shader成一个完整的program
    GLuint _glProgram = glCreateProgram();
    glAttachShader(_glProgram, vertexShader);
    glAttachShader(_glProgram, fragmentShader);
    
    // link program
    glLinkProgram(_glProgram);
    
    // 3 check link status
    GLint linkSuccess;
    glGetProgramiv(_glProgram, GL_LINK_STATUS, &linkSuccess);
    if (linkSuccess == GL_FALSE) {
        GLchar messages[256];
        glGetProgramInfoLog(_glProgram, sizeof(messages), 0, &messages[0]);
        NSString *messageString = [NSString stringWithUTF8String:messages];
        NSLog(@"%@", messageString);
        exit(1);
    }
    return _glProgram;
}

@end
