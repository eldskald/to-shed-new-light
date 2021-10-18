shader_type spatial;

uniform vec4 color : hint_color = vec4(1.0);
uniform float brightness = 1.0;
uniform float grow = -0.00;

void vertex() {
	VERTEX += NORMAL * grow;
}

void fragment() {
	ALBEDO = vec3(0.0);
	EMISSION = color.rgb * brightness;
	ALPHA = smoothstep(0.05, 0.2, 0.5 - abs(UV.x - 0.5));
}