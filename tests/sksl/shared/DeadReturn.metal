#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
struct Uniforms {
    float4 colorGreen;
    float4 colorRed;
};
struct Inputs {
};
struct Outputs {
    float4 sk_FragColor [[color(0)]];
};
struct Globals {
    int scratchVar;
};
bool test_flat_b() {
    return true;
}
bool test_if_b(Uniforms _uniforms, thread Globals& _globals) {
    if (_uniforms.colorGreen.y > 0.0) {
        return true;
    } else {
        ++_globals.scratchVar;
    }
    ++_globals.scratchVar;
    return false;
}
bool test_else_b(Uniforms _uniforms) {
    if (_uniforms.colorGreen.y == 0.0) {
        return false;
    } else {
        return true;
    }
}
bool test_loop_return_b(thread Globals& _globals) {
    for (int x = 0;x < 0; ++x) {
        return false;
    }
    ++_globals.scratchVar;
    return true;
}
bool test_loop_break_b(thread Globals& _globals) {
    for (int x = 0;x <= 1; ++x) {
        break;
    }
    ++_globals.scratchVar;
    return true;
}
bool test_loop_if_b(Uniforms _uniforms, thread Globals& _globals) {
    for (int x = 0;x <= 1; ++x) {
        if (_uniforms.colorGreen.y == 0.0) {
            return false;
        } else {
            return true;
        }
    }
    ++_globals.scratchVar;
    return true;
}
fragment Outputs fragmentMain(Inputs _in [[stage_in]], constant Uniforms& _uniforms [[buffer(0)]], bool _frontFacing [[front_facing]], float4 _fragCoord [[position]]) {
    Globals _globals{0};
    (void)_globals;
    Outputs _out;
    (void)_out;
    _out.sk_FragColor = ((((test_flat_b() && test_if_b(_uniforms, _globals)) && test_else_b(_uniforms)) && test_loop_return_b(_globals)) && test_loop_break_b(_globals)) && test_loop_if_b(_uniforms, _globals) ? _uniforms.colorGreen : _uniforms.colorRed;
    return _out;
}
