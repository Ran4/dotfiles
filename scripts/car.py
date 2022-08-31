import argparse
from typing import Optional

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
    extra: bool,
):
    print(
        "ratio",
        "down",
        "  ",
        "p.m(6yrs)",
        "p.m(7yrs)",
    )
    if extra:
        ratios = [0.2, 0.25, 0.3, 0.35, 0.4, 0.45, 0.5]

    else:
        ratios = [0.2, 0.3, 0.4, 0.5]

    for ratio in ratios:
        remaining = cost - cost * ratio
        # 1.12 is 4% over 6 years, 1.15 is 4% over 7 years
        six_years = (remaining / 6.0 / 12.0) * 1.12 + (insurance or 0)
        seven_years = (remaining / 7.0 / 12.0) * 1.15 + (insurance or 0)

        print(
            str(ratio).ljust(5),
            f"{cost * ratio:.1f}".ljust(7),
            f"{six_years:.1f}".ljust(9),
            f"{seven_years:.1f}",
        )


def main():
    parser = argparse.ArgumentParser(description="Calculate total car costs over time")
    parser.add_argument("start_cost_in_thousands", type=float)
    parser.add_argument("--insurance", type=float, default=None)
    parser.add_argument(
        "-e",
        "--extra",
        action="store_true",
        default=False,
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
