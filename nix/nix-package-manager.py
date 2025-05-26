import os
import sys
import json
import click
from pathlib import Path

script_dir = Path(__file__).parent
packages_file = script_dir / "packages.json"


def save(packages):
    json.dump(packages, packages_file.open("w"), indent=2)


def load():
    return json.load(packages_file.open())


def eprint(*args, **kwargs):
    print(*args, file=sys.stderr, **kwargs)


def darwin_rebuild():
    return os.system(f"darwin-rebuild switch --flake {script_dir}")


@click.group()
def main():
    pass


@main.command()
@click.argument("names", nargs=-1)
def add(names: tuple[str, ...]):
    original = load()
    packages = load()

    for name in names:
        if name in packages:
            eprint(f"Package '{name}' already installed")
            sys.exit(1)

    for name in names:
        ret = os.system(f"nix search nixpkgs#{name} ^")
        if ret != 0:
            sys.exit(1)
        packages.append(name)

    save(packages)

    ret = darwin_rebuild()
    if ret != 0:
        eprint("Failed to install package(s), rebuild failed")
        save(original)
        sys.exit(1)

    print(f"\nPackage(s) {', '.join(names)} installed")


@main.command()
@click.argument("names", nargs=-1)
def remove(names: tuple[str, ...]):
    original = load()
    packages = load()

    for name in names:
        if name not in packages:
            eprint(f"Package '{name}' is not installed")
            sys.exit(1)

    for name in names:
        packages.remove(name)
    save(packages)

    ret = darwin_rebuild()
    if ret != 0:
        eprint("Failed to remove package, rebuild failed")
        save(original)
        sys.exit(1)

    print(f"\nPackage {', '.join(names)} removed")


@main.command()
def upgrade():
    ret = os.system(f"nix flake update --flake {script_dir}")
    if ret != 0:
        sys.exit(1)

    ret = darwin_rebuild()
    if ret != 0:
        eprint("Failed to upgrade packages, rebuild failed")
        sys.exit(1)

    print("\nPackages upgraded")


@main.command()
def rebuild():
    ret = darwin_rebuild()
    if ret != 0:
        eprint("Failed to rebuild packages")
        sys.exit(1)

    print("\nPackages rebuilt")


@main.command()
def clean():
    ret = os.system("nix-store --gc")
    if ret != 0:
        sys.exit(1)


if __name__ == "__main__":
    main()
