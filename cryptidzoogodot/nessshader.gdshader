shader_type spatial;

uniform sampler2D main_texture : source_color;
uniform vec4 rim_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float rim_steepness : hint_range(0.0, 1.0) = 0.2; // How sharp the edge is
uniform float rim_spread : hint_range(0.0, 1.0) = 0.5;    // How far it reaches inward
uniform float rim_glow : hint_range(0.0, 10.0) = 2.0;

void fragment() {
	vec4 tex = texture(main_texture, UV);
	ALBEDO = tex.rgb;
	ALPHA = tex.a;

	// Use smoothstep for a much cleaner, more adjustable gradient
	float fresnel = 1.0 - dot(NORMAL, VIEW);
	
	// smoothstep(low_edge, high_edge, value)
	// This creates a crisp "halo" rather than a muddy gradient
	float rim = smoothstep(1.0 - rim_spread, (1.0 - rim_spread) + rim_steepness, fresnel);
	
	// Apply the rim to EMISSION for that nice bloom effect
	EMISSION = rim_color.rgb * rim * rim_glow;
}

void light() {
	// Optional: This makes the rim light react to actual scene lights
	// It prevents the "back side" of the object from glowing if there's no light there
	float light_intensity = clamp(dot(NORMAL, LIGHT), 0.0, 1.0);
	DIFFUSE_LIGHT += rim_color.rgb * light_intensity * ATTENUATION;
}