varying mediump vec2 textureCoordinate;
precision mediump float;

uniform sampler2D videoFrame;
uniform vec4 inputColor;
uniform float brightness;

void main()
{
	vec4 pixelColor = texture2D(videoFrame, textureCoordinate);
    
    pixelColor.r = 0.0;

	gl_FragColor = pixelColor;
}