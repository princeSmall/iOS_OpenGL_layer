// variable pass into
attribute vec4 Position;    // position of vertex
attribute vec4 SourceColor; // color of vertex


// variable pass out into fragment shader
// varying means that calculate the color of every pixel between two vertex linearly(smoothly) according to the 2 vertex's color
// gl_Position is built-in pass-out variable. Must config for in vertex shader

varying vec4 DestinationColor;

void main(void) {

       DestinationColor = SourceColor;
       gl_Position = Position;
}
