shader_type spatial;

uniform sampler2D ntexture;

void fragment() {
    // Scroll speed
    float speed = 0.2;

    vec2 uv = UV;
    uv.y += TIME * speed;

    ALBEDO = texture(ntexture, uv).rgb;
}
