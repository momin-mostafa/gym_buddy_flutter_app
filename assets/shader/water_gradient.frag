#include <flutter/runtime_effect.glsl>

precision mediump float;

uniform vec2 uSize;
uniform float uTime;

uniform vec3 color1;
uniform vec3 color2;
uniform vec3 color3;

out vec4 fragColor;

void main() {

    vec2 uv = FlutterFragCoord().xy / uSize;

    vec2 p = uv - 0.5;

    float t = uTime * 0.25;

    // subtle drift (reduced strength for darker feel)
    vec2 drift = vec2(
            sin(t * 0.6),
            cos(t * 0.4)
    ) * 0.10;

    vec2 q = p + drift;

    // wave field
    float wave1 = cos(q.y * 6.0 + t);
    float wave2 = cos(q.x * 6.5 - t * 1.2);
    float wave3 = sin((q.x + q.y) * 4.0 + t * 0.6);

    float noise =
            sin(q.x * 10.0 + t) *
            cos(q.y * 9.0 - t);

    float distortion =
            wave1 * 0.10 +
            wave2 * 0.08 +
            wave3 * 0.06 +
            noise * 0.04;

    // ----------------------------
    // DARKER GRADIENT CORE FIX
    // ----------------------------

    float gradient = uv.y + distortion * 1.2;

    // DO NOT center to 0.5 anymore (this caused washout)
    gradient = clamp(gradient, 0.0, 1.0);

    // contrast shaping (VERY IMPORTANT)
    gradient = pow(gradient, 1.4);

    // base mix (keeps darkness)
    vec3 col = mix(color1, color2, gradient);

    // white only on strong highlights (tight band)
    float highlight = smoothstep(0.75, 0.95, gradient);

    col = mix(col, color3, highlight);

    fragColor = vec4(col, 1.0);
}