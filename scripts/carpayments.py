for kontantinsats in [320]:
    kontantinsats *= 1000

    bilpris = 390 * 1000
    restvarde = bilpris * 0.0
    lanetid_månader = 6 * 12
    ranta_effektiv = (6.95 * 0.79 + 0.2) / 100

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
        "år",
    )
