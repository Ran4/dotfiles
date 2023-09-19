årsränta = 6726 * 0.0419
print(f"årsränta: {årsränta:.2f} tkr")

ränteavdrag_första_200k = min(200, årsränta) * 0.3
ränteavdrag_resten = max(0, årsränta - 200) * 0.21
ränteavdrag_per_år = ränteavdrag_första_200k + ränteavdrag_resten

print(f"ränteavdrag_per_år: {ränteavdrag_per_år:.2f} tkr, {ränteavdrag_per_år/12:.2f} tkr/mån")
print(
    f"ränta efter ränteavdrag: {årsränta - ränteavdrag_per_år:.2f} tkr"
    f", {(årsränta - ränteavdrag_per_år) / 12:.2f} tkr/mån"
)
