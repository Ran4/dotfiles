for kontantinsats in [200]:
    kontantinsats *= 1000

    bilpris = 744.3 * 1000

    with_restvärde = True
    if with_restvärde:
        restvarde = bilpris * 0.5
        lanetid_månader = 3 * 12

    else:
        restvarde = bilpris * 0.0
        lanetid_månader = 6 * 12

    ranta_effektiv = (2.95 * 0.79 + 0.2) / 100

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
