for bilpris in [
    # 744.709 + 60,
    630,
]:
    bilpris *= 1000
    for with_restvärde, restvärde_multiplier, lanetid_månader in [
        # (True, 0.55, 3 * 12),
        (True, 0.25, 5 * 12),
        # (True, 0.1, 6 * 12),
        # (False, 0.0, 4 * 12),
        # (False, 0.0, 6 * 12),
    ]:
        for kontantinsats in [
            175,  # + 12 * 19,
        ]:
            kontantinsats *= 1000

            # bilpris = 661 * 1000
            restvarde = bilpris * restvärde_multiplier

            # ranta_effektiv = (2.95 * 0.79 + 0.05) / 100
            # ranta_effektiv = (3.95 * 0.79 + 0.05) / 100
            # ranta_effektiv = (4.95 * 0.79 + 0.1) / 100
            # ranta_effektiv = (4.95 * 0.79 + 0.2) / 100
            ranta_effektiv = (4.95 * 1.0 + 0.2) / 100

            manadsranta = (1 + ranta_effektiv) ** (1 / 12) - 1
            lanebelopp = bilpris - kontantinsats  # kr
            manadsbetalning = (
                lanebelopp - restvarde / (1 + manadsranta) ** lanetid_månader
            ) * (manadsranta / (1 - (1 + manadsranta) ** -lanetid_månader))

            print(
                "Kontantinsats",
                kontantinsats // 1000,
                "tkr ger",
                round(manadsbetalning),
                "kr/mån i",
                round(lanetid_månader / 12)
                if (lanetid_månader / 12).is_integer()
                else round(lanetid_månader / 12, 2),
                "år (med restvärde)" if with_restvärde else "år",
            )
    print()
