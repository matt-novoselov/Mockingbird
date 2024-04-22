//
// Water.metal
// Inferno
// https://www.github.com/twostraws/Inferno
// See LICENSE for license information.
//

#include <metal_stdlib>
using namespace metal;

/// A shader that generates a water effect.
///
/// This works by pushing pixels around based on a simple algorithm: we pass
/// the original coordinate, speed, and frequency into the sin() and cos() functions
/// to get different numbers between -1 and 1, then multiply that by the user's
/// strength parameter to see how far away we should be moved.
///
/// - Parameter position: The user-space coordinate of the current pixel.
/// - Parameter time: The number of elapsed seconds since the shader was created
/// - Parameter size: The size of the whole image, in user-space.
/// - Parameter speed: How fast to make the water ripple. Ranges from 0.5 to 10
///   work best; try starting with 3.
/// - Parameter strength: How pronounced the rippling effect should be.
///   Ranges from 1 to 5 work best; try starting with 3.
/// - Parameter frequency: How often ripples should be created. Ranges from
///   5 to 25 work best; try starting with 10.
/// - Returns: The new pixel color.
[[ stitchable ]] float2 complexWave(float2 position, float time, float2 size, float speed, float strength, float frequency) {
    float2 normalizedPosition = position / size;
    float moveAmount = time * speed;

    position.x += sin((normalizedPosition.x + moveAmount) * frequency) * strength;
    position.y += cos((normalizedPosition.y + moveAmount) * frequency) * strength;

    return position;
}
