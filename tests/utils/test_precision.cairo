// IMPORTS
use satoru::utils::precision;
use satoru::utils::precision::{
    FLOAT_PRECISION, FLOAT_PRECISION_SQRT, WEI_PRECISION, BASIS_POINTS_DIVISOR, FLOAT_TO_WEI_DIVISOR
};
use satoru::utils::i128::{i128, i128_new};

#[test]
fn test_apply_factor_u128() {
    let value: u128 = 10;
    let factor: u128 = 1_000_000_000_000_000_000_000_000;
    let result = precision::apply_factor_u128(value, factor);
    assert(result == 100000, 'should be 100000.');
}

#[test]
fn test_apply_factor_i128() {
    let value: u128 = 10;
    let factor: i128 = i128_new(1_000_000_000_000_000_000_000_000, true);
    let result = precision::apply_factor_i128(value, factor);
    assert(result == i128_new(100000, true), 'should be -1OOO0O.');
}

#[test]
fn test_apply_factor_roundup_magnitude_positive() {
    let value: u128 = 15;
    let factor: i128 = i128_new(30_000_000_000_000_000_000, false);
    let roundup_magnitude = true;
    let result = precision::apply_factor_roundup_magnitude(value, factor, roundup_magnitude);
    assert(result == i128_new(5, false), 'should be 5.');
}

#[test]
fn test_apply_factor_roundup_magnitude_negative() {
    let value: u128 = 15;
    let factor: i128 = i128_new(30_000_000_000_000_000_000, true);
    let roundup_magnitude = true;
    let result = precision::apply_factor_roundup_magnitude(value, factor, roundup_magnitude);
    assert(result == i128_new(5, true), 'should be -5.');
}

#[test]
fn test_apply_factor_roundup_magnitude_no_rounding() {
    let value: u128 = 15;
    let factor: i128 = i128_new(30_000_000_000_000_000_000, true);
    let roundup_magnitude = false;
    let result = precision::apply_factor_roundup_magnitude(value, factor, roundup_magnitude);
    assert(result == i128_new(4, true), 'should be -4.');
}

#[test]
fn test_mul_div_ival_negative() {
    let value: i128 = i128_new(42, true);
    let factor: u128 = 10;
    let denominator = 8;
    let result = precision::mul_div_ival(value, factor, denominator);
    assert(result == i128_new(52, true), 'should be -52.');
}

#[test]
fn test_mul_div_inum_positive() {
    let value: u128 = 42;
    let factor: i128 = i128_new(10, false);
    let denominator = 8;
    let result = precision::mul_div_inum(value, factor, denominator);
    assert(result == i128_new(52, false), 'should be 52.');
}

#[test]
fn test_mul_div_inum_roundup_negative() {
    let value: u128 = 42;
    let factor: i128 = i128_new(10, true);
    let denominator = 8;
    let result = precision::mul_div_inum_roundup(value, factor, denominator, true);
    assert(result == i128_new(53, true), 'should be -53.');
}

#[test]
fn test_mul_div_inum_roundup_positive() {
    let value: u128 = 42;
    let factor: i128 = i128_new(10, false);
    let denominator = 8;
    let result = precision::mul_div_inum_roundup(value, factor, denominator, true);
    assert(result == i128_new(53, false), 'should be 53.');
}

#[test]
fn test_to_factor_roundup() {
    let value: u128 = 450000;
    let divisor: u128 = 20_000_000_000_000_000_000_000_000; //2*10^25
    let roundup_magnitude = true;
    let result = precision::to_factor_roundup(value, divisor, roundup_magnitude);
    assert(result == 3, 'should be 3.');
}

#[test]
fn test_to_factor() {
    let value: u128 = 450000;
    let divisor: u128 = 20_000_000_000_000_000_000_000_000; // 2*10^25
    let result = precision::to_factor(value, divisor);
    assert(result == 2, 'should be 2.');
}

#[test]
fn test_to_factor_ival_positive() {
    let value: i128 = i128_new(450000, false);
    let divisor: u128 = 20_000_000_000_000_000_000_000_000; // 2*10^25
    let result = precision::to_factor_ival(value, divisor);
    assert(result == i128_new(2, false), 'from positive integer value.');
}

#[test]
fn test_to_factor_ival_negative() {
    let value: i128 = i128_new(450000, true);
    let divisor: u128 = 20_000_000_000_000_000_000_000_000; // 2*10^25
    let result = precision::to_factor_ival(value, divisor);
    assert(result == i128_new(2, true), 'should be -2.');
}

#[test]
fn test_float_to_wei() {
    let float_value: u128 = 1_000_000_000_000_000;
    let result = precision::float_to_wei(float_value);
    assert(result == 1000, 'should be 10^3');
}

#[test]
fn test_wei_to_float() {
    let wei_value: u128 = 10_000_000_000_000_000_000_000_000; //10^25
    let result = precision::wei_to_float(wei_value);
    assert(result == 10_000_000_000_000_000_000_000_000_000_000_000_000, 'should be 10^37');
}

#[test]
fn test_basis_points_to_float() {
    let basis_point: u128 = 1000;
    let result = precision::basis_points_to_float(basis_point);
    assert(result == 10_000_000_000_000_000_000, 'should be 10^19');
}
