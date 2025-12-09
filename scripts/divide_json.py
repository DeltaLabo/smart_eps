import json
import shutil
from pathlib import Path
import re

dir = Path("sysON/smartEPS/documents")

file = list(dir.glob("*.json"))

dst_dir = Path("model")

# Remove everything inside dst_dir
for item in dst_dir.iterdir():
    if item.is_file() or item.is_symlink():
        item.unlink()
    else:
        shutil.rmtree(item)

with file[0].open(encoding="utf-8") as f:
    data = json.load(f)

print("Destination directory cleaned.")

def iter_elements(obj):
    """Recursively yield all SysML elements that have eClass + data."""
    if isinstance(obj, dict):
        if "eClass" in obj and "data" in obj:
            yield obj
        for v in obj.values():
            yield from iter_elements(v)
    elif isinstance(obj, list):
        for item in obj:
            yield from iter_elements(item)


def slug(s: str) -> str:
    s = s.strip().replace(" ", "_")
    return re.sub(r"[^0-9A-Za-z_]+", "", s)


# Walk EVERYTHING
elements = list(iter_elements(data))

print(f"Found {len(elements)} total elements")

# ---------- Write out named elements ----------
for el in elements:
    eclass = el.get("eClass", "")
    dat = el.get("data", {})

    name = (
        dat.get("declaredName")
        or dat.get("shortName")
        or dat.get("name")
        or "anonymous"
    )

    kind = eclass.split(":")[-1] if ":" in eclass else "Element"
    filename = f"{kind}_{slug(name)}.json"

    out = dst_dir / filename
    with out.open("w", encoding="utf-8") as f:
        json.dump(el, f, indent=2, sort_keys=True)

print("Done!")