//
//  C7Flip.metal
//  ATMetalBand
//
//  Created by Condy on 2022/2/15.
//

#include <metal_stdlib>
using namespace metal;

kernel void C7Flip(texture2d<half, access::write> outputTexture [[texture(0)]],
                   texture2d<half, access::read> inputTexture [[texture(1)]],
                   constant float *horizontal [[buffer(0)]],
                   constant float *vertical [[buffer(1)]],
                   uint2 grid [[thread_position_in_grid]]) {
    const bool h = ((*horizontal) == 1.0) ? true : false;
    const bool v = ((*vertical) == 1.0) ? true : false;
    const uint x = h ? inputTexture.get_width() - 1 - grid.x : grid.x;
    const uint y = v ? inputTexture.get_height() - 1 - grid.y : grid.y;
    const half4 outColor = inputTexture.read(uint2(x, y));
    
    outputTexture.write(outColor, grid);
}
