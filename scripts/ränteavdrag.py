#!/usr/bin/env python3
nuvarande_skuld = 6526


def adjusted(xs):
    return [(x + 0.0, y) for x, y in xs]


tkr_per_måns = []
for ränta_i_procent, kontext in adjusted(
    [
        (4.19, ""),
        (3.87, "2024 kv4"),
        (3.52, "2025 kv1"),
        (3.27, "2025 kv2"),
    ]
):
    årsränta = nuvarande_skuld * ränta_i_procent / 100.0
    print(f"årsränta givet {ränta_i_procent}% ränta: {årsränta:.2f} tkr")

    ränteavdrag_första_200k = min(200, årsränta) * 0.3
    ränteavdrag_resten = max(0, årsränta - 200) * 0.21
    ränteavdrag_per_år = ränteavdrag_första_200k + ränteavdrag_resten

    print(
        f"  ränteavdrag_per_år: {ränteavdrag_per_år:.2f} tkr, {ränteavdrag_per_år/12:.2f} tkr/mån"
    )
    tkr_per_måns.append(
        (
            ränta_i_procent,
            tkr_per_mån := (årsränta - ränteavdrag_per_år) / 12,
        )
    )
    print(
        f"  ränta efter ränteavdrag: {årsränta - ränteavdrag_per_år:.2f} tkr"
        f", {tkr_per_mån:.2f} tkr/mån"
    )
    print()

for i in range(len(tkr_per_måns) - 1):
    old = tkr_per_måns[0][0]
    new = tkr_per_måns[i + 1][0]
    diff = tkr_per_måns[i + 1][1] - tkr_per_måns[0][1]
    print(f"{old}% -> {new}%: {diff:.2f} tkr/mån efter ränteavdrag")
