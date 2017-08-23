attribute vec4 Position; // variable passed into

void main(void) {
    gl_Position = Position; // gl_Position is built-in pass-out variable. Must config for in vertex shader
}