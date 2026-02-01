shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture;
uniform sampler2D palette_tex;
uniform vec4 outline_col : source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform int thickness_px = 1;
uniform bool eight_connected = true;

bool neigh_opaque(vec2 uv, vec2 px) {
    for (int y = -16; y <= 16; y++) {
        for (int x = -16; x <= 16; x++) {
            if (x == 0 && y == 0) { continue; }
            if (abs(x) > thickness_px || abs(y) > thickness_px) { continue; }
            if (!eight_connected && (abs(x) + abs(y) != 1)) { continue; }
            float a = texture(screen_texture, uv + vec2(float(x), float(y)) * px).a;
            if (a > 0.0) { return true; }
        }
    }
    return false;
}

void fragment() {
    vec2 uv = SCREEN_UV;
    vec2 px = SCREEN_PIXEL_SIZE;

    vec4 src = texture(screen_texture, uv);

    float idx = src.r;
    float base_a = src.a;

    vec4 pal = texture(palette_tex, vec2(idx, 0.0));
    vec4 base = vec4(pal.rgb, pal.a * base_a);

    if (base.a > 0.0) {
        COLOR = base;
    } else {
        if (neigh_opaque(uv, px)) {
            COLOR = outline_col;
        } else {
            COLOR = vec4(0.0);
        }
    }
}