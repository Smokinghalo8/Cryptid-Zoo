shader_type spatial;
render_mode unshaded, cull_disabled;

uniform vec4 edge_color : source_color = vec4(0.1, 0.8, 1.0, 1.0);
uniform float glow_strength = 10.0;

void fragment() {
    ALBEDO = edge_color.rgb;
    EMISSION = edge_color.rgb * glow_strength;
    ALPHA = edge_color.a;
}
