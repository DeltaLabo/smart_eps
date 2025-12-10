import zipfile
import shutil
from pathlib import Path

# Folder that contains your SysON exports
SYSON_DIR = Path("sysON")

# DELETE TARGET:
PROJECT_DIR = SYSON_DIR / "smartEPS"   # <--- delete this folder before extract


def extract_zip(zip_path: Path, dest_dir: Path) -> None:
    """Extract a single zip file into dest_dir."""
    dest_dir.mkdir(parents=True, exist_ok=True)
    with zipfile.ZipFile(zip_path, "r") as z:
        z.extractall(dest_dir)


def main():
    if not SYSON_DIR.exists():
        print(f"❌ Folder '{SYSON_DIR}' not found. Create it and put your SysON .zip files there.")
        return
    
    # -----------------------------------------
    #   DELETE sysON/smartEPS BEFORE EXTRACTING
    # -----------------------------------------
    if PROJECT_DIR.exists():
        print(f"🗑️  Deleting old folder: {PROJECT_DIR}")
        shutil.rmtree(PROJECT_DIR)
    else:
        print(f"ℹ️ No previous '{PROJECT_DIR.name}' folder found. Starting fresh.")
    # -----------------------------------------

    zip_files = sorted(SYSON_DIR.glob("*.zip"))

    if not zip_files:
        print(f"ℹ️ No .zip files found in '{SYSON_DIR}'.")
        return

    print(f"🔍 Found {len(zip_files)} zip file(s) in '{SYSON_DIR}':")
    for z in zip_files:
        print(f"  - {z.name}")

    for zip_path in zip_files:
        dest_dir = SYSON_DIR.with_suffix("")  

        print(f"📦 Extracting '{zip_path.name}' → '{dest_dir.name}' ...")
        try:
            extract_zip(zip_path, dest_dir)
            print(f"✅ Done: '{zip_path.name}'")
        except zipfile.BadZipFile:
            print(f"❌ Error: '{zip_path.name}' is not a valid ZIP archive.")
        except Exception as e:
            print(f"❌ Unexpected error extracting '{zip_path.name}': {e}")

    print("✨ Finished processing all .zip files in 'sysON'.")

if __name__ == "__main__":
    main()