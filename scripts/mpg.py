#!/usr/bin/env python3
import sys

if len(sys.argv) < 2:
    print("Converts miles per gallon to km/100 L (both UK and US miles).")
    print()
    print("Usage:")
    print("  $ mpg 34")
    print("  30 UK mpg is 9.42 L/100 km (0.942 L/mil)")
    exit(2)

mpg = float(sys.argv[1])
km_per_uk_gallon = mpg * 1.609
km_per_liter_uk = km_per_uk_gallon / 4.546
liter_per_100_km_uk = 100 / km_per_liter_uk

km_per_us_gallon = mpg * 1.609
km_per_liter_us = km_per_us_gallon / 4.546
liter_per_100_km_us = 100 * 3.785411784 / (1.609344 * mpg)
print(
    f"{mpg} UK mpg is {liter_per_100_km_uk:.2f} L/100 km"
    f" ({0.1*liter_per_100_km_uk:.2f} L/mil)"
)
print(
    f"{mpg} US mpg is {liter_per_100_km_us:.2f} L/100 km"
    f" ({0.1*liter_per_100_km_us:.2f} L/mil)"
)
