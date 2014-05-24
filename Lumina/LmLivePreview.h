//
//  LmLivePreview.h
//  Lumina
//
//  Created by SSC on 2014/05/23.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LmGLView.h"

// Attribute index.
enum {
    ATTRIB_VERTEX,
    ATTRIB_TEXTUREPOSITON,
    NUM_ATTRIBUTES
};

@interface LmLivePreview : NSObject
{
    GLint brightnessUniform;
	GLuint videoFrameTexture;
	GLuint brightnessProgram;
    
    LmGLView* glView;
}

@property (nonatomic, strong) LmGLView* glView;

+ (LmLivePreview*)instance;

- (void)loadViewWithFrame:(CGRect)frame;
- (void)processNewCameraFrame:(CVImageBufferRef)cameraFrame;
- (BOOL)loadVertexShader:(NSString *)vertexShaderName fragmentShader:(NSString *)fragmentShaderName forProgram:(GLuint *)programPointer;
- (BOOL)compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file;
- (BOOL)linkProgram:(GLuint)prog;
- (BOOL)validateProgram:(GLuint)prog;

@end
