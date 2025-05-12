#pragma header

uniform float dist;
uniform vec3 outlineColor;

const float pi = 3.14159265359;
const int outlineSteps = 16;

void main(){
	vec2 pixelSize = 1.0/openfl_TextureSize;
	vec4 baseTextureColor = flixel_texture2D(bitmap, openfl_TextureCoordv);

	if(dist <= 0.0){
		gl_FragColor = baseTextureColor;
		return;
	}

	if(baseTextureColor.a > 0.0){ baseTextureColor.rgb /= baseTextureColor.a; }
	else{ baseTextureColor = vec4(0.0); }

	vec4 outColor = baseTextureColor;

	float stepSize = (pi * 2.0)/float(outlineSteps);
	for(int i = 0; i < outlineSteps; i++){
		vec2 uvOffset = vec2(pixelSize.x * dist * cos(stepSize * float(i)), pixelSize.y * dist * sin(stepSize * float(i)));
		vec4 offsetTexture = flixel_texture2D(bitmap, openfl_TextureCoordv + uvOffset);
		offsetTexture.rgb = outlineColor;
		outColor.rgb = mix(offsetTexture.rgb, outColor.rgb, outColor.a);
		outColor.a = clamp(outColor.a + offsetTexture.a, 0.0, 1.0);
	}
			
	gl_FragColor = vec4(outColor.rgb * outColor.a, outColor.a);
}