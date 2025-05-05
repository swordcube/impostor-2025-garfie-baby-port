#pragma header

// Takes an image as the input.
uniform sampler2D bitmapOverlay;

vec4 blendOverlay(vec4 base, vec4 blend)
{
    // Depending on the base color, compute a linear interpolation
    // between black (base layer = 0), the top layer (base layer = 0.5), and white (base layer = 1.0)
    return mix(base, mix(1.0 - 2.0 * (1.0 - base) * (1.0 - blend), 2.0 * base * blend, step(base, vec4(0.5))), blend.a);
}

void main()
{
    // Get the current pixel from the base layer.
    vec4 base = flixel_texture2D(bitmap, openfl_TextureCoordv);

    // Get the current pixel from the overlay layer.
    vec4 blend = flixel_texture2D(bitmapOverlay, openfl_TextureCoordv);
    
    // Compute the overlay blend mode.
    gl_FragColor = blendOverlay(base, blend);
}