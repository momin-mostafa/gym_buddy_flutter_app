#include <flutter/runtime_effect.glsl>

precision mediump float;

uniform vec2 uSize;
uniform float uTime;

uniform vec3 insideFarColor;
uniform vec3 insideNearColor;
uniform vec3 outsideColor;

out vec4 fragColor;

// pseudo-random (same idea as Unity nrand)
float nrand(vec2 uv) {
    return fract(
        sin(dot(uv, vec2(12.9898, 78.233))) * 43758.5453
    );
}

void main() {

    vec2 uv = FlutterFragCoord().xy / uSize;

    float distY = abs(uv.y - 0.5) * 2.0;

    vec3 c;

    // -------------------------
    // OUTSIDE REGION
    // -------------------------
    if (distY > 0.7) {

        c = outsideColor;

        // random cutout noise (like Unity shader)
        float noise = nrand(uv * uSize);

        if (noise > 1.0 - pow(uv.x, 3.0)) {
            discard;
        }

    }

    // -------------------------
    // INSIDE REGION
    // -------------------------
    else {

        // X gradient blending (near → far)
        if (uv.x > 0.8) {
            c = insideFarColor;
        }
        else if (uv.x > 0.6) {

            float t = (uv.x - 0.6) * 5.0;

            c = mix(insideNearColor, insideFarColor, t);
        }
        else {
            c = insideNearColor;
        }

        // soft vertical fade into outside
        if (distY > 0.5) {

            float t = (distY - 0.5) * 5.0;

            c = mix(c, outsideColor, t);
        }

        // random cutout noise (like Unity shader)
        float noise = nrand(uv * uSize);

        if (noise > 1.0 - pow(uv.x, 2.0)) {
            discard;
        }
    }

    fragColor = vec4(c, 1.0);
}