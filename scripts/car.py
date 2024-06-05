import argparse
from typing import Optional, List

"""
x = 300

ränta = sum([
    ((1/12.0)) * ((x * (1 - i/(7*12))) * 0.04)
    for i in range(7*12)
])

total = 300 + ränta
ratio = total / 300
print("total:", total)
print("ratio", ratio)
"""


def print_costs(
    cost: float,
    insurance: Optional[float],
    extra: int,  # 0, 1 or 2
):
    assert 0 <= extra <= 2, "extra must be between 0 and 2 inclusive"
    print(
        "ratio",
        "down",
        "  ",
        "p.m(6yrs)",
        "p.m(7yrs)",
    )
    ratios = [0.2, 0.25, 0.3, 0.35, 0.4, 0.45, 0.5, 0.55, 0.6, 0.65]

    if extra > 0:
        # Put a ratio between each previous ratio
        ratios_inbetween: List[float] = [
            (ratios[i] + ratios[i + 1]) / 2.0 for i in range(len(ratios) - 1)
        ]
        new_ratios = []
        for ratio, ratio_after in zip(ratios, ratios_inbetween):
            new_ratios.extend([ratio, round(ratio_after, 3)])
        ratios = new_ratios
        if extra > 1:
            # Include values under 20%
            ratios = [0.1, 0.125, 0.15, 0.175] + ratios

    for ratio in ratios:
        remaining = cost - cost * ratio
        # 1.245 is 10% (effective) over 6 years
        # 1.31 is 10% (effective) over 7 years
        six_years = (remaining / 6.0 / 12.0) * 1.245 + (insurance or 0)
        seven_years = (remaining / 7.0 / 12.0) * 1.31 + (insurance or 0)

        print(
            str(ratio).ljust(5),
            f"{cost * ratio:.1f}".ljust(7),
            f"{six_years:.1f}".ljust(9),
            f"{seven_years:.1f}",
        )


def main():
    parser = argparse.ArgumentParser(
        description="Calculate total car costs over time",
    )
    parser.add_argument("start_cost_in_thousands", type=float)
    parser.add_argument("--insurance", type=float, default=None)
    parser.add_argument(
        "-e",
        "--extra",
        action="count",
        default=0,
    )
    args = parser.parse_args()

    cost: float = args.start_cost_in_thousands

    print_costs(cost, insurance=None, extra=args.extra)
    if args.insurance is not None:
        insurance: float = args.insurance
        print(f"\n## With insurance ({insurance}k/m):")
        print_costs(cost, insurance=insurance, extra=args.extra)


if __name__ == "__main__":
    main()
