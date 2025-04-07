import argparse
from typing import Optional, List

NumYears = int
DEFAULT_RATES: dict[NumYears, float] = {
    3: 1.067,  # 3 years at 5.5% has ratio 1.067 AFTER ränteavdrag
    4: 1.089,  # 4 years at 5.5% has ratio 1.089 AFTER ränteavdrag
    6: 1.132,  # 6 years at 5.5% has ratio 1.132 AFTER ränteavdrag
    7: 1.154,  # 7 years at 5.5% has ratio 1.154 AFTER ränteavdrag
}


def print_costs(
    cost: float,
    insurance: Optional[float],
    extra: int,  # 0, 1 or 2
    rates: dict[int, float] = DEFAULT_RATES,
):
    assert 0 <= extra <= 2, "extra must be between 0 and 2 inclusive"
    print(
        "ratio",
        "down",
        "  ",
        "p.m(3yrs)",
        "p.m(4yrs)",
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
        """
        To calculate:

        ränta = 0.095
        lån = 453.5
        for NUM_YEARS in [6, 7]:
            NUM_MONTHS = NUM_YEARS * 12
            vals = [
                (lån / NUM_MONTHS, 0.79 * ((lån * (1 - mån / NUM_MONTHS)) * ränta / 12))
                for mån in range(NUM_MONTHS)
            ]
            ratio: float = sum([amort + ränta for amort, ränta in vals]) / lån
            print(f"{NUM_YEARS} years has ratio {ratio:.3f}")
        """
        three_years = (remaining / 3.0 / 12.0) * rates[3] + (insurance or 0)
        four_years = (remaining / 4.0 / 12.0) * rates[4] + (insurance or 0)
        six_years = (remaining / 6.0 / 12.0) * rates[6] + (insurance or 0)
        seven_years = (remaining / 7.0 / 12.0) * rates[7] + (insurance or 0)

        print(
            str(ratio).ljust(5),
            f"{cost * ratio:.1f}".ljust(7),
            f"{three_years:.1f}".ljust(9),
            f"{four_years:.1f}".ljust(9),
            f"{six_years:.1f}".ljust(9),
            f"{seven_years:.1f}",
        )


def main():
    parser = argparse.ArgumentParser(
        description="Calculate total car costs over time",
    )
    parser.add_argument(
        "start_cost_in_thousands",
        # We can for example give "395+18" instead of 313
        type=lambda s: float(eval(s)),
    )
    parser.add_argument("--insurance", type=float, default=None)
    parser.add_argument(
        "-e",
        "--extra",
        action="count",
        default=0,
    )
    parser.add_argument(
        "-6",
        "--six-year-rate",
        default=None,
    )
    parser.add_argument(
        "-7",
        "--seven-year-rate",
        default=None,
    )
    args = parser.parse_args()

    rates = DEFAULT_RATES
    if args.six_year_rate:
        rates[6] = float(args.six_year_rate)

    if args.seven_year_rate:
        rates[7] = float(args.seven_year_rate)

    rates = DEFAULT_RATES

    cost: float = args.start_cost_in_thousands

    print_costs(cost, insurance=None, extra=args.extra)
    if args.insurance is not None:
        insurance: float = args.insurance
        print(f"\n## With insurance ({insurance}k/m):")
        print_costs(
            cost,
            insurance=insurance,
            extra=args.extra,
            rates=rates,
        )


if __name__ == "__main__":
    main()
